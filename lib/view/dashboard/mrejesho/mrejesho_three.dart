import 'package:chomoka/view/dashboard/dashboard.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:chomoka/l10n/app_localizations.dart';


class MrejeshoThreePage extends StatefulWidget {
  final dynamic groupId;
  MrejeshoThreePage({
    Key? key,
    this.groupId,
  }) : super(key: key);

  @override
  _MrejeshoThreePageState createState() => _MrejeshoThreePageState();
}

class _MrejeshoThreePageState extends State<MrejeshoThreePage> {
  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _suggestionController = TextEditingController();

  bool _questionError = false;
  bool _suggestionError = false;

  void _validateAndSubmit() {
    setState(() {
      _questionError = _questionController.text.trim().isEmpty;
      _suggestionError = _suggestionController.text.trim().isEmpty;
    });

    if (!_questionError && !_suggestionError) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => dashboard(
            groupId: widget.groupId,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: CustomAppBar(
        title: l10n.systemFeedback,
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.unansweredQuestion,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _questionController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: l10n.question,
                  border: OutlineInputBorder(),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 15,
                  ),
                  errorText: _questionError ? l10n.pleaseWriteQuestion : null,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                l10n.suggestionForChomoka,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _suggestionController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: l10n.suggestion,
                  border: OutlineInputBorder(),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 15,
                  ),
                  errorText:
                      _suggestionError ? l10n.pleaseWriteSuggestion : null,
                ),
              ),
              const SizedBox(height: 20),
              CustomButton(
                color: const Color.fromARGB(255, 4, 34, 207),
                buttonText: l10n.continueText,
                onPressed: _validateAndSubmit,
                type: ButtonType.elevated,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
