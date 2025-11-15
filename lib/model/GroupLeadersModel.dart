import 'package:chomoka/model/BaseModel.dart';

class GroupLeaderModel extends BaseModel {
  int? id;
  int? group_id;
  int? mzungukoId;
  int? user_id;
  String? position;

  GroupLeaderModel({
    this.id,
    this.group_id,
    this.mzungukoId,
    this.user_id,
    this.position,
  });

  @override
  String get tableName => 'group_leaders';

  @override
  Map<String, String> get columns => {
        'id': 'INTEGER PRIMARY KEY AUTOINCREMENT',
        'group_id': 'INTEGER NOT NULL',
        'mzungukoId': 'INTEGER NOT NULL',
        'user_id': 'INTEGER NOT NULL',
        'position': 'TEXT NULLABLE',
      };

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'group_id': group_id,
      'mzungukoId': mzungukoId,
      'user_id': user_id,
      'position': position,
    };
  }

  @override
  GroupLeaderModel fromMap(Map<String, dynamic> map) {
    return GroupLeaderModel(
      id: map['id'],
      group_id: map['group_id'],
      mzungukoId: map['mzungukoId'],
      user_id: map['user_id'],
      position: map['position'],
    );
  }
}
