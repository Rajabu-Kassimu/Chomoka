import 'package:chomoka/view/dashboard/meetings/new_meeting/vsla/buy_share/share_summary.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:chomoka/model/KatibaModel.dart';
import 'package:chomoka/model/MemberShareModel.dart';
import 'package:chomoka/model/BaseModel.dart';
import 'package:chomoka/l10n/app_localizations.dart';

import 'package:provider/provider.dart';
import 'package:chomoka/providers/currency_provider.dart';
import 'package:chomoka/utils/currency_formatter.dart';

class BuyShare extends StatefulWidget {
  final int? userId;
  final String? userName;
  final int? meetingId;
  final int? mzungukoId;
  final int? memberNumber;
  final bool? editingMode;

  const BuyShare({
    super.key,
    this.userId,
    this.userName,
    this.meetingId,
    this.mzungukoId,
    this.memberNumber,
    this.editingMode = false,
  });

  @override
  State<BuyShare> createState() => _BuyShareState();
}

class _BuyShareState extends State<BuyShare> {
  Set<int> selectedShares = {};
  int shareValue = 0;
  int totalSharesInMzunguko = 0;
  int totalSharesInMeeting = 0;
  int totalValueInMeeting = 0;

  // Grid configuration
  final int rows = 2;
  final int columns = 3;

  @override
  void initState() {
    super.initState();
    _initializeAndLoadData();
  }

  // New method to initialize database before loading data
  Future<void> _initializeAndLoadData() async {
    try {
      // Initialize the database first
      await BaseModel.initAppDatabase();
      // Then load the member data
      await _loadMemberData();
    } catch (e) {
      print('Error initializing database: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Kuna hitilafu imetokea wakati wa kuanza: $e')),
      );
    }
  }

  Future<void> _loadMemberData() async {
    try {
      // Fetch share value from KatibaModel
      final katiba = KatibaModel();
      final shareData = await katiba
          .where('katiba_key', '=', 'share_amount')
          .where('mzungukoId', '=', widget.mzungukoId)
          .findOne();

      int fetchedShareValue = 0;
      if (shareData != null && shareData is KatibaModel) {
        fetchedShareValue =
            int.tryParse(shareData.value?.toString() ?? '0') ?? 0;
      }

      // Fetch user's existing shares for this mzunguko (across all meetings)
      final memberShareModel = MemberShareModel();
      final existingSharesInMzunguko = await memberShareModel
          .where('user_id', '=', widget.userId)
          .where('mzungukoId', '=', widget.mzungukoId)
          .find();

      // Fetch user's shares for this specific meeting
      final existingSharesInMeeting = await memberShareModel
          .where('user_id', '=', widget.userId)
          .where('meeting_id', '=', widget.meetingId)
          .find();

      int userTotalSharesInMzunguko = 0;
      if (existingSharesInMzunguko.isNotEmpty) {
        for (var share in existingSharesInMzunguko) {
          if (share is MemberShareModel) {
            userTotalSharesInMzunguko += share.numberOfShares ?? 0;
          }
        }
      }

      int userTotalSharesInMeeting = 0;
      if (existingSharesInMeeting.isNotEmpty) {
        for (var share in existingSharesInMeeting) {
          if (share is MemberShareModel) {
            userTotalSharesInMeeting += share.numberOfShares ?? 0;
          }
        }
      }

      setState(() {
        shareValue = fetchedShareValue;
        totalSharesInMzunguko = userTotalSharesInMzunguko;
        totalSharesInMeeting = userTotalSharesInMeeting;
        totalValueInMeeting = totalSharesInMeeting * shareValue;
      });
    } catch (e) {
      print('Error loading member data: $e');
      setState(() {
        shareValue = 0; // Default value is now 0
      });
    }
  }

  void _selectShare(int index) {
    setState(() {
      if (selectedShares.contains(index)) {
        selectedShares.remove(index);
      } else {
        selectedShares.add(index);
      }
      totalValueInMeeting =
          (totalSharesInMeeting + selectedShares.length) * shareValue;
    });
  }

  void _selectAllShares() {
    setState(() {
      if (selectedShares.length == (rows * columns - 1)) {
        // If all are selected, deselect all
        selectedShares.clear();
      } else {
        // Otherwise select all
        selectedShares =
            Set.from(List.generate(rows * columns - 1, (index) => index + 1));
      }
      // Update total value based on selected shares
      totalValueInMeeting =
          (totalSharesInMeeting + selectedShares.length) * shareValue;
    });
  }

  Future<void> _submitSharePurchase() async {
    try {
      if (selectedShares.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Tafadhali chagua hisa angalau moja')),
        );
        return;
      }

      // Save to MemberShareModel with both meetingId and mzungukoId
      await MemberShareModel(
        meetingId: widget.meetingId,
        mzungukoId: widget.mzungukoId,
        userId: widget.userId,
        numberOfShares: selectedShares.length,
      ).create();

      // Return the selected shares data
      final result = {
        'userId': widget.userId,
        'name': widget.userName,
        'shares': selectedShares.length,
        'amount': selectedShares.length * shareValue,
      };

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Umefanikiwa kununua hisa ${selectedShares.length}')),
      );
      Navigator.pop(context, result);
    } catch (e) {
      print('Error saving share purchase: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Kuna hitilafu imetokea: $e')),
      );
    }
  }

  Future<void> _addShares(int numberOfShares) async {
    try {
      // Create a new share record
      await MemberShareModel(
        meetingId: widget.meetingId,
        mzungukoId: widget.mzungukoId,
        userId: widget.userId,
        numberOfShares: numberOfShares,
      ).create();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Umefanikiwa kuongeza hisa $numberOfShares')),
      );

      // Reload data to update UI
      await _loadMemberData();
    } catch (e) {
      print('Error adding shares: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Kuna hitilafu imetokea: $e')),
      );
    }
  }

  Future<void> _removeShares(int numberOfShares) async {
    try {
      if (numberOfShares > totalSharesInMeeting) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Huwezi kupunguza hisa zaidi ya zilizopo')),
        );
        return;
      }

      // Find existing share records for this meeting
      final memberShareModel = MemberShareModel();
      final existingShares = await memberShareModel
          .where('user_id', '=', widget.userId)
          .where('meeting_id', '=', widget.meetingId)
          .find();

      int sharesToRemove = numberOfShares;

      // Remove shares from existing records
      for (var share in existingShares) {
        if (sharesToRemove <= 0) break;

        if (share is MemberShareModel && share.id != null) {
          int currentShares = share.numberOfShares ?? 0;

          if (currentShares <= sharesToRemove) {
            // Delete this record completely
            await memberShareModel.where('id', '=', share.id).delete();
            sharesToRemove -= currentShares;
          } else {
            // Update this record with reduced shares
            final updatedShares = currentShares - sharesToRemove;
            await memberShareModel
                .where('id', '=', share.id)
                .update({'number_of_shares': updatedShares});
            sharesToRemove = 0;
          }
        }
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Umefanikiwa kupunguza hisa $numberOfShares')),
      );

      // Reload data to update UI
      await _loadMemberData();
    } catch (e) {
      print('Error removing shares: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Kuna hitilafu imetokea: $e')),
      );
    }
  }

  Future<void> _deleteAllShares() async {
    try {
      // Find all share records for this meeting
      final memberShareModel = MemberShareModel();
      final existingShares = await memberShareModel
          .where('user_id', '=', widget.userId)
          .where('meeting_id', '=', widget.meetingId)
          .find();

      // Delete all found records
      for (var share in existingShares) {
        if (share is MemberShareModel && share.id != null) {
          await memberShareModel.where('id', '=', share.id).delete();
        }
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Umefanikiwa kufuta hisa zote za leo')),
      );

      // Reload data to update UI
      await _loadMemberData();
    } catch (e) {
      print('Error deleting all shares: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Kuna hitilafu imetokea: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: CustomAppBar(
        title: l10n.hisa,
        subtitle: l10n.hesabuYaHisa,
        showBackArrow: true,
      ),
      body: Column(
        children: [
          // Member info card
          Card(
            margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.grey[300],
                    child:
                        Icon(Icons.person, size: 30, color: Colors.grey[600]),
                  ),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'No. ${widget.memberNumber?.toString() ?? ''}',
                            style: TextStyle(
                              fontSize: 16,
                              color: const Color.fromARGB(255, 255, 102, 0),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 8),
                          Text(
                            widget.userName ?? '',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Current share value (for this meeting)
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 24.0),
            child: Center(
              child: Text(
                formatCurrency(totalValueInMeeting, Provider.of<CurrencyProvider>(context).currencyCode),
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[600],
                ),
              ),
            ),
          ),

          // Total shares info (for all meetings in mzunguko)
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.grey[300]!),
                bottom: BorderSide(color: Colors.grey[300]!),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  l10n.jumlaYaAkiba,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Flexible(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '$totalSharesInMzunguko',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.set_meal, size: 16),
                      SizedBox(width: 8),
                      Text(
                        formatCurrency(totalSharesInMzunguko * shareValue, Provider.of<CurrencyProvider>(context).currencyCode),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (widget.editingMode == true)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.grey[300]!),
                  bottom: BorderSide(color: Colors.grey[300]!),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        l10n.hisaAlizonunuaLeo,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            '$totalSharesInMeeting',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(Icons.set_meal, size: 16),
                          SizedBox(width: 8),
                          Text(
                            formatCurrency(totalSharesInMeeting * shareValue, Provider.of<CurrencyProvider>(context).currencyCode),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 8),
                          GestureDetector(
                            onTap: () {
                              _showEditOptions(context);
                            },
                            child: Icon(
                              Icons.edit,
                              size: 20,
                              color: Colors.blue[700],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

          // Share selection title with select all button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    l10n.chaguaIdadiYaHisaZaKununua,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (widget.editingMode == false)
                  GestureDetector(
                    onTap: _selectAllShares,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.blue[700],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        l10n.chaguaZote,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // Share selection grid
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: columns,
                  childAspectRatio: 1.5,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: rows * columns,
                itemBuilder: (context, index) {
                  final shareNumber = index + 1;
                  final isSelected = selectedShares.contains(shareNumber);

                  // Last item is "Ruka" (Skip)
                  if (index == rows * columns - 1) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[300]!),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Center(
                          child: Text(
                            l10n.ruka,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                  return GestureDetector(
                    onTap: () => widget.editingMode == false
                        ? _selectShare(shareNumber)
                        : null,
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.green : Colors.white,
                        border: Border.all(color: Colors.grey[300]!),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.set_meal, // Changed to fish icon
                          color: isSelected ? Colors.white : Colors.grey[400],
                          size: 32,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          // Selected shares counter
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  l10n.hisaZilizochaguliwa,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '${selectedShares.length}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8),

          if (widget.editingMode == false)
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed:
                    selectedShares.isNotEmpty ? _submitSharePurchase : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 4, 34, 207),
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                ),
                child: Text(
                  l10n.endelea,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          if (widget.editingMode == true)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Color.fromARGB(255, 4, 34, 207), // Green color
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ShareSummary(
                          meetingId: widget.meetingId,
                          mzungukoId: widget.mzungukoId,
                        ),
                      ),
                    );
                  },
                  child: Text(
                    l10n.finish,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  // Move these methods inside the _BuyShareState class
  void _showEditOptions(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext bc) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Text(
                  l10n.badilishaHisa,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                leading: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(Icons.add_circle, color: Colors.green),
                ),
                title: Text(l10n.ongezaHisa),
                subtitle: Text(l10n.ongezaHisaZaidiKwaMwanachama),
                onTap: () {
                  Navigator.pop(context);
                  _showNumberInputDialog(context, 'ongeza');
                },
              ),
              Divider(height: 1),
              ListTile(
                leading: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(Icons.remove_circle, color: Colors.orange),
                ),
                title: Text(l10n.punguzaHisa),
                subtitle: Text(l10n.punguzaIdadiYaHisaZaMwanachama),
                onTap: () {
                  Navigator.pop(context);
                  _showNumberInputDialog(context, 'punguza');
                },
              ),
              Divider(height: 1),
              ListTile(
                leading: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(Icons.delete, color: Colors.red),
                ),
                title: Text(l10n.futaZote),
                subtitle: Text(l10n.futaHisaZoteZaLeo),
                onTap: () {
                  Navigator.pop(context);
                  _confirmDeleteAllShares(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showNumberInputDialog(BuildContext context, String action) {
    final l10n = AppLocalizations.of(context)!;
    final TextEditingController controller = TextEditingController();
    final isAddAction = action == 'ongeza';
    final title = isAddAction ? l10n.ongezaHisa : l10n.punguzaHisa;
    final buttonText = isAddAction ? l10n.ongeza : l10n.punguza;
    final buttonColor = isAddAction ? Colors.green : Colors.orange;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          insetPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      isAddAction ? Icons.add_circle : Icons.remove_circle,
                      color: buttonColor,
                    ),
                    SizedBox(width: 10),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Text(
                  isAddAction
                      ? l10n.ingizaIdadiYaHisaUnezotakaKununua
                      : l10n.ingizaIdadiYaHisaUnezotakaKupunguza,
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: controller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: l10n.idadiYaHisa,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    prefixIcon: Icon(Icons.set_meal),
                    filled: true,
                    fillColor: Colors.grey[100],
                  ),
                ),
                SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      child: Text(
                        l10n.ghairi,
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    SizedBox(width: 8),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: buttonColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        buttonText,
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        final int? number = int.tryParse(controller.text);
                        if (number != null && number > 0) {
                          if (isAddAction) {
                            _addShares(number);
                          } else {
                            _removeShares(number);
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(l10n.tafadhaliIngizaNambaSahihi),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _confirmDeleteAllShares(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              Icon(Icons.warning_amber_rounded, color: Colors.red),
              SizedBox(width: 10),
              Text('Futa Hisa Zote'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: Colors.red),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Una uhakika unataka kufuta hisa zote za leo?',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Hapana',
                style: TextStyle(color: Colors.grey[700]),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Ndio, Futa',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                _deleteAllShares();
              },
            ),
          ],
        );
      },
    );
  }
}
