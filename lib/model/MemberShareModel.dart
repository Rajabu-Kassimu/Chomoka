import 'package:chomoka/model/BaseModel.dart';

class MemberShareModel extends BaseModel {
  int? id;
  int? meetingId;
  int? mzungukoId;
  int? userId;
  int? numberOfShares;

  MemberShareModel({
    this.id,
    this.meetingId,
    this.mzungukoId,
    this.userId,
    this.numberOfShares,
  });

  @override
  String get tableName => 'member_shares';

  @override
  Map<String, String> get columns => {
        'id': 'INTEGER PRIMARY KEY AUTOINCREMENT',
        'meeting_id': 'INTEGER NULLABLE',
        'mzungukoId': 'INTEGER NULLABLE',
        'user_id': 'INTEGER NOT NULL',
        'number_of_shares': 'INTEGER NULLABLE',
      };

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'meeting_id': meetingId,
      'mzungukoId': mzungukoId,
      'user_id': userId,
      'number_of_shares': numberOfShares,
    };
  }

  @override
  MemberShareModel fromMap(Map<String, dynamic> map) {
    return MemberShareModel(
      id: map['id'],
      meetingId: map['meeting_id'],
      mzungukoId: map['mzungukoId'],
      userId: map['user_id'],
      numberOfShares: map['number_of_shares'],
    );
  }
}