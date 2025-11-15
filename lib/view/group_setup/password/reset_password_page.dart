import 'package:chomoka/model/PasswordModel.dart';
import 'package:chomoka/view/group_setup/password/update_password.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:chomoka/l10n/app_localizations.dart';


class ResetPasswordPage extends StatefulWidget {
  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final TextEditingController _answerController = TextEditingController();

  String? _selectedKey;
  String? _selectedQuestion;

  List<String> _questions = [];

  Future<void> _checkQuestionAndAnswer() async {
    PasswordModel passwordModel = PasswordModel();

    List<PasswordModel> passwords =
        (await passwordModel.find()).cast<PasswordModel>();

    if (passwords.isNotEmpty) {
      for (var password in passwords) {
        print(
            'ID: ${password.id}, Swali: ${password.question}, Jibu: ${password.answer}');
      }
    } else {
      print('Hakuna maswali na majibu yaliyohifadhiwa');
    }
  }

  @override
  void initState() {
    super.initState();
    _questions = [
      'Mwanao wa kwanza amezaliwa mwaka gani?',
      'Jina la kwanza la mwanao wa kwanza?',
      'Umezaliwa mwaka gani?',
    ];
    _checkQuestionAndAnswer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.selectKeyToReset,
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(height: 10),
              Text(
                AppLocalizations.of(context)!.keyHolderSecretQuestion,
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(height: 20),

              // Funguo 1
              Row(
                children: [
                  Icon(Icons.lock, color: Colors.black),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      AppLocalizations.of(context)!.resetKey1,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Radio<String>(
                    value: '1',
                    groupValue: _selectedKey,
                    onChanged: (String? value) {
                      setState(() {
                        _selectedKey = value;
                        _selectedQuestion = null;
                      });
                    },
                  ),
                ],
              ),

              // Funguo 2
              Row(
                children: [
                  Icon(Icons.lock, color: Colors.black),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      AppLocalizations.of(context)!.resetKey2,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Radio<String>(
                    value: '2',
                    groupValue: _selectedKey,
                    onChanged: (String? value) {
                      setState(() {
                        _selectedKey = value;
                        _selectedQuestion = null;
                      });
                    },
                  ),
                ],
              ),

              // Funguo 3
              Row(
                children: [
                  Icon(Icons.lock, color: Colors.black),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      AppLocalizations.of(context)!.resetKey3,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Radio<String>(
                    value: '3',
                    groupValue: _selectedKey,
                    onChanged: (String? value) {
                      setState(() {
                        _selectedKey = value;
                        _selectedQuestion = null;
                      });
                    },
                  ),
                ],
              ),
              if (_selectedKey != null)
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.selectQuestion,
                      border: OutlineInputBorder(),
                    ),
                    hint: Text(AppLocalizations.of(context)!.selectQuestion),
                    value: _selectedQuestion,
                    isExpanded:
                        true, // Prevents the dropdown from causing overflow
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
                ),

              if (_selectedQuestion != null)
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: CustomTextField(
                    aboveText: AppLocalizations.of(context)!.answerToQuestion,
                    labelText: AppLocalizations.of(context)!.answerToQuestion,
                    hintText: AppLocalizations.of(context)!.enterAnswer,
                    controller: _answerController,
                    obscureText: false,
                  ),
                ),

              // Bottom Buttons
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Row(
                  children: [
                    SizedBox(width: 10),
                    Expanded(
                      child: CustomButton(
                        color: const Color.fromARGB(255, 4, 34, 207),
                        buttonText: AppLocalizations.of(context)!.continueText,
                        onPressed: () async {
                          if (_selectedKey != null &&
                              _selectedQuestion != null &&
                              _answerController.text.isNotEmpty) {
                            PasswordModel passwordModel = PasswordModel();
                            print(_selectedKey);
                            var password = await passwordModel
                                .where('id', '=', _selectedKey!)
                                .where('question', '=', _selectedQuestion!)
                                .where('answer', '=', _answerController.text)
                                .findOne();

                            if (password != null) {
                              // Ikiwa password inapatikana, endelea na navigation
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UpdatePasswordPage(
                                    selectedKey: _selectedKey!,
                                  ),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(AppLocalizations.of(context)!
                                        .incorrectQuestionOrAnswer)),
                              );
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(AppLocalizations.of(context)!
                                      .pleaseSelectQuestionAndAnswer)),
                            );
                          }
                        },
                        type: ButtonType.elevated,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
