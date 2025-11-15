import 'package:chomoka/model/BaseModel.dart';

class MadeniKikaoVilivyopitaModel extends BaseModel {
  int? id;
  String? fainaliopigwa;
  String? denimfukojamii;

  MadeniKikaoVilivyopitaModel({
    this.id,
    this.fainaliopigwa,
    this.denimfukojamii,
  });

  @override
  String get tableName => 'madeni_kikao_vilivyopita';

  @override
  Map<String, String> get columns => {
        'id': 'INTEGER PRIMARY KEY AUTOINCREMENT',
        'fainaliopigwa': 'TEXT NULLABLE',
        'denimfukojamii': 'TEXT NULLABLE',
      };

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fainaliopigwa': fainaliopigwa,
      'denimfukojamii': denimfukojamii,
    };
  }

  @override
  MadeniKikaoVilivyopitaModel fromMap(Map<String, dynamic> map) {
    return MadeniKikaoVilivyopitaModel(
      id: map['id'] as int?,
      fainaliopigwa: map['fainaliopigwa'] as String?,
      denimfukojamii: map['denimfukojamii'] as String?,
    );
  }
}
