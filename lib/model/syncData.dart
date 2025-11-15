import 'package:chomoka/model/BaseModel.dart';

class Syncdata extends BaseModel {
  @override
  String get tableName => 'group_members';

  @override
  Map<String, String> get columns => {};

  @override
  Map<String, dynamic> toMap() {
    return {};
  }

  @override
  Syncdata fromMap(Map<String, dynamic> map) {
    return Syncdata();
  }
}
