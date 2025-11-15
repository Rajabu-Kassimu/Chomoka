import 'package:chomoka/model/BaseModel.dart';

class SababuKutoaMfuko extends BaseModel {
  int? id;
  int? mzungukoId;
  String? reasonName;
  String? amount;

  SababuKutoaMfuko({
    this.id,
    this.mzungukoId,
    this.reasonName,
    this.amount,
  });

  @override
  String get tableName => 'sababu_kutoa_mfuko';

  @override
  Map<String, String> get columns => {
        'id': 'INTEGER PRIMARY KEY AUTOINCREMENT',
        'reason_name': 'TEXT NOT NULL',
        'mzungukoId': 'INTEGER NOT NULL',
        'amount': 'TEXT NOT NULL',
      };

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'reason_name': reasonName,
      'mzungukoId': mzungukoId,
      'amount': amount,
    };
  }

  @override
  SababuKutoaMfuko fromMap(Map<String, dynamic> map) {
    return SababuKutoaMfuko(
      id: map['id'] as int?,
      mzungukoId: map['mzungukoId'] as int?,
      reasonName: map['reason_name'] as String?,
      amount: map['amount'] as String?,
    );
  }
}
