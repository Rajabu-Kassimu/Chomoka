import 'package:chomoka/model/BaseModel.dart';

class MeetingSetupModel extends BaseModel {
  int? id;
  int? meetingId;
  int? mzungukoId;
  String? meeting_step;
  String? value;

  MeetingSetupModel({
    this.id,
    this.meetingId,
    this.mzungukoId,
    this.meeting_step,
    this.value,
  });

  @override
  String get tableName => 'meeting_step';
  @override
  Map<String, String> get columns => {
        'id': 'INTEGER PRIMARY KEY AUTOINCREMENT',
        'meetingId': 'INTEGER NULLABLE',
        'mzungukoId': 'INTEGER NULLABLE',
        'meeting_step': 'TEXT NULLABLE',
        'value': 'TEXT NULLABLE',
      };

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'meetingId': meetingId,
      'mzungukoId': mzungukoId,
      'value': value,
      'meeting_step': meeting_step,
    };
  }

  @override
  MeetingSetupModel fromMap(Map<String, dynamic> map) {
    return MeetingSetupModel(
      id: map['id'],
      meetingId: map['meetingId'],
      mzungukoId: map['mzungukoId'],
      value: map['value'],
      meeting_step: map['meeting_step'],
    );
  }
}
