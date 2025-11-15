import 'package:chomoka/model/BaseModel.dart';

class MeetingModel extends BaseModel {
  int? id;
  int? mzungukoId;
  int? number;
  String? date;
  String? status;

  MeetingModel({
    this.id,
    this.status,
    this.number,
    this.date,
    this.mzungukoId,
  });

  @override
  String get tableName => 'group_meetings';
  @override
  Map<String, String> get columns => {
        'id': 'INTEGER PRIMARY KEY AUTOINCREMENT',
        'status': 'TEXT NULLABLE',
        'mzungukoId': 'INTEGER NULLABLE',
        'number': 'INTEGER NULLABLE',
        'date': 'TEXT NULLABLE',
      };

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'status': status,
      'number': number,
      'date': date,
      'mzungukoId': mzungukoId,
    };
  }

  getLastMeeting(var mzungukoId) {
    var query =
        "SELECT *FROM ${this.tableName} WHERE mzungukoId=$mzungukoId ORDERY BY ID DESC LIMIT 1";
  }

  @override
  MeetingModel fromMap(Map<String, dynamic> map) {
    return MeetingModel(
      id: map['id'],
      status: map['status'],
      number: map['number'],
      date: map['date'],
      mzungukoId: map['mzungukoId'],
    );
  }

  toJson() {}
}
