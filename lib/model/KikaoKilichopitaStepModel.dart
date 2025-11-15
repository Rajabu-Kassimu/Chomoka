import 'package:chomoka/model/BaseModel.dart';

class KikaoKilichopitaModel extends BaseModel {
  int? id;
  String? meeting_step;
  int? mzungukoId;
  String? value;

  KikaoKilichopitaModel({
    this.id,
    this.meeting_step,
    this.mzungukoId,
    this.value,
  });

  @override
  String get tableName => 'kikao_kilichopita_steps';
  @override
  Map<String, String> get columns => {
        'id': 'INTEGER PRIMARY KEY AUTOINCREMENT',
        'meeting_step': 'TEXT NULLABLE',
        'mzungukoId': 'INTEGER NULLABLE',
        'value': 'TEXT NULLABLE',
      };

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'value': value,
      'mzungukoId': mzungukoId,
      'meeting_step': meeting_step,
    };
  }

  @override
  KikaoKilichopitaModel fromMap(Map<String, dynamic> map) {
    return KikaoKilichopitaModel(
      id: map['id'],
      value: map['value'],
      mzungukoId: map['mzungukoId'],
      meeting_step: map['meeting_step'],
    );
  }
}
