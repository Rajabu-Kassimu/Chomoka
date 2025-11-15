import 'package:chomoka/model/BaseModel.dart';

class PurchaseModel extends BaseModel {
  int? id;
  int? businessId;
  int? mzungukoId;
  String? purchaseDate;
  double? amount;
  String? buyer;
  String? description;
  String? status;

  PurchaseModel({
    this.id,
    this.businessId,
    this.mzungukoId,
    this.purchaseDate,
    this.amount,
    this.buyer,
    this.description,
    this.status,
  });

  @override
  String get tableName => 'business_purchases';

  @override
  Map<String, String> get columns => {
        'id': 'INTEGER PRIMARY KEY AUTOINCREMENT',
        'businessId': 'INTEGER NULLABLE',
        'mzungukoId': 'INTEGER NULLABLE',
        'purchaseDate': 'TEXT NULLABLE',
        'amount': 'REAL NULLABLE',
        'buyer': 'TEXT NULLABLE',
        'description': 'TEXT NULLABLE',
        'status': 'TEXT NULLABLE',
      };

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'businessId': businessId,
      'mzungukoId': mzungukoId,
      'purchaseDate': purchaseDate,
      'amount': amount,
      'buyer': buyer,
      'description': description,
      'status': status,
    };
  }

  @override
  PurchaseModel fromMap(Map<String, dynamic> map) {
    return PurchaseModel(
      id: map['id'],
      businessId: map['businessId'],
      mzungukoId: map['mzungukoId'],
      purchaseDate: map['purchaseDate'],
      amount: map['amount'],
      buyer: map['buyer'],
      description: map['description'],
      status: map['status'],
    );
  }
}