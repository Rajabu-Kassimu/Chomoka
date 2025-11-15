import 'package:chomoka/model/PasswordModel.dart';
import 'package:chomoka/utils/hash_utils.dart';
import 'package:chomoka/view/pre_page/welcom_page.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:chomoka/l10n/app_localizations.dart';


class UpdatePasswordPage extends StatefulWidget {
  final String selectedKey;

  UpdatePasswordPage({required this.selectedKey});

  @override
  _UpdatePasswordPageState createState() => _UpdatePasswordPageState();
}

class _UpdatePasswordPageState extends State<UpdatePasswordPage> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  String? _newPasswordError;
  String? _confirmPasswordError;
  bool errorText = false;

  void _validateAndUpdatePassword() async {
    setState(() {
      _newPasswordError = null;
      _confirmPasswordError = null;
      errorText = false;
    });

    String newPassword = _newPasswordController.text;
    String confirmPassword = _confirmPasswordController.text;
    bool hasError = false;

    if (newPassword.isEmpty) {
      _newPasswordError = AppLocalizations.of(context)!.pleaseEnterNewPassword;
      hasError = true;
    } else if (!RegExp(r'^\d+$').hasMatch(newPassword)) {
      _newPasswordError =
          AppLocalizations.of(context)!.passwordMustBeDigitsOnly;
      hasError = true;
    } else if (newPassword.length > 4) {
      _newPasswordError =
          AppLocalizations.of(context)!.passwordMustBeLessThan4Digits;
      hasError = true;
    }

    if (confirmPassword.isEmpty) {
      _confirmPasswordError =
          AppLocalizations.of(context)!.pleaseConfirmNewPassword;
      hasError = true;
    } else if (newPassword != confirmPassword) {
      _confirmPasswordError = AppLocalizations.of(context)!.passwordsDoNotMatch;
      hasError = true;
    }

    if (hasError) {
      setState(() {
        errorText = true;
      });
      return;
    }

    String hashedPassword = hashString(newPassword);

    int updated = await PasswordModel()
        .where('id', '=', widget.selectedKey)
        .update({'password': hashedPassword});

    if (updated > 0) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WelcomePage(),
        ),
      );
    } else {
      setState(() {
        _newPasswordError = AppLocalizations.of(context)!.errorOccurredTryAgain;
        errorText = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title:
            AppLocalizations.of(context)!.editPasswordFor(widget.selectedKey),
        showBackArrow: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            CustomTextField(
              aboveText: AppLocalizations.of(context)!.newPassword,
              labelText: AppLocalizations.of(context)!.newPassword,
              hintText: AppLocalizations.of(context)!.newPassword,
              keyboardType: TextInputType.number,
              controller: _newPasswordController,
              obscureText: true,
            ),
            if (errorText && _newPasswordError != null)
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  _newPasswordError!,
                  style: TextStyle(color: Colors.red, fontSize: 14),
                ),
              ),
            SizedBox(height: 10),
            CustomTextField(
              aboveText: AppLocalizations.of(context)!.confirmNewPassword,
              labelText: AppLocalizations.of(context)!.confirmNewPassword,
              hintText: AppLocalizations.of(context)!.confirmNewPassword,
              keyboardType: TextInputType.number,
              controller: _confirmPasswordController,
              obscureText: true,
            ),
            if (errorText && _confirmPasswordError != null)
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  _confirmPasswordError!,
                  style: TextStyle(color: Colors.red, fontSize: 14),
                ),
              ),
            SizedBox(height: 20),
            CustomButton(
              color: const Color.fromARGB(255, 4, 34, 207),
              buttonText: AppLocalizations.of(context)!.continue_,
              onPressed: _validateAndUpdatePassword,
              type: ButtonType.elevated,
            ),
          ],
        ),
      ),
    );
  }
}
