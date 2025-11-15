import 'package:chomoka/model/BaseModel.dart';

class RequestPembejeoModel extends BaseModel {
  int? id;
  int? mzungukoId;
  int? userId;
  String? pembejeoType;
  String? amount;
  String? company;
  double? price;
  double? cost;
  String? requestDate;
  String? status;

  RequestPembejeoModel({
    this.id,
    this.mzungukoId,
    this.userId,
    this.pembejeoType,
    this.amount,
    this.company,
    this.price,
    this.cost,
    this.requestDate,
    this.status = 'pending', // Default status is pending
  });

  @override
  String get tableName => 'request_pembejeo';

  @override
  Map<String, String> get columns => {
        'id': 'INTEGER PRIMARY KEY AUTOINCREMENT',
        'mzungukoId': 'INTEGER NULLABLE',
        'userId': 'INTEGER NULLABLE',
        'pembejeoType': 'TEXT NULLABLE',
        'amount': 'TEXT NULLABLE',
        'company': 'TEXT NULLABLE',
        'price': 'REAL NULLABLE',
        'cost': 'REAL NULLABLE',
        'requestDate': 'TEXT NULLABLE',
        'status': 'TEXT NULLABLE',
      };

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'mzungukoId': mzungukoId,
      'userId': userId,
      'pembejeoType': pembejeoType,
      'amount': amount,
      'company': company,
      'price': price,
      'cost': cost,
      'requestDate': requestDate,
      'status': status,
    };
  }

  @override
  RequestPembejeoModel fromMap(Map<String, dynamic> map) {
    return RequestPembejeoModel(
      id: map['id'] as int?,
      mzungukoId: map['mzungukoId'] as int?,
      userId: map['userId'] as int?,
      pembejeoType: map['pembejeoType'] as String?,
      amount: map['amount'] as String?,
      company: map['company'] as String?,
      price: map['price'] as double?,
      cost: map['cost'] as double?,
      requestDate: map['requestDate'] as String?,
      status: map['status'] as String?,
    );
  }
}