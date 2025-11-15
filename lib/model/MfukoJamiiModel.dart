import 'package:chomoka/model/BaseModel.dart';

class MfukoJamiiModel extends BaseModel {
  int? id;
  int? mzungukoId;
  String? mfuko_key;
  String? value;
  String? status;

  MfukoJamiiModel({
    this.id,
    this.mzungukoId,
    this.mfuko_key,
    this.value,
    this.status,
  });

  @override
  String get tableName => 'mfuko_jamii';
  @override
  Map<String, String> get columns => {
        'id': 'INTEGER PRIMARY KEY AUTOINCREMENT',
        'mzungukoId': 'INTEGER NULLABLE',
        'mfuko_key': 'TEXT NULLABLE',
        'value': 'TEXT NULLABLE',
        'status': 'TEXT NULLABLE',
      };

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'mzungukoId': mzungukoId,
      'value': value,
      'mfuko_key': mfuko_key,
      'status': status,
    };
  }

  @override
  MfukoJamiiModel fromMap(Map<String, dynamic> map) {
    return MfukoJamiiModel(
      id: map['id'],
      mzungukoId: map['mzungukoId'],
      value: map['value'],
      mfuko_key: map['mfuko_key'],
      status: map['status'],
    );
  }
}
