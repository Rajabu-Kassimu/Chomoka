import 'package:chomoka/model/PasswordModel.dart';
import 'package:chomoka/utils/hash_utils.dart';
import 'package:chomoka/view/dashboard/dashboard.dart';
import 'package:chomoka/view/dashboard/mgao_kikundi/mgao_kikundi/kiasi_mzunguko_ujao.dart';
import 'package:chomoka/view/dashboard/mgao_kikundi/mgao_mwanachama/cmg/thibitisha_mgao.dart';
import 'package:chomoka/view/dashboard/mgao_kikundi/mgao_mwanachama/vsla/vsla_thibitisha_mgao.dart';
import 'package:chomoka/view/group_setup/password/reset_password_page.dart';
import 'package:chomoka/view/pre_page/setting.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:chomoka/l10n/app_localizations.dart';


class LoginPage extends StatefulWidget {
  var groupId;
  final bool isFromLogin;
  final bool isFromMgao;
  var mzungukoId;
  var mfukoJamiiKiasi;
  var withdrawAmount;
  final String groupName;
  final bool isFromMgaoWanachama;
  final bool isFromVslaMgaoWanachama;
  final Map<String, dynamic>? user;

  LoginPage(
      {this.groupId,
      this.isFromLogin = false,
      this.mzungukoId,
      this.user,
      this.mfukoJamiiKiasi,
      this.withdrawAmount,
      this.groupName = "",
      this.isFromMgao = false,
      this.isFromMgaoWanachama = false,
      this.isFromVslaMgaoWanachama = false});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _key1Controller = TextEditingController();
  final TextEditingController _key2Controller = TextEditingController();
  final TextEditingController _key3Controller = TextEditingController();

  String? errorMessage;

  late AppLocalizations _localizations;

  Future<bool> validatePasswords(String key1, String key2, String key3) async {
    try {
      final passwordModel = PasswordModel();

      final password1Data = await passwordModel.where('id', '=', 1).first();
      final password2Data = await passwordModel.where('id', '=', 2).first();
      final password3Data = await passwordModel.where('id', '=', 3).first();

      final password1 = password1Data as PasswordModel?;
      final password2 = password2Data as PasswordModel?;
      final password3 = password3Data as PasswordModel?;

      final hashedKey1 = hashString(key1);
      final hashedKey2 = hashString(key2);
      final hashedKey3 = hashString(key3);

      if (password1 != null &&
          password2 != null &&
          password3 != null &&
          password1.password == hashedKey1 &&
          password2.password == hashedKey2 &&
          password3.password == hashedKey3) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("Error validating passwords: $e");
      return false;
    }
  }

  void _login() async {
    // Trim and retrieve input values
    final key1 = _key1Controller.text.trim();
    final key2 = _key2Controller.text.trim();
    final key3 = _key3Controller.text.trim();

    // Check if any of the keys are empty
    if (key1.isEmpty || key2.isEmpty || key3.isEmpty) {
      setState(() {
        errorMessage = _localizations.enterAllKeys; // Show error for empty keys
      });
      return;
    }

    try {
      // Validate the entered keys
      final isValid = await validatePasswords(key1, key2, key3);

      // If the keys are valid
      if (isValid == true) {
        setState(() {
          errorMessage = null; // Clear any previous error messages
        });

        // Navigation logic based on widget flags
        if (widget.isFromMgao == true) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => KiasiMzungukoUjao(
                mzungukoId: widget.mzungukoId,
                mfukoJamiiKiasi: widget.mfukoJamiiKiasi,
              ),
            ),
          );
        } else if (widget.isFromMgaoWanachama == true) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ThibishaMgao(
                mzungukoId: widget.mzungukoId,
                withdrawAmount: widget.withdrawAmount,
                user: widget.user ?? {},
              ),
            ),
          );
        } else if (widget.isFromVslaMgaoWanachama == true) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VslaThibishaMgao(
                mzungukoId: widget.mzungukoId,
                withdrawAmount: widget.withdrawAmount,
                user: widget.user ?? {},
              ),
            ),
          );
        } else {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => dashboard(
                groupId: widget.groupId,
                isFromLogin: true,
                mzungukoId: widget.mzungukoId,
              ),
            ),
            (Route<dynamic> route) => false,
          );
        }
      } else {
        setState(() {
          errorMessage = _localizations.invalidKeys;
        });
      }
    } catch (e) {
      // Handle unexpected errors
      setState(() {
        errorMessage = _localizations.systemError;
      });
      print('Login error: $e');
    }
  }

  // @override
  // initState() {
  //   _key1Controller.text = "0000";
  //   _key2Controller.text = "0000";
  //   _key3Controller.text = "0000";
  // }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _localizations = AppLocalizations.of(context)!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.isFromMgao ||
                widget.isFromMgaoWanachama ||
                widget.isFromVslaMgaoWanachama
            ? _localizations.enterKeysToContinue
            : widget.groupName,
        showBackArrow: false,
        icon: Icons.settings,
        onIconPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SettingsPage()),
          );
        },
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                TextField(
                  controller: _key1Controller,
                  obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock, color: Colors.black),
                    labelText: _localizations.enterKey1,
                    border: InputBorder.none,
                  ),
                ),
                Divider(),
                TextField(
                  controller: _key2Controller,
                  obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock, color: Colors.black),
                    labelText: _localizations.enterKey2,
                    border: InputBorder.none,
                  ),
                ),
                Divider(),
                TextField(
                  controller: _key3Controller,
                  obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock, color: Colors.black),
                    labelText: _localizations.enterKey3,
                    border: InputBorder.none,
                  ),
                ),
                if (errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      errorMessage!,
                      style: TextStyle(color: Colors.red, fontSize: 14),
                    ),
                  ),
              ],
            ),
            Column(
              children: [
                if (widget.isFromMgao || widget.isFromMgaoWanachama)
                  SizedBox()
                else
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ResetPasswordPage()),
                      );
                    },
                    child: Text(
                      _localizations.resetSecurityKeys,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                SizedBox(height: 20),
                CustomButton(
                  color: const Color.fromARGB(255, 4, 34, 207),
                  buttonText: _localizations.openButton,
                  onPressed: _login,
                  type: ButtonType.elevated,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
