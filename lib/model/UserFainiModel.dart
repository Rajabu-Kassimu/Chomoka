import 'package:chomoka/model/BaseModel.dart';

class UserFainiModel extends BaseModel {
  int? id;
  int? meetingId;
  int? mzungukoId;
  int? userId;
  int? fainiId;
  int? paidfaini;
  int? unpaidfaini;

  UserFainiModel({
    this.id,
    this.meetingId,
    this.mzungukoId,
    this.userId,
    this.fainiId,
    this.paidfaini,
    this.unpaidfaini,
  });

  @override
  String get tableName => 'user_faini';

  @override
  Map<String, String> get columns => {
        'id': 'INTEGER PRIMARY KEY AUTOINCREMENT',
        'meeting_id': 'INTEGER NULLABLE',
        'mzungukoId': 'INTEGER NULLABLE',
        'user_id': 'INTEGER NULLABLE',
        'fainiId': 'INTEGER NULLABLE',
        'paidfaini': 'INTEGER NULLABLE',
        'unpaidfaini': 'INTEGER NULLABLE',
      };

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'meeting_id': meetingId,
      'mzungukoId': mzungukoId,
      'user_id': userId,
      'fainiId': fainiId,
      'paidfaini': paidfaini,
      'unpaidfaini': unpaidfaini,
    };
  }

  @override
  UserFainiModel fromMap(Map<String, dynamic> map) {
    return UserFainiModel(
      id: map['id'] as int?,
      meetingId: map['meeting_id'] as int?,
      mzungukoId: map['mzungukoId'] as int?,
      userId: map['user_id'] as int?,
      fainiId: map['fainiId'] as int?,
      paidfaini: map['paidfaini'] as int?,
      unpaidfaini: map['unpaidfaini'] as int?,
    );
  }
}
