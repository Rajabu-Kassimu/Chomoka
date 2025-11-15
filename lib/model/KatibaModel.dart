import 'package:chomoka/model/BaseModel.dart';

class KatibaModel extends BaseModel {
  int? id;
  int? mzungukoId;
  String? katiba_key;
  String? value;

  KatibaModel({
    this.id,
    this.katiba_key,
    this.mzungukoId,
    this.value,
  });

  @override
  String get tableName => 'katiba';

  @override
  Map<String, String> get columns => {
        'id': 'INTEGER PRIMARY KEY AUTOINCREMENT',
        'katiba_key': 'TEXT NULLABLE',
        'mzungukoId': 'INTEGER NULLABLE',
        'value': 'TEXT NULLABLE',
      };

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'value': value,
      'mzungukoId': mzungukoId,
      'katiba_key': katiba_key,
    };
  }

  @override
  KatibaModel fromMap(Map<String, dynamic> map) {
    return KatibaModel(
      id: map['id'],
      value: map['value'],
      mzungukoId: map['mzungukoId'],
      katiba_key: map['katiba_key'],
    );
  }
}
