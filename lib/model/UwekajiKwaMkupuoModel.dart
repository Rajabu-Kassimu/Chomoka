import 'package:chomoka/model/BaseModel.dart';

class UwekajiKwaMkupuoModel extends BaseModel {
  int? id;
  int? meetingId;
  int? mzungukoId;
  String? mfukoType;
  String? ainaUchangiaji;
  double? amount;
  String? status;

  UwekajiKwaMkupuoModel({
    this.id,
    this.mzungukoId,
    this.meetingId,
    this.mfukoType,
    this.ainaUchangiaji,
    this.amount,
    this.status,
  });

  @override
  String get tableName => 'uwekaji_kwa_mkupuo';

  @override
  Map<String, String> get columns => {
        'id': 'INTEGER PRIMARY KEY AUTOINCREMENT',
        'meetingId': 'INTEGER NULLABLE',
        'mzungukoId': 'INTEGER NULLABLE',
        'mfukoType': 'TEXT NULLABLE',
        'ainaUchangiaji': 'TEXT NULLABLE',
        'amount': 'REAL NULLABLE',
        'status': 'REAL NULLABLE',
      };

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'meetingId': meetingId,
      'mzungukoId': mzungukoId,
      'mfukoType': mfukoType,
      'ainaUchangiaji': ainaUchangiaji,
      'amount': amount,
      'status': status,
    };
  }

  @override
  UwekajiKwaMkupuoModel fromMap(Map<String, dynamic> map) {
    return UwekajiKwaMkupuoModel(
      id: map['id'],
      meetingId: map['meetingId'],
      mzungukoId: map['mzungukoId'],
      mfukoType: map['mfukoType'],
      ainaUchangiaji: map['ainaUchangiaji'],
      amount: map['amount'],
      status: map['status'],
    );
  }
}
