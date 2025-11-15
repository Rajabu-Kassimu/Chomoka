import 'package:chomoka/model/BaseModel.dart';

class MatumiziModel extends BaseModel {
  int? id;
  int? meetingId;
  int? mzungukoId;
  String? mfukoType;
  String? matumiziCategory;
  String? matumizi;
  double? amount;
  String? status;

  MatumiziModel({
    this.id,
    this.meetingId,
    this.mzungukoId,
    this.mfukoType,
    this.matumiziCategory,
    this.matumizi,
    this.amount,
    this.status,
  });

  @override
  String get tableName => 'matumizi';

  @override
  Map<String, String> get columns => {
        'id': 'INTEGER PRIMARY KEY AUTOINCREMENT',
        'meetingId': 'INTEGER NULLABLE',
        'mzungukoId': 'INTEGER NULLABLE',
        'mfukoType': 'TEXT NULLABLE',
        'matumiziCategory': 'TEXT NULLABLE',
        'matumizi': 'TEXT NULLABLE',
        'amount': 'REAL NULLABLE',
        'status': 'TEXT NULLABLE',
      };

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'meetingId': meetingId,
      'mzungukoId': mzungukoId,
      'mfukoType': mfukoType,
      'matumiziCategory': matumiziCategory,
      'matumizi': matumizi,
      'amount': amount,
      'status': status,
    };
  }

  @override
  MatumiziModel fromMap(Map<String, dynamic> map) {
    return MatumiziModel(
      id: map['id'],
      meetingId: map['meetingId'],
      mzungukoId: map['mzungukoId'],
      mfukoType: map['mfukoType'],
      matumiziCategory: map['matumiziCategory'],
      matumizi: map['matumizi'],
      amount: map['amount'],
      status: map['status'],
    );
  }
}
