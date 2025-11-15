import 'package:chomoka/model/BaseModel.dart';

class GroupMembersModel extends BaseModel {
  int? id;
  int? groupId;
  int? mzungukoId;
  String? name;
  String? gender;
  String? phone;
  String? dob;
  String? memberNumber;
  String? job;
  String? memberIdType;
  String? memberIdNumber;
  String? memberIdImage;
  String? memberImage;
  String? status;

  GroupMembersModel({
    this.id,
    this.groupId,
    this.mzungukoId,
    this.name,
    this.gender,
    this.phone,
    this.dob,
    this.memberNumber,
    this.job,
    this.memberIdType,
    this.memberIdNumber,
    this.memberIdImage,
    this.memberImage,
    this.status,
  });

  @override
  String get tableName => 'group_members';

  @override
  Map<String, String> get columns => {
        'id': 'INTEGER PRIMARY KEY AUTOINCREMENT',
        'groupId': 'INTEGER NULLABLE',
        'mzungukoId': 'INTEGER NULLABLE',
        'name': 'TEXT NULLABLE',
        'gender': 'TEXT NULLABLE',
        'phone': 'TEXT NULLABLE',
        'dob': 'TEXT NULLABLE',
        'memberNumber': 'TEXT NULLABLE',
        'job': 'TEXT NULLABLE',
        'memberIdType': 'TEXT NULLABLE',
        'memberIdNumber': 'TEXT NULLABLE',
        'memberIdImage': 'TEXT NULLABLE',
        'memberImage': 'TEXT NULLABLE',
        'status': 'TEXT NULLABLE',
      };

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'groupId': groupId,
      'mzungukoId': mzungukoId,
      'name': name,
      'gender': gender,
      'phone': phone,
      'dob': dob,
      'memberNumber': memberNumber,
      'job': job,
      'memberIdType': memberIdType,
      'memberIdNumber': memberIdNumber,
      'memberIdImage': memberIdImage,
      'memberImage': memberImage,
      'status': status,
    };
  }

  @override
  GroupMembersModel fromMap(Map<String, dynamic> map) {
    return GroupMembersModel(
      id: map['id'],
      groupId: map['groupId'],
      mzungukoId: map['mzungukoId'],
      name: map['name'],
      gender: map['gender'],
      phone: map['phone'],
      dob: map['dob'],
      memberNumber: map['memberNumber'],
      job: map['job'],
      memberIdType: map['memberIdType'],
      memberIdNumber: map['memberIdNumber'],
      memberIdImage: map['memberIdImage'],
      memberImage: map['memberImage'],
      status: map['status'],
    );
  }
}
