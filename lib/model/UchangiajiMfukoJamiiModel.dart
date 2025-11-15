import 'package:chomoka/model/BaseModel.dart';

class UchangaajiMfukoJamiiModel extends BaseModel {
  int? id;
  int? meetingId;
  int? mzungukoId;
  int? userId;
  String? paidStatus;
  String? status;
  double? total;

  UchangaajiMfukoJamiiModel({
    this.id,
    this.meetingId,
    this.mzungukoId,
    this.userId,
    this.paidStatus,
    this.status,
    this.total,
  });

  @override
  String get tableName => 'mfuko_jamii_michango';

  @override
  Map<String, String> get columns => {
        'id': 'INTEGER PRIMARY KEY AUTOINCREMENT',
        'meeting_id': 'INTEGER NULLABLE',
        'mzungukoId': 'INTEGER NULLABLE',
        'user_id': 'INTEGER NULLABLE',
        'paid_status': 'TEXT NULLABLE',
        'status': 'TEXT NULLABLE',
        'total': 'REAL NULLABLE',
      };

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'meeting_id': meetingId,
      'mzungukoId': mzungukoId,
      'user_id': userId,
      'paid_status': paidStatus,
      'status': status,
      'total': total,
    };
  }

  @override
  UchangaajiMfukoJamiiModel fromMap(Map<String, dynamic> map) {
    return UchangaajiMfukoJamiiModel(
      id: map['id'],
      meetingId: map['meeting_id'],
      mzungukoId: map['mzungukoId'],
      userId: map['user_id'],
      paidStatus: map['paid_status'],
      status: map['status'],
      total: map['total'],
    );
  }
}
