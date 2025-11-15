import 'package:chomoka/view/group_setup/home_page.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:chomoka/l10n/app_localizations.dart';


class TermsAndConditionsPage extends StatefulWidget {
  final dynamic data_id;
  final bool isFromSetting;
  TermsAndConditionsPage({super.key, this.data_id, this.isFromSetting = false});

  @override
  _TermsAndConditionsPageState createState() => _TermsAndConditionsPageState();
}

class _TermsAndConditionsPageState extends State<TermsAndConditionsPage> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.termsAndConditions,
        showBackArrow: true,
      ),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                      Icon(
                        Icons.gavel,
                        size: 80,
                        color: Colors.blueAccent,
                      ),
                      SizedBox(height: 16),
                      Text(
                        AppLocalizations.of(context)!.termsAndConditions,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                _buildSection(
                  title: AppLocalizations.of(context)!.aboutChomoka,
                  content: AppLocalizations.of(context)!.aboutChomokaContent,
                ),
                _buildSection(
                  title: AppLocalizations.of(context)!.dataManagement,
                  content: AppLocalizations.of(context)!.dataManagementContent,
                ),
                _buildSection(
                  title: AppLocalizations.of(context)!.namedData,
                  content: AppLocalizations.of(context)!.namedDataContent,
                ),
                _buildSection(
                  title: AppLocalizations.of(context)!.generalData,
                  content: AppLocalizations.of(context)!.generalDataContent,
                ),
                if (!widget.isFromSetting) SizedBox(height: 24),
                if (!widget.isFromSetting)
                  Row(
                    children: [
                      Checkbox(
                        value: _isChecked,
                        onChanged: (value) {
                          setState(() {
                            _isChecked = value ?? false;
                          });
                        },
                      ),
                      Expanded(
                        child: Text(
                          AppLocalizations.of(context)!.acceptTerms,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                if (!widget.isFromSetting) SizedBox(height: 16),
                if (!widget.isFromSetting)
                  CustomButton(
                    color: _isChecked
                        ? Color.fromARGB(255, 4, 34, 207)
                        : Colors.grey,
                    buttonText: AppLocalizations.of(context)!.confirm,
                    onPressed: () {
                      if (_isChecked)
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                homePage(data_id: widget.data_id),
                          ),
                        );
                    },
                    type: ButtonType.elevated,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSection({required String title, required String content}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 8),
          Text(
            content,
            textAlign: TextAlign.justify,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}
