import 'package:chomoka/model/BaseModel.dart';

class ExpensesModel extends BaseModel {
  int? id;
  int? businessId;
  int? mzungukoId;
  String? expenseDate;
  String? reason;
  double? amount;
  String? payer;
  String? description;
  String? status;

  ExpensesModel({
    this.id,
    this.businessId,
    this.mzungukoId,
    this.expenseDate,
    this.reason,
    this.amount,
    this.payer,
    this.description,
    this.status,
  });

  @override
  String get tableName => 'business_expenses';

  @override
  Map<String, String> get columns => {
        'id': 'INTEGER PRIMARY KEY AUTOINCREMENT',
        'businessId': 'INTEGER NULLABLE',
        'mzungukoId': 'INTEGER NULLABLE',
        'expenseDate': 'TEXT NULLABLE',
        'reason': 'TEXT NULLABLE',
        'amount': 'REAL NULLABLE',
        'payer': 'TEXT NULLABLE',
        'description': 'TEXT NULLABLE',
        'status': 'TEXT NULLABLE',
      };

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'businessId': businessId,
      'mzungukoId': mzungukoId,
      'expenseDate': expenseDate,
      'reason': reason,
      'amount': amount,
      'payer': payer,
      'description': description,
      'status': status,
    };
  }

  @override
  ExpensesModel fromMap(Map<String, dynamic> map) {
    return ExpensesModel(
      id: map['id'],
      businessId: map['businessId'],
      mzungukoId: map['mzungukoId'],
      expenseDate: map['expenseDate'],
      reason: map['reason'],
      amount: map['amount'],
      payer: map['payer'],
      description: map['description'],
      status: map['status'],
    );
  }
}