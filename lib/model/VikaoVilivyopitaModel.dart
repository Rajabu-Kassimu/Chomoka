import 'package:chomoka/model/BaseModel.dart';

class VikaovilivyopitaModel extends BaseModel {
  int? id;
  int? mzungukoId;
  String? kikao_key;
  String? value;
  String? status;

  VikaovilivyopitaModel({
    this.id,
    this.mzungukoId,
    this.kikao_key,
    this.value,
    this.status,
  });

  @override
  String get tableName => 'vikao_vilivyopita';
  @override
  Map<String, String> get columns => {
        'id': 'INTEGER PRIMARY KEY AUTOINCREMENT',
        'kikao_key': 'TEXT NULLABLE',
        'mzungukoId': 'INTEGER NULLABLE',
        'value': 'TEXT NULLABLE',
        'status': 'TEXT NULLABLE',
      };

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'mzungukoId': mzungukoId,
      'value': value,
      'kikao_key': kikao_key,
      'status': status,
    };
  }

  @override
  VikaovilivyopitaModel fromMap(Map<String, dynamic> map) {
    return VikaovilivyopitaModel(
      id: map['id'],
      value: map['value'],
      mzungukoId: map['mzungukoId'],
      kikao_key: map['kikao_key'],
      status: map['status'],
    );
  }
}
