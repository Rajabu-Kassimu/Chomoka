import 'package:chomoka/model/BaseModel.dart';

class DifferentAmountFundModel extends BaseModel {
  int? id;
  int? mzungukoId;
  int? userId;
  double? amount;
  int? mfukoId;

  DifferentAmountFundModel({
    this.id,
    this.mzungukoId,
    this.userId,
    this.amount,
    this.mfukoId,
  });

  @override
  String get tableName => 'different_amount_fund';

  @override
  Map<String, String> get columns => {
        'id': 'INTEGER PRIMARY KEY AUTOINCREMENT',
        'mzungukoId': 'INTEGER NULLABLE',
        'userId': 'INTEGER NULLABLE',
        'amount': 'REAL NULLABLE',
        'mfukoId': 'INTEGER NULLABLE',
      };

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'mzungukoId': mzungukoId,
      'userId': userId,
      'amount': amount,
      'mfukoId': mfukoId,
    };
  }

  @override
  DifferentAmountFundModel fromMap(Map<String, dynamic> map) {
    return DifferentAmountFundModel(
      id: map['id'] as int?,
      mzungukoId: map['mzungukoId'] as int?,
      userId: map['userId'] as int?,
      amount: map['amount'] as double?,
      mfukoId: map['mfukoId'] as int?,
    );
  }
}
