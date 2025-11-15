import 'package:chomoka/model/BaseModel.dart';

class InitSetupModel extends BaseModel {
  int? id;
  String? init_key;
  int? mzungukoId;
  String? value;

  InitSetupModel({
    this.id,
    this.init_key,
    this.mzungukoId,
    this.value,
  });

  @override
  String get tableName => 'init_setups';
  @override
  Map<String, String> get columns => {
        'id': 'INTEGER PRIMARY KEY AUTOINCREMENT',
        'init_key': 'TEXT NULLABLE',
        'mzungukoId': 'INTEGER NULLABLE',
        'value': 'TEXT NULLABLE',
      };

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'value': value,
      'mzungukoId': mzungukoId,
      'init_key': init_key,
    };
  }

  @override
  InitSetupModel fromMap(Map<String, dynamic> map) {
    return InitSetupModel(
      id: map['id'],
      value: map['value'],
      mzungukoId: map['mzungukoId'],
      init_key: map['init_key'],
    );
  }
}
