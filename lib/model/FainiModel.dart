import 'package:chomoka/model/BaseModel.dart';

class FainiModel extends BaseModel {
  int? id;
  int? mzungukoId;
  int? group_id;
  String? penaltiesName;
  String? penaltiesPrice;

  FainiModel({
    this.id,
    this.group_id,
    this.mzungukoId,
    this.penaltiesName,
    this.penaltiesPrice,
  });

  @override
  String get tableName => 'faini';

  @override
  Map<String, String> get columns => {
        'id': 'INTEGER PRIMARY KEY AUTOINCREMENT',
        'group_id': 'INTEGER NULLABLE',
        'mzungukoId': 'INTEGER NULLABLE',
        'penalties_name': 'TEXT NULLABLE',
        'penalties_price': 'TEXT NULLABLE',
      };

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'group_id': group_id,
      'mzungukoId': mzungukoId,
      'penalties_name': penaltiesName,
      'penalties_price': penaltiesPrice,
    };
  }

  @override
  FainiModel fromMap(Map<String, dynamic> map) {
    return FainiModel(
      id: map['id'] as int?,
      group_id: map['group_id'] as int?,
      mzungukoId: map['mzungukoId'] as int?,
      penaltiesName: map['penalties_name'] as String?,
      penaltiesPrice: map['penalties_price']?.toString(),
    );
  }
}
