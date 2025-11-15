import 'package:flutter/material.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:chomoka/l10n/app_localizations.dart';


const Color keyboardNumberColor = Color.fromARGB(255, 4, 34, 207);

class ConfirmPasswordPage extends StatefulWidget {
  final String initialPasscode;
  final String title;
  final Function(String confirmedPasscode) onConfirmed;
  var groupId;

  ConfirmPasswordPage({
    required this.initialPasscode,
    required this.onConfirmed,
    required this.title,
    this.groupId,
  });

  @override
  _ConfirmPasswordPageState createState() => _ConfirmPasswordPageState();
}

class _ConfirmPasswordPageState extends State<ConfirmPasswordPage> {
  final int passcodeLength = 4;
  List<String> enteredDigits = [];
  String? errorMessage;

  void _onDigitPressed(String digit) {
    setState(() {
      if (enteredDigits.length < passcodeLength) {
        enteredDigits.add(digit);
      }
    });

    if (enteredDigits.length == passcodeLength) {
      if (enteredDigits.join() == widget.initialPasscode) {
        widget.onConfirmed(enteredDigits.join());
      } else {
        setState(() {
          errorMessage =
              AppLocalizations.of(context)!.passwordsDoNotMatchTryAgain;
          enteredDigits.clear();
        });
      }
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
      padding: EdgeInsets.all(20),
      children: [
        for (int i = 1; i <= 9; i++)
          TextButton(
            onPressed: () => _onDigitPressed(i.toString()),
            child: Text(
              '$i',
              style: TextStyle(fontSize: 24, color: keyboardNumberColor),
            ),
          ),
        SizedBox(),
        TextButton(
          onPressed: () => _onDigitPressed('0'),
          child: Text(
            '0',
            style: TextStyle(fontSize: 24, color: keyboardNumberColor),
          ),
        ),
        TextButton(
          onPressed: () {
            setState(() {
              if (enteredDigits.isNotEmpty) enteredDigits.removeLast();
            });
          },
          child: Icon(Icons.backspace, color: keyboardNumberColor),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.title,
        showBackArrow: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(widget.title, style: TextStyle(fontSize: 20)),
          SizedBox(height: 20),
          if (errorMessage != null)
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0), // Add padding
              child: Text(
                errorMessage!, // Now safe due to the check above
                style:
                    TextStyle(color: Colors.red, fontSize: 16), // Adjust style
                textAlign: TextAlign.center, // Center align text
              ),
            ),
          _buildCircles(),
          SizedBox(height: 20),
          _buildNumPad(),
        ],
      ),
    );
  }
}
