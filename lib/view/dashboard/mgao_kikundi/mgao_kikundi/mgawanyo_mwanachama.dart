import 'package:flutter/material.dart';
import 'package:chomoka/utils/currency_formatter.dart';
import 'package:provider/provider.dart';
import 'package:chomoka/providers/currency_provider.dart';

class CustomMemberCard extends StatelessWidget {
  final String memberNumber;
  final String name;
  final double mgaoAmount;
  final String? status;

  CustomMemberCard({
    required this.memberNumber,
    required this.name,
    this.mgaoAmount = 0.0,
    this.status,
  });

  @override
  Widget build(BuildContext context) {
    Color amountColor = (status == 'paid') ? Colors.red : Colors.green;
    final currencyCode = Provider.of<CurrencyProvider>(context).currencyCode;

    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30.0,
              child: Icon(Icons.person, size: 30.0, color: Colors.black),
              backgroundColor: Colors.grey[300],
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                        fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Namba ya mwanachama: $memberNumber',
                    style: TextStyle(fontSize: 14.0, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Mgao: ' + formatCurrency(mgaoAmount, currencyCode),
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: amountColor, // Set color dynamically
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
} 