import 'package:chomoka/model/BaseModel.dart';

class AkibaLazimaModel extends BaseModel {
  int? id;
  int? meetingId;
  int? mzungukoId;
  int? userId;
  String? paidStatus;
  double? amount;

  AkibaLazimaModel({
    this.id,
    this.mzungukoId,
    this.meetingId,
    this.userId,
    this.paidStatus,
    this.amount,
  });

  @override
  String get tableName => 'akiba_lazima';

  @override
  Map<String, String> get columns => {
        'id': 'INTEGER PRIMARY KEY AUTOINCREMENT',
        'mzungukoId': 'INTEGER NULLABLE',
        'meeting_id': 'INTEGER NULLABLE',
        'user_id': 'INTEGER NOT NULL',
        'paid_status': 'TEXT NULLABLE',
        'amount': 'REAL NULLABLE',
      };

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'meeting_id': meetingId,
      'mzungukoId': mzungukoId,
      'user_id': userId,
      'paid_status': paidStatus,
      'amount': amount,
    };
  }

  @override
  AkibaLazimaModel fromMap(Map<String, dynamic> map) {
    return AkibaLazimaModel(
      id: map['id'],
      meetingId: map['meeting_id'],
      mzungukoId: map['mzungukoId'],
      userId: map['user_id'],
      paidStatus: map['paid_status'],
      amount: map['amount'],
    );
  }
}
