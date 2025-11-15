import 'package:chomoka/view/dashboard/mrejesho/mrejesho_two.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:chomoka/l10n/app_localizations.dart';


class FeedbackOnePage extends StatefulWidget {
  final dynamic groupId;
  FeedbackOnePage({
    Key? key,
    this.groupId,
  }) : super(key: key);

  @override
  _FeedbackOnePageState createState() => _FeedbackOnePageState();
}

class _FeedbackOnePageState extends State<FeedbackOnePage> {
  String? _firstQuestionAnswer;
  String? _secondQuestionAnswer;

  bool _firstQuestionError = false;
  bool _secondQuestionError = false;

  void _continueToNextPage() {
    setState(() {
      _firstQuestionError = _firstQuestionAnswer == null;
      _secondQuestionError = _secondQuestionAnswer == null;
    });

    if (_firstQuestionError || _secondQuestionError) {
      return; // Do not navigate if there are errors
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MrejeshoTwoPage(
          groupId: widget.groupId,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: CustomAppBar(
        title: l10n.systemFeedback,
        showBackArrow: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // First Question
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.agentPreparedAndOnTime,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: RadioListTile<String>(
                            title: Text(l10n.yes),
                            value: l10n.yes,
                            groupValue: _firstQuestionAnswer,
                            onChanged: (value) {
                              setState(() {
                                _firstQuestionAnswer = value;
                                _firstQuestionError = false;
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: RadioListTile<String>(
                            title: Text(l10n.no),
                            value: l10n.no,
                            groupValue: _firstQuestionAnswer,
                            onChanged: (value) {
                              setState(() {
                                _firstQuestionAnswer = value;
                                _firstQuestionError = false;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    if (_firstQuestionError)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          l10n.pleaseAnswerThisQuestion,
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 14,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),

            // Second Question
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.agentExplainedChomoka,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: RadioListTile<String>(
                            title: Text(l10n.yes),
                            value: l10n.yes,
                            groupValue: _secondQuestionAnswer,
                            onChanged: (value) {
                              setState(() {
                                _secondQuestionAnswer = value;
                                _secondQuestionError = false;
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: RadioListTile<String>(
                            title: Text(l10n.no),
                            value: l10n.no,
                            groupValue: _secondQuestionAnswer,
                            onChanged: (value) {
                              setState(() {
                                _secondQuestionAnswer = value;
                                _secondQuestionError = false;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    if (_secondQuestionError)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          l10n.pleaseAnswerThisQuestion,
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 14,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            Spacer(),

            // Continue Button
            CustomButton(
              color: const Color.fromARGB(255, 4, 34, 207),
              buttonText: l10n.continueText,
              onPressed: _continueToNextPage,
              type: ButtonType.elevated,
            ),
          ],
        ),
      ),
    );
  }
}
