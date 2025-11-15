import 'package:chomoka/model/InitSetupModel.dart';
import 'package:chomoka/view/group_setup/home_page.dart';
import 'package:chomoka/view/group_setup/password/ConfirmPasswordPage.dart';
import 'package:chomoka/view/group_setup/password/ResetQuestionsPage.dart';
import 'package:flutter/material.dart';
import 'package:chomoka/model/PasswordModel.dart';
import 'package:chomoka/utils/hash_utils.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:chomoka/l10n/app_localizations.dart';


const Color keyboardNumberColor = Color.fromARGB(255, 4, 34, 207);

class SetPasswordPage extends StatefulWidget {
  final int? groupId;
  final int? mzungukoId;

  SetPasswordPage({super.key, this.groupId, this.mzungukoId});

  @override
  _SetPasswordPageState createState() => _SetPasswordPageState();
}

class _SetPasswordPageState extends State<SetPasswordPage> {
  final int passcodeLength = 4;
  final int totalPasswords = 3;
  List<String> enteredDigits = [];
  String? errorMessage;
  int currentStep = 1;

  Future<void> _updateStatusToCompleted() async {
    try {
      final initSetupModel = InitSetupModel(
        init_key: 'password',
        mzungukoId: widget.mzungukoId,
        value: 'complete',
      );

      await initSetupModel.create();

      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => homePage(
                  data_id: widget.groupId,
                )),
      );
    } catch (e) {
      print('Error updating status: $e');
    }
  }

  void _onDigitPressed(String digit) {
    setState(() {
      if (enteredDigits.length < passcodeLength) {
        enteredDigits.add(digit);
      }
    });

    if (enteredDigits.length == passcodeLength) {
      String newPassword = enteredDigits.join();

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ConfirmPasswordPage(
            initialPasscode: newPassword,
            groupId: widget.groupId,
            title: AppLocalizations.of(context)!
                .confirmPasswordTitle,
            onConfirmed: (confirmedPasscode) async {
              String hashedPassword = hashString(confirmedPasscode);

              PasswordModel passwordEntry = PasswordModel(
                password: hashedPassword,
              );
              final passwordId = await passwordEntry.create();

              Navigator.pop(context); // Close ConfirmPasswordPage
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SetQuestionPage(
                    passwordId: passwordId,
                    passwordNumber: currentStep,
                    onQuestionSet: (String question, String answer) async {
                      await PasswordModel()
                          .where('id', '=', passwordId)
                          .update({
                        'question': question,
                        'answer': answer,
                        'mzungukoId': widget.mzungukoId,
                      });

                      setState(() {
                        currentStep++;
                        enteredDigits.clear();
                      });

                      if (currentStep > totalPasswords) {
                        _updateStatusToCompleted();
                      }
                    },
                  ),
                ),
              );
            },
          ),
        ),
      );
    }
  }

  Widget _buildCircles() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(passcodeLength, (index) {
        bool filled = index < enteredDigits.length;
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 10.0),
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: filled ? Colors.black : Colors.grey.shade300,
          ),
        );
      }),
    );
  }

  Widget _buildNumPad() {
    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      childAspectRatio: 2,
      padding: const EdgeInsets.all(20),
      children: [
        for (int i = 1; i <= 9; i++)
          TextButton(
            onPressed: () => _onDigitPressed(i.toString()),
            child: Text(
              '$i',
              style: const TextStyle(fontSize: 24, color: keyboardNumberColor),
            ),
          ),
        const SizedBox(),
        TextButton(
          onPressed: () => _onDigitPressed('0'),
          child: Text(
            '0',
            style: const TextStyle(fontSize: 24, color: keyboardNumberColor),
          ),
        ),
        TextButton(
          onPressed: () {
            setState(() {
              if (enteredDigits.isNotEmpty) enteredDigits.removeLast();
            });
          },
          child: const Icon(Icons.backspace, color: keyboardNumberColor),
        ),
      ],
    );
  }

  String _getTitle() {
    return currentStep <= totalPasswords
        ? AppLocalizations.of(context)!.setPasswordTitle(currentStep.toString())
        : AppLocalizations.of(context)!.allPasswordsSetTitle;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: _getTitle(),
        showBackArrow: currentStep > 1,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(_getTitle(), style: const TextStyle(fontSize: 20)),
          const SizedBox(height: 40),
          _buildCircles(),
          const SizedBox(height: 20),
          if (errorMessage != null)
            Text(errorMessage!, style: const TextStyle(color: Colors.red)),
          _buildNumPad(),
        ],
      ),
    );
  }
}
