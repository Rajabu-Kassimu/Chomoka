import 'package:chomoka/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpPage extends StatelessWidget {
  // FAQ Items in the specified format
  final List<Map<String, String>> faqItems = [
    {
      'question': 'Mfuko wa Chomoka umejifunga kwa bahati mbaya',
      'answer':
          'Pale ambapo mfumo umejifunga unaweza kubonyeza kitufe chochote chini na kubofya "Chomoka".'
    },
    {
      'question': 'Tunabadilishaje taarifa za mwanachama?',
      'answer':
          'Kutoka kwenye sehemu kuu unaweza kubonyeza mwanachama na kurekebisha taarifa zake.'
    },
    {
      'question': 'Tunaweza kurekebisha tukikosea?',
      'answer':
          'Kama kikao hakijaisha, rudi kwenye sehemu ambayo umekosea na rekebisha. Kama kikao kimekamilika tafadhali wasiliana na wakala wa Chomoka kwa msaada zaidi.'
    },
    {
      'question': 'Mfuko wa Chomoka umejifunga kwa bahati mbaya tena',
      'answer':
          'Pale ambapo mfumo umejifunga unaweza kubonyeza kitufe chochote chini na kubofya "Chomoka".'
    },
    {
      'question': 'Tunabadilishaje taarifa za mwanachama mara nyingine?',
      'answer':
          'Kutoka kwenye sehemu kuu unaweza kubonyeza mwanachama na kurekebisha taarifa zake.'
    },
    {
      'question': 'Je, tunaweza kurekebisha tena tukikosea?',
      'answer':
          'Kama kikao hakijaisha, rudi kwenye sehemu ambayo umekosea na rekebisha. Kama kikao kimekamilika tafadhali wasiliana na wakala wa Chomoka kwa msaada zaidi.'
    },
    {
      'question': 'Mfuko wa Chomoka umejifunga kwa mara ya tatu',
      'answer':
          'Pale ambapo mfumo umejifunga unaweza kubonyeza kitufe chochote chini na kubofya "Chomoka".'
    },
  ];

  // Function to handle dialing
  void _dialNumber(String number) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: number);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      throw 'Could not launch $number';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Msaada',
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Intro Text
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Kwa msaada wowote zaidi, matatizo, au mapendekezo tafadhali wasiliana na huduma kwa wateja kupitia nambari zetu au soma maswali yanayoulizwa mara kwa mara.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                  height: 1.5,
                ),
              ),
            ),

            // Phone Number Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Wasiliana Nasi:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 16),
                  _buildContactCard(
                    phoneNumber: '+1234567890',
                    label: 'Huduma kwa Wateja 1',
                  ),
                  SizedBox(height: 8),
                  _buildContactCard(
                    phoneNumber: '+0987654321',
                    label: 'Huduma kwa Wateja 2',
                  ),
                ],
              ),
            ),

            // FAQ Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Maswali Yanayoulizwa Mara kwa Mara:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: faqItems.length,
              itemBuilder: (context, index) {
                final item = faqItems[index];
                return FAQItem(
                  question: item['question']!,
                  answer: item['answer']!,
                );
              },
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }

  Widget _buildContactCard(
      {required String phoneNumber, required String label}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(
              Icons.phone_android,
              size: 28,
              color: Colors.green,
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    phoneNumber,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.call, color: Colors.blueAccent),
              onPressed: () => _dialNumber(phoneNumber),
            ),
          ],
        ),
      ),
    );
  }
}

class FAQItem extends StatefulWidget {
  final String question;
  final String answer;

  FAQItem({required this.question, required this.answer});

  @override
  _FAQItemState createState() => _FAQItemState();
}

class _FAQItemState extends State<FAQItem> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ExpansionTile(
        title: Text(
          widget.question,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              widget.answer,
              style: TextStyle(fontSize: 14, color: Colors.black87),
            ),
          ),
        ],
        onExpansionChanged: (isExpanded) {
          setState(() {
            _isExpanded = isExpanded;
          });
        },
      ),
    );
  }
}
