import 'package:chomoka/view/dashboard/mrejesho/mrejesho_three.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:chomoka/l10n/app_localizations.dart';


class MrejeshoTwoPage extends StatefulWidget {
  final dynamic groupId;
  MrejeshoTwoPage({
    Key? key,
    this.groupId,
  }) : super(key: key);
  @override
  _MrejeshoTwoPageState createState() => _MrejeshoTwoPageState();
}

class _MrejeshoTwoPageState extends State<MrejeshoTwoPage> {
  String? firstQuestionAnswer;
  int? ratingAnswer;

  bool firstQuestionError = false;
  bool ratingAnswerError = false;

  void _validateAndContinue() {
    setState(() {
      firstQuestionError = firstQuestionAnswer == null;
      ratingAnswerError = ratingAnswer == null;
    });

    if (!firstQuestionError && !ratingAnswerError) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MrejeshoThreePage(
            groupId: widget.groupId,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final ratingLevels = [
      l10n.agentRatingLevel1,
      l10n.agentRatingLevel2,
      l10n.agentRatingLevel3,
      l10n.agentRatingLevel4,
      l10n.agentRatingLevel5,
    ];
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
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.agentExplainedCosts,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: RadioListTile<String>(
                            title: Text('Ndio'),
                            value: 'Ndio',
                            groupValue: firstQuestionAnswer,
                            onChanged: (value) {
                              setState(() {
                                firstQuestionAnswer = value;
                                firstQuestionError = false;
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: RadioListTile<String>(
                            title: Text(l10n.no),
                            value: l10n.no,
                            groupValue: firstQuestionAnswer,
                            onChanged: (value) {
                              setState(() {
                                firstQuestionAnswer = value;
                                firstQuestionError = false;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    if (firstQuestionError)
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
            SizedBox(height: 20),

            // Second Question (Rating)
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.agentRating,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        return IconButton(
                          icon: Icon(
                            Icons.star,
                            color: ratingAnswer != null && ratingAnswer! > index
                                ? const Color.fromARGB(255, 4, 34, 207)
                                : Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              ratingAnswer = index + 1;
                              ratingAnswerError = false;
                            });
                          },
                        );
                      }),
                    ),
                    SizedBox(height: 10),
                    ...List.generate(5, (index) {
                      return RadioListTile<int>(
                        title: Text(ratingLevels[index]),
                        value: index + 1,
                        groupValue: ratingAnswer,
                        onChanged: (value) {
                          setState(() {
                            ratingAnswer = value;
                            ratingAnswerError = false;
                          });
                        },
                      );
                    }),
                    if (ratingAnswerError)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          l10n.pleaseChooseRating,
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
              onPressed: _validateAndContinue,
              type: ButtonType.elevated,
            ),
          ],
        ),
      ),
    );
  }
}
