import 'package:chomoka/model/BaseModel.dart';

class ToaMfukoJamiiModel extends BaseModel {
  int? id;
  int? userId;
  int? mzungukoId;
  int? meetingId;
  double? amount;
  String? sababu;
  String? history; 

  ToaMfukoJamiiModel({
    this.id,
    this.userId,
    this.mzungukoId,
    this.meetingId,
    this.amount,
    this.sababu,
    this.history,
  });

  @override
  String get tableName => 'toa_mfuko_jamii';

  @override
  Map<String, String> get columns => {
        'id': 'INTEGER PRIMARY KEY AUTOINCREMENT',
        'user_id': 'INTEGER NOT NULL',
        'mzungukoId': 'INTEGER NOT NULL',
        'meeting_id': 'INTEGER NOT NULL',
        'amount': 'REAL NOT NULL',
        'sababu': 'TEXT NOT NULL',
        'history': 'TEXT NULLABLE',
      };

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'mzungukoId': mzungukoId,
      'meeting_id': meetingId,
      'amount': amount,
      'sababu': sababu,
      'history': history,
    };
  }

  @override
  ToaMfukoJamiiModel fromMap(Map<String, dynamic> map) {
    return ToaMfukoJamiiModel(
      id: map['id'] as int?,
      mzungukoId: map['mzungukoId'] as int?,
      userId: map['user_id'] as int?,
      meetingId: map['meeting_id'] as int?,
      amount: map['amount'] as double?,
      sababu: map['sababu'] as String?,
      history: map['history'] as String?,
    );
  }
}
