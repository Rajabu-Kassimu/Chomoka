import 'BaseModel.dart';

class MifukoMingineModel extends BaseModel {
  int? id;
  int? mzungukoId;
  String? mfukoName;
  String? goal;
  String? utoajiType;
  String? mfukoAmount;
  String? utaratibuKutoa;
  String? unakopesheka;
  String? status;

  MifukoMingineModel({
    this.id,
    this.mzungukoId,
    this.mfukoName,
    this.goal,
    this.utoajiType,
    this.mfukoAmount,
    this.utaratibuKutoa,
    this.unakopesheka,
    this.status,
  });

  @override
  String get tableName => 'mifuko_mingine';

  @override
  Map<String, String> get columns => {
        'id': 'INTEGER PRIMARY KEY AUTOINCREMENT',
        'mfuko_name': 'TEXT NOT NULL',
        'mzungukoId': 'TEXT NULLABLE',
        'goal': 'TEXT',
        'utoaji_type': 'TEXT',
        'mfuko_amount': 'TEXT',
        'utaratibu_kutoa': 'TEXT',
        'unakopesheka': 'TEXT',
        'status': 'TEXT NOT NULL DEFAULT "sio hai"',
      };

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'mzungukoId': mzungukoId,
      'mfuko_name': mfukoName,
      'goal': goal,
      'utoaji_type': utoajiType,
      'mfuko_amount': mfukoAmount,
      'utaratibu_kutoa': utaratibuKutoa,
      'unakopesheka': unakopesheka,
      'status': status,
    };
  }

  @override
  MifukoMingineModel fromMap(Map<String, dynamic> map) {
    return MifukoMingineModel(
      id: map['id'] is String ? int.tryParse(map['id']) : map['id'] as int?,
      mzungukoId: map['mzungukoId'] is String ? int.tryParse(map['mzungukoId']) : map['mzungukoId'] as int?,
      mfukoName: map['mfuko_name'],
      goal: map['goal'] as String?,
      utoajiType: map['utoaji_type'] as String?,
      mfukoAmount: map['mfuko_amount'] as String?,
      utaratibuKutoa: map['utaratibu_kutoa'] as String?,
      unakopesheka: map['unakopesheka'] as String?,
      status: map['status'] as String?,
    );
  }
}
