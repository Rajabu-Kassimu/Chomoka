import 'package:chomoka/model/BaseModel.dart';
import 'package:chomoka/model/PasswordModel.dart';
import 'package:flutter/material.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:chomoka/l10n/app_localizations.dart';


class SetQuestionPage extends StatefulWidget {
  final int passwordId;
  final int passwordNumber;
  final Function(String question, String answer) onQuestionSet;
  var groupId;

  SetQuestionPage({
    required this.passwordId,
    required this.passwordNumber,
    required this.onQuestionSet,
    this.groupId,
  });

  @override
  _SetQuestionPageState createState() => _SetQuestionPageState();
}

class _SetQuestionPageState extends State<SetQuestionPage> {
  final TextEditingController _answerController = TextEditingController();
  String? errorMessage;
  List<String> _questions =
      []; // Initialize empty, will be populated in didChangeDependencies

  String? _selectedQuestion;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Populate questions here to access context for AppLocalizations
    _questions = [
      AppLocalizations.of(context)!.securityQuestion1,
      AppLocalizations.of(context)!.securityQuestion2,
      AppLocalizations.of(context)!.securityQuestion3,
    ];
    // If a question was previously selected, ensure it's still valid
    if (_selectedQuestion != null && !_questions.contains(_selectedQuestion)) {
      _selectedQuestion =
          null; // Reset if the localized list doesn't contain it
    }
  }

  void _onSubmit() async {
    if (_selectedQuestion == null || _selectedQuestion!.isEmpty) {
      setState(() {
        errorMessage = AppLocalizations.of(context)!.errorSelectQuestion;
      });
      return;
    }

    if (_answerController.text.trim().isEmpty) {
      setState(() {
        errorMessage = AppLocalizations.of(context)!.errorEnterAnswer;
      });
      return;
    }

    try {
      await PasswordModel().where('id', '=', widget.passwordId).update({
        'question': _selectedQuestion,
        'answer': _answerController.text.trim(),
        'status': 'complete',
      });

      widget.onQuestionSet(
        _selectedQuestion!,
        _answerController.text.trim(),
      );

      Navigator.pop(context, {
        'groupId': widget.groupId,
      });
    } catch (e) {
      setState(() {
        errorMessage = AppLocalizations.of(context)!.errorSaving;
      });
      print("Error updating question and answer: $e");
    }
  }

  Future<void> printSavedAnswers() async {
    try {
      await PasswordModel().ensureTableExists();

      List<BaseModel> savedPasswords = await PasswordModel().find();

      for (var basePassword in savedPasswords) {
        PasswordModel password = basePassword as PasswordModel;
        print(
            'ID: ${password.id}, Question: ${password.question}, Answer: ${password.answer}, Status: ${password.status}');
      }
    } catch (e) {
      print('Error fetching saved answers: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    printSavedAnswers();
    // Ensure questions are loaded if not already
    if (_questions.isEmpty) {
      _questions = [
        AppLocalizations.of(context)!.securityQuestion1,
        AppLocalizations.of(context)!.securityQuestion2,
        AppLocalizations.of(context)!.securityQuestion3,
      ];
    }
    return Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!
            .resetQuestionPageTitle(widget.passwordNumber),
        showBackArrow: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.selectQuestionLabel,
                border: OutlineInputBorder(),
              ),
              hint: Text(AppLocalizations.of(context)!.selectQuestionHint),
              value: _selectedQuestion,
              isExpanded: true,
              items: _questions.map((String question) {
                return DropdownMenuItem<String>(
                  value: question,
                  child: Text(question),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedQuestion = value;
                });
              },
            ),
            SizedBox(height: 10),
            CustomTextField(
              aboveText: AppLocalizations.of(context)!.answerLabel,
              labelText: AppLocalizations.of(context)!.answerLabel,
              hintText: AppLocalizations.of(context)!.answerHint,
              controller: _answerController,
              obscureText: false,
            ),
            SizedBox(height: 20),
            if (errorMessage != null)
              Text(errorMessage!, style: TextStyle(color: Colors.red)),
            SizedBox(height: 20),
            CustomButton(
              color: const Color.fromARGB(255, 4, 34, 207),
              buttonText: AppLocalizations.of(context)!.saveButton,
              onPressed: _onSubmit,
              type: ButtonType.elevated,
            ),
          ],
        ),
      ),
    );
  }
}
