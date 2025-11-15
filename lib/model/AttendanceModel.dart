import 'package:chomoka/model/BaseModel.dart';

class AttendanceModel extends BaseModel {
  int? id;
  int? meetingId;
  int? mzungukoId;
  int? userId;
  String? attendanceStatus;
  String? subAttendanceStatus;
  String? status;

  AttendanceModel({
    this.id,
    this.meetingId,
    this.mzungukoId,
    this.userId,
    this.attendanceStatus,
    this.subAttendanceStatus,
    this.status,
  });

  @override
  String get tableName => 'attendances';

  @override
  Map<String, String> get columns => {
        'id': 'INTEGER PRIMARY KEY AUTOINCREMENT',
        'meeting_id': 'INTEGER NULLABLE',
        'mzungukoId ': 'INTEGER NULLABLE',
        'user_id': 'INTEGER NULLABLE',
        'attendance_status': 'TEXT NULLABLE',
        'sub_attendance_status': 'TEXT NULLABLE',
        'status': 'TEXT NULLABLE',
      };

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'meeting_id': meetingId,
      'mzungukoId': mzungukoId,
      'user_id': userId,
      'attendance_status': attendanceStatus,
      'sub_attendance_status': subAttendanceStatus,
      'status': status,
    };
  }

  @override
  AttendanceModel fromMap(Map<String, dynamic> map) {
    return AttendanceModel(
      id: map['id'],
      meetingId: map['meeting_id'],
      mzungukoId: map['mzungukoId'],
      userId: map['user_id'],
      attendanceStatus: map['attendance_status'],
      subAttendanceStatus: map['sub_attendance_status'],
      status: map['status'],
    );
  }
}
