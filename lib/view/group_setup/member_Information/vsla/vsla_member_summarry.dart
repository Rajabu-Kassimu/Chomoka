import 'dart:io';
import 'dart:convert';
import 'package:chomoka/model/AkibaHiariModel.dart';
import 'package:chomoka/model/AkibaLazimaModel.dart';
import 'package:chomoka/model/GroupMemberModel.dart';
import 'package:chomoka/model/MzungukoModel.dart';
import 'package:chomoka/model/PasswordModel.dart';
import 'package:chomoka/model/RejeshaMkopoModel.dart';
import 'package:chomoka/model/ToaAkibaHiari.dart';
import 'package:chomoka/model/UchangiajiMfukoJamiiModel.dart';
import 'package:chomoka/model/UserFainiModel.dart';
import 'package:chomoka/Service/sms_server.dart';
import 'package:chomoka/model/KatibaModel.dart';
import 'package:chomoka/model/MemberShareModel.dart';
import 'package:chomoka/view/group_setup/member_Information/member_Info.dart';
import 'package:chomoka/view/group_setup/member_Information/member_identity.dart';
import 'package:chomoka/view/group_setup/member_Information/member_list.dart';
import 'package:chomoka/view/group_setup/member_Information/member_list_dashboard.dart';
import 'package:chomoka/view/group_setup/member_Information/member_photo.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:chomoka/model/BaseModel.dart';
import 'package:chomoka/l10n/app_localizations.dart';

import 'package:provider/provider.dart';
import 'package:chomoka/providers/currency_provider.dart';
import 'package:chomoka/utils/currency_formatter.dart';

class VslaMemberSummaryPage extends StatefulWidget {
  final int? groupId;
  final int? mzungukoId;
  final int? userId;
  final bool isUpdateMode;
  final bool fromDashboard;
  final bool fromHomePage;

  VslaMemberSummaryPage({
    Key? key,
    this.groupId,
    this.mzungukoId,
    this.userId,
    this.isUpdateMode = false,
    this.fromDashboard = false,
    this.fromHomePage = false,
  }) : super(key: key);

  @override
  State<VslaMemberSummaryPage> createState() => _VslaMemberSummaryPageState();
}

class _VslaMemberSummaryPageState extends State<VslaMemberSummaryPage>
    with SingleTickerProviderStateMixin {
  File? _selectedImage;
  GroupMembersModel? _userData;
  bool isLoading = true;
  late TabController _tabController;
  double _akibaLazimaTotal = 0;
  double _akibaHiariTotal = 0;
  double _mfukoJamiiTotal = 0;
  double _mkopoWasasaTotal = 0;
  double _fainiTotal = 0;
  double _salioTotal = 0;
  double mzungukoId = 0;
  double totalAkiba = 0;
  bool isPasswordSetupComplete = false;
  bool _isMzungukoPending = false;
  int _totalSharesCount = 0;
  double _shareValue = 0.0;
  double _totalSharesValue = 0.0;

  Future<void> _fetchUserData() async {
    try {
      final groupMembersModel = GroupMembersModel();
      final result =
          await groupMembersModel.where('id', '=', widget.userId).findOne();

      setState(() {
        _userData = result as GroupMembersModel?;
        if (_userData?.memberImage != null) {
          _selectedImage = File(_userData!.memberImage!);
        }
        isLoading = false;
      });

      await _fetchMzungukoId();
    } catch (e) {
      print('Error fetching user data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _fetchAkibaLazimaTotalForUser(int userId) async {
    try {
      final akibaLazimaModel = AkibaLazimaModel();
      final result = await akibaLazimaModel
          .where('user_id', '=', userId)
          .where('mzungukoId', '=', widget.mzungukoId)
          .select();

      double sum = 0;
      if (result.isNotEmpty) {
        sum = result
            .map((entry) => (entry['amount'] ?? 0) as double)
            .fold(0, (prev, element) => prev + element);
      }

      setState(() {
        _akibaLazimaTotal = sum;
      });
      print('Akiba Lazima for user $userId: $_akibaLazimaTotal');
    } catch (e) {
      print('Error fetching Akiba Lazima total for user $userId: $e');
      setState(() {
        _akibaLazimaTotal = 0; // Fallback
      });
    }
  }

  Future<void> _fetchAkibaHiariTotalForUser(int userId) async {
    try {
      final akibaHiariModel = AkibaHiari();
      final result = await akibaHiariModel
          .where('user_id', '=', userId)
          .where('mzungukoId', '=', widget.mzungukoId)
          .select();

      double sum = 0;
      if (result.isNotEmpty) {
        sum = result
            .map((entry) => (entry['amount'] ?? 0).toDouble())
            .fold(0, (prev, element) => prev + element);
      }

      setState(() {
        _akibaHiariTotal = sum;
      });
      print('Akiba Hiari for user $userId: $_akibaHiariTotal');
    } catch (e) {
      print('Error fetching Akiba Hiari total for user $userId: $e');
      setState(() {
        _akibaHiariTotal = 0;
      });
    }
  }

  Future<void> _fetchMfukoJamiiTotalForUser(int userId) async {
    try {
      final uchangiajiMfukoJamiiModel = UchangaajiMfukoJamiiModel();
      final result = await uchangiajiMfukoJamiiModel
          .where('user_id', '=', userId)
          .where('mzungukoId', '=', widget.mzungukoId)
          .select();

      double sum = 0;
      if (result.isNotEmpty) {
        sum = result
            .map((entry) => (entry['total'] ?? 0) as double)
            .fold(0, (prev, element) => prev + element);
      }

      setState(() {
        _mfukoJamiiTotal = sum;
      });
      print('Mfuko Jamii for user $userId: $_mfukoJamiiTotal');
    } catch (e) {
      print('Error fetching MfukoJamii total for user $userId: $e');
      setState(() {
        _mfukoJamiiTotal = 0;
      });
    }
  }

  Future<void> _fetchMkopoWasasaTotalForUser(int userId) async {
    try {
      final rejeshaMkopoModel = RejeshaMkopoModel();
      final results = await rejeshaMkopoModel
          .where('user_id', '=', userId)
          .where('mzungukoId', '=', widget.mzungukoId)
          .select();

      double sum = 0;
      if (results.isNotEmpty) {
        sum = results
            .map((entry) => (entry['unpaidAmount'] ?? 0).toDouble())
            .fold(0, (prev, element) => prev + element);
      }

      setState(() {
        _mkopoWasasaTotal = sum;
      });
      print('Mkopo wa Sasa for user $userId: $_mkopoWasasaTotal');
    } catch (e) {
      print('Error fetching Mkopo wa Sasa total for user $userId: $e');
      setState(() {
        _mkopoWasasaTotal = 0;
      });
    }
  }

  Future<void> _fetchFainiTotalForUser(int userId) async {
    try {
      final userFainiModel = UserFainiModel();
      final results = await userFainiModel
          .where('user_id', '=', userId)
          .where('mzungukoId', '=', widget.mzungukoId)
          .select();

      double sum = 0;
      if (results.isNotEmpty) {
        sum = results
            .map((entry) => (entry['unpaidfaini'] ?? 0).toDouble())
            .fold(0, (prev, element) => prev + element);
      }

      setState(() {
        _fainiTotal = sum;
      });
      print('Faini total for user $userId: $_fainiTotal');
    } catch (e) {
      print('Error fetching total unpaid fines for user $userId: $e');
      setState(() {
        _fainiTotal = 0;
      });
    }
  }

  Future<void> _checkPasswordCompletionStatus() async {
    try {
      final passwordModel = PasswordModel();

      final data = await passwordModel.where('status', '=', 'complete').find();

      if (data != null && data.isNotEmpty) {
        setState(() {
          isPasswordSetupComplete = true;
        });
        print("Password setup is complete.");
      } else {
        setState(() {
          isPasswordSetupComplete = false;
        });
        print("Password setup is not complete.");
      }
    } catch (e) {
      print("Error checking password completion: $e");
    }
  }

  Future<void> _fetchMzungukoId() async {
    final mzungukoModel = MzungukoModel();
    final mzungukoResult =
        await mzungukoModel.where('status', '=', 'pending').findOne();
    final int? fetchedMzungukoId =
        (mzungukoResult != null && mzungukoResult is MzungukoModel)
            ? mzungukoResult.id
            : null;

    if (fetchedMzungukoId != null) {
      setState(() {
        _isMzungukoPending = true;
      });
    } else {
      setState(() {
        _isMzungukoPending = false;
      });
    }
  }

  Future<void> fetchSumToaAkibaHiari(int userId) async {
    try {
      await BaseModel.ensureDatabaseInitialized();

      var toaAkibaHiari = ToaAkibaHiariModel();
      final records = await toaAkibaHiari
          .where('user_id', '=', userId)
          .where('mzungukoId', '=', widget.mzungukoId)
          .select();

      double totalWithdrawn = 0.0;

      if (records.isNotEmpty) {
        // Process history and withdrawals for each record
        for (var record in records) {
          List<Map<String, dynamic>> history = [];
          if (record['history'] != null) {
            try {
              history = List<Map<String, dynamic>>.from(
                  json.decode(record['history']));
            } catch (e) {
              print("Error decoding history: $e");
            }
          }

          // Sum up all withdrawals from history
          double withdrawn = history.fold(0.0, (sum, entry) {
            return sum + ((entry['amount'] as num?)?.toDouble() ?? 0.0);
          });

          totalWithdrawn += withdrawn;
        }
      }

      setState(() {
        totalAkiba = totalWithdrawn;
      });
      print('Toa akiba total for user $userId: $totalAkiba');
    } catch (e) {
      print('Error fetching total toa akiba hiari for user $userId: $e');
      setState(() {
        totalAkiba = 0;
      });
    }
  }

  Future<void> _deleteUserFromGroup() async {
    try {
      final groupMembersModel = GroupMembersModel();

      final rowsDeleted = await groupMembersModel
          .where('id', '=', widget.userId)
          .where('groupId', '=', widget.groupId)
          .delete();

      if (rowsDeleted > 0) {
        print('Successfully deleted user ${widget.userId}');
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MemberList(
                  groupId: widget.groupId, mzungukoId: widget.mzungukoId)),
        );
      } else {
        print('No user found with ID ${widget.userId}');
      }

      setState(() {});
    } catch (e) {
      print('Error deleting user ${widget.userId}: $e');
    }
  }

  Future<void> _fetchTotalSharesForUser(int userId) async {
    try {
      await BaseModel.ensureDatabaseInitialized();

      // First fetch the share value from KatibaModel
      final katiba = KatibaModel();
      final shareValueData = await katiba
          .where('katiba_key', '=', 'share_amount')
          .where('mzungukoId', '=', widget.mzungukoId)
          .findOne();

      double shareValue = 0.0;
      if (shareValueData != null && shareValueData is KatibaModel) {
        shareValue = double.tryParse(shareValueData.value ?? '0') ?? 0.0;
      }

      // Then fetch the member's shares
      final memberShareModel = MemberShareModel();
      final shares = await memberShareModel
          .where('user_id', '=', userId)
          .where('mzungukoId', '=', widget.mzungukoId)
          .select();

      int totalShares = 0;
      if (shares.isNotEmpty) {
        totalShares = shares
            .map((share) => (share['number_of_shares'] ?? 0) as int)
            .fold(0, (prev, count) => prev + count);
      }

      setState(() {
        _totalSharesCount = totalShares;
        _shareValue = shareValue;
        _totalSharesValue = totalShares * shareValue;
      });

      print(
          'Total shares for user $userId: $_totalSharesCount worth $_totalSharesValue (share value: $_shareValue)');
    } catch (e) {
      print('Error fetching total shares for user $userId: $e');
      setState(() {
        _totalSharesCount = 0;
        _shareValue = 0;
        _totalSharesValue = 0;
      });
    }
  }

  Future<void> _fetchUserSpecificData(int userId) async {
    await _fetchAkibaLazimaTotalForUser(userId);
    await fetchSumToaAkibaHiari(userId);
    await _fetchAkibaHiariTotalForUser(userId);
    await _fetchMfukoJamiiTotalForUser(userId);
    await _fetchMkopoWasasaTotalForUser(userId);
    await _fetchFainiTotalForUser(userId);
    await _checkPasswordCompletionStatus();
    await _fetchTotalSharesForUser(userId); // Add this line to fetch shares

    setState(() {
      _salioTotal = _totalSharesValue + _mfukoJamiiTotal;
    });
  }

  String _safeGetField(String? field, {String defaultValue = '-'}) {
    return field?.isNotEmpty == true ? field! : defaultValue;
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    _fetchUserData().then((_) {
      if (widget.userId != null) {
        _fetchUserSpecificData(widget.userId!);
      }
    });
  }

  void _sendSms() async {
    String? phoneNumber = (_userData?.phone).toString();

    if (phoneNumber == null || phoneNumber.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.noPhoneNumber),
          backgroundColor: Colors.black,
        ),
      );
      return;
    }

    String message = """
${AppLocalizations.of(context)!.memberSummary}:

${AppLocalizations.of(context)!.fullName} ${_userData?.name}
${AppLocalizations.of(context)!.memberNumber} ${_userData?.memberNumber}
${AppLocalizations.of(context)!.gender} ${_userData?.gender}
${AppLocalizations.of(context)!.dob} ${_userData?.dob}

${AppLocalizations.of(context)!.totalShares}: ${formatCurrency(_totalSharesValue, Provider.of<CurrencyProvider>(context, listen: false).currencyCode)}
${AppLocalizations.of(context)!.communityFundBalance}: ${formatCurrency(_mfukoJamiiTotal, Provider.of<CurrencyProvider>(context, listen: false).currencyCode)}
${AppLocalizations.of(context)!.currentLoans}: ${formatCurrency(_mkopoWasasaTotal, Provider.of<CurrencyProvider>(context, listen: false).currencyCode)}
${AppLocalizations.of(context)!.totalFinesCollected}: ${formatCurrency(_fainiTotal, Provider.of<CurrencyProvider>(context, listen: false).currencyCode)}
""";

    print(message);

    try {
      var sendSms = SmsService([phoneNumber], message);
      await sendSms.sendSms();

      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: Text(AppLocalizations.of(context)!.summarySent.replaceAll('{name}', _userData?.name ?? '')),
      //     backgroundColor: Colors.black,
      //   ),
      // );
    } catch (e) {
      print("Error sending SMS: $e");

      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //       content: Text(AppLocalizations.of(context)!.failedToSendSms),
      //     backgroundColor: Colors.red,
      //   ),
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget avatarContent;
    if (_selectedImage != null) {
      avatarContent = ClipOval(
        child: Image.file(
          _selectedImage!,
          fit: BoxFit.cover,
          width: 300,
          height: 300,
        ),
      );
    } else {
      avatarContent = const Icon(
        Icons.person,
        size: 200,
        color: Colors.white,
      );
    }

    final memberSummaryWidget = SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                CircleAvatar(
                  radius: 150,
                  backgroundColor: Colors.grey[400],
                  child: avatarContent,
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MemberPhoto(
                            groupId: widget.groupId,
                            userId: widget.userId,
                            isUpdateMode: true,
                          ),
                        ),
                      ).then((_) {
                        _fetchUserData();
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(8),
                      child: const Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            CustomCard(
              titleText: AppLocalizations.of(context)!.memberInfo,
              onEdit: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MemberInfo(
                      groupId: widget.groupId,
                      userId: widget.userId,
                      isUpdateMode: true,
                      fromDashboard: true,
                    ),
                  ),
                ).then((_) {
                  _fetchUserData();
                });
              },
              items: [
                {
                  'description': AppLocalizations.of(context)!.fullName,
                  'value': _safeGetField(_userData?.name),
                },
                {
                  'description': AppLocalizations.of(context)!.memberNumber,
                  'value': _safeGetField(_userData?.memberNumber),
                },
                {
                  'description': AppLocalizations.of(context)!.gender,
                  'value': _safeGetField(_userData?.gender),
                },
                {
                  'description': AppLocalizations.of(context)!.dob,
                  'value': _safeGetField(_userData?.dob),
                },
              ],
            ),
            const SizedBox(height: 20),
            CustomCard(
              titleText: AppLocalizations.of(context)!.memberIdentity,
              onEdit: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => memberIdentity(
                      groupId: widget.groupId,
                      userId: widget.userId,
                      mzungukoId: widget.mzungukoId,
                      isUpdateMode: true,
                    ),
                  ),
                ).then((_) {
                  _fetchUserData();
                });
              },
              items: [
                {
                  'description': AppLocalizations.of(context)!.phoneNumber,
                  'value': _safeGetField(_userData?.phone),
                },
                {
                  'description': AppLocalizations.of(context)!.job,
                  'value': _safeGetField(_userData?.job),
                },
                {
                  'description': AppLocalizations.of(context)!.idType,
                  'value': _safeGetField(_userData?.memberIdType),
                },
                {
                  'description': AppLocalizations.of(context)!.idNumber,
                  'value': _safeGetField(_userData?.memberIdNumber),
                },
              ],
            ),
            const SizedBox(height: 20),
            CustomButton(
              color: const Color.fromARGB(255, 4, 34, 207),
              buttonText: widget.isUpdateMode ? AppLocalizations.of(context)!.completed : AppLocalizations.of(context)!.continueText,
              onPressed: () {
                if (isPasswordSetupComplete && _isMzungukoPending == false) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MemberListFromDashboard(
                        groupId: widget.groupId,
                        mzungukoId: widget.mzungukoId,
                      ),
                    ),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MemberList(
                        groupId: widget.groupId,
                        mzungukoId: widget.mzungukoId,
                      ),
                    ),
                  );
                }
              },
              type: ButtonType.elevated,
            ),
          ],
        ),
      ),
    );

    return Scaffold(
      appBar: CustomAppBar(
        title: !_isMzungukoPending
            ? _safeGetField(_userData?.name, defaultValue: '')
            : AppLocalizations.of(context)!.memberInfo,
        showBackArrow: true,
        icon: _isMzungukoPending && isPasswordSetupComplete ? Icons.delete : null,
        onIconPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                title: Row(
                  children: [
                    Icon(
                      Icons.warning_amber_outlined,
                      color: Colors.orange,
                    ),
                    SizedBox(width: 8),
                    Text(AppLocalizations.of(context)!.confirm),
                  ],
                ),
                content: Text(AppLocalizations.of(context)!.confirmDeleteUser),
                actions: [
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      AppLocalizations.of(context)!.cancel,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                    ),
                    onPressed: () {
                      _deleteUserFromGroup();
                    },
                    child: Text(
                      AppLocalizations.of(context)!.delete,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              );
            },
          );
        },
        bottom: !_isMzungukoPending
            ? TabBar(
                controller: _tabController,
                tabs: [
                  Tab(text: AppLocalizations.of(context)!.fundInfo),
                  Tab(text: AppLocalizations.of(context)!.memberInfo),
                ],
                indicatorColor: Colors.white,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white70,
              )
            : null,
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          if (!_isMzungukoPending)
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Card(
                      color: Colors.white,
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SizedBox(
                          width: 500,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.totalSavings,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                formatCurrency(_salioTotal, Provider.of<CurrencyProvider>(context).currencyCode),
                                style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '${AppLocalizations.of(context)!.totalDebt}: ' + formatCurrency(_mkopoWasasaTotal, Provider.of<CurrencyProvider>(context).currencyCode),
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildFundSection(
                      title: AppLocalizations.of(context)!.totalShares,
                      amount: formatCurrency(_totalSharesValue, Provider.of<CurrencyProvider>(context).currencyCode),
                      subtitle: '${_totalSharesCount} shares @ TZS ${_shareValue.toStringAsFixed(0)}',
                    ),
                    _buildFundSection(
                      title: AppLocalizations.of(context)!.communityFundBalance,
                      amount: formatCurrency(_mfukoJamiiTotal, Provider.of<CurrencyProvider>(context).currencyCode),
                    ),
                    Divider(thickness: 1, color: Colors.grey[300]),
                    _buildFundSection(
                      title: AppLocalizations.of(context)!.currentLoans,
                      amount: formatCurrency(_mkopoWasasaTotal, Provider.of<CurrencyProvider>(context).currencyCode),
                    ),
                    Divider(thickness: 1, color: Colors.grey[300]),
                    _buildFundSection(
                      title: AppLocalizations.of(context)!.totalFinesCollected,
                      amount: formatCurrency(_fainiTotal, Provider.of<CurrencyProvider>(context).currencyCode),
                    ),
                    Divider(thickness: 1, color: Colors.grey[300]),
                    const SizedBox(height: 20),
                    CustomButton(
                      color: Colors.green,
                      buttonText: AppLocalizations.of(context)!.sendSummary,
                      onPressed: () {
                        _sendSms();
                      },
                      type: ButtonType.elevated,
                    ),
                  ],
                ),
              ),
            ),
          memberSummaryWidget,
        ],
      ),
    );
  }
}

/// Helper function for the fund breakdown sections
Widget _buildFundSection({
  required String title,
  required String amount,
  String? debt,
  String? subtitle,
  bool showEyeIcon = false,
}) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
            ),
            if (showEyeIcon)
              const Icon(
                Icons.remove_red_eye_outlined,
                color: Colors.grey,
                size: 20,
              ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          amount,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black54,
            ),
          ),
        ],
        if (debt != null) ...[
          const SizedBox(height: 4),
          Text(
            debt,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.red,
            ),
          ),
        ],
      ],
    ),
  );
}
