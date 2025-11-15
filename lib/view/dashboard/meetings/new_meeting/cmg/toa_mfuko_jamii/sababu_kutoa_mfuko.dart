// lib/pages/sababu_kutoa_mfuko_page.dart
import 'package:chomoka/view/dashboard/meetings/new_meeting/cmg/toa_mfuko_jamii/toa_mfuko_jamii_amount.dart';
import 'package:flutter/material.dart';
import 'package:chomoka/model/BaseModel.dart';
import 'package:chomoka/model/SababuKutoaMfuko.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:chomoka/l10n/app_localizations.dart';

import 'package:provider/provider.dart';
import 'package:chomoka/providers/currency_provider.dart';
import 'package:chomoka/utils/currency_formatter.dart';

class SababuKutoaMfukoPage extends StatefulWidget {
  final int? meetingId;
  var userId;
  var mzungukoId;

  SababuKutoaMfukoPage({this.meetingId, this.userId, this.mzungukoId});

  @override
  _SababuKutoaMfukoPageState createState() => _SababuKutoaMfukoPageState();
}

class _SababuKutoaMfukoPageState extends State<SababuKutoaMfukoPage> {
  List<SababuKutoaMfuko> _sababuList = [];
  SababuKutoaMfuko? _selectedSababu;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchSababu();
  }

  Future<void> _fetchSababu() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      SababuKutoaMfuko model = SababuKutoaMfuko();
      List<BaseModel> results =
          await model.where('mzungukoid', '=', widget.mzungukoId).find();

      setState(() {
        _sababuList = results.cast<SababuKutoaMfuko>();
      });
    } catch (e) {
      print("Error fetching reasons: $e");
      setState(() {
        _errorMessage = "Imeshindikana kuchukua sababu za kutoa mfuko.";
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _toggleSelection(SababuKutoaMfuko sabab) {
    setState(() {
      _selectedSababu = sabab;
    });
  }

  void _proceed() {
    if (_selectedSababu == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Tafadhali chagua sababu moja.")),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ToaMfukoJamiiAmountPage(
          selectedSababu: _selectedSababu?.reasonName ?? '',
          userId: widget.userId,
          meetingId: widget.meetingId,
          mzungukoId: widget.mzungukoId,
          sababuLimitAmount: _selectedSababu?.amount ?? '',
          sababu: _selectedSababu?.reasonName ?? '',
        ),
      ),
    );
  }

  /// Builds the list of existing reasons with Radio buttons
  Widget _buildSababuList() {
    final l10n = AppLocalizations.of(context)!;
    if (_sababuList.isEmpty) {
      return Center(
        child: Text(
          l10n.hakuna_sababu,
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      itemCount: _sababuList.length,
      itemBuilder: (context, index) {
        SababuKutoaMfuko sababu = _sababuList[index];
        bool isSelected = _selectedSababu?.id == sababu.id;

        if (sababu.id == null) {
          return SizedBox.shrink(); // Return an empty widget if id is null
        }

        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 2,
          margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: ListTile(
            leading: Radio<SababuKutoaMfuko>(
              value: sababu,
              groupValue: _selectedSababu,
              onChanged: (SababuKutoaMfuko? value) {
                if (value != null) {
                  _toggleSelection(value);
                }
              },
            ),
            title: Text(
              sababu.reasonName ?? l10n.jina_lisiloeleweka,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            subtitle: Text(
              l10n.kiasi_cha_juu(formatCurrency(double.tryParse(sababu.amount ?? '0') ?? 0, Provider.of<CurrencyProvider>(context).currencyCode)),
              style: TextStyle(fontSize: 14),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: CustomAppBar(
        title: l10n.toa_mfuko_jamii,
        subtitle: l10n.sababu_ya_kutoa_mfuko,
        showBackArrow: true,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _errorMessage != null
              ? Center(
                  child: Text(
                    _errorMessage!,
                    style: TextStyle(fontSize: 16, color: Colors.red),
                  ),
                )
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 30,
                                child: Icon(Icons.person, size: 30),
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      l10n.jina,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Text(
                                      "${widget.userId?['name'] ?? l10n.jina_lisiloeleweka}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      l10n.memberNumber,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Text(
                                      "${widget.userId?['phone'] ?? l10n.namba_haijapatikana}",
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
                      ),
                    ),
                    Text(
                      l10n.chagua_sababu,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    SizedBox(height: 10),
                    Expanded(
                      child: _buildSababuList(),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: CustomButton(
                        color: Color.fromARGB(255, 4, 34, 207),
                        buttonText: l10n.continue_,
                        onPressed: _proceed,
                        type: ButtonType.elevated,
                      ),
                    ),
                  ],
                ),
    );
  }
}
