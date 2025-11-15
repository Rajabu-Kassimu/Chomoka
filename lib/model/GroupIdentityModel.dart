import 'package:chomoka/model/BaseModel.dart';

class GroupIdentityModel extends BaseModel {
  int? id;
  String? groupIdentity;

  GroupIdentityModel({
    this.groupIdentity,
    this.id,
  });

  @override
  String get tableName => 'groups_identity';

  @override
  Map<String, String> get columns => {
        'id': 'INTEGER PRIMARY KEY AUTOINCREMENT',
        'groupIdentity': 'TEXT NOT NULL',
      };

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'groupIdentity': groupIdentity,
    };
  }

  @override
  GroupIdentityModel fromMap(Map<String, dynamic> map) {
    return GroupIdentityModel(
      id: map['id'],
      groupIdentity: map['groupIdentity'],
    );
  }
}
