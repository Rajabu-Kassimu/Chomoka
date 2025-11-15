import 'package:chomoka/model/BaseModel.dart';
import 'package:intl/intl.dart';

class ShughuliMbalimbaliModel extends BaseModel {
  int? id;
  String? activityDate;
  String? activityName;
  int? beneficiariesCount;
  String? location;
  var mzungukoId;
  String? status;

  ShughuliMbalimbaliModel({
    this.id,
    this.activityDate,
    this.activityName,
    this.beneficiariesCount,
    this.location,
    this.mzungukoId,
    this.status,
  });

  @override
  String get tableName => 'shughuli_mbalimbalis';

  @override
  Map<String, String> get columns => {
        'id': 'INTEGER PRIMARY KEY AUTOINCREMENT',
        'activityDate': 'TEXT',
        'activityName': 'TEXT',
        'beneficiariesCount': 'INTEGER',
        'location': 'TEXT',
        'mzungukoId': 'INTEGER',
        'status': 'TEXT',
      };

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'activityDate': activityDate,
      'activityName': activityName,
      'beneficiariesCount': beneficiariesCount,
      'location': location,
      'mzungukoId': mzungukoId,
      'status': status,
    };
  }

  @override
  ShughuliMbalimbaliModel fromMap(Map<String, dynamic> map) {
    return ShughuliMbalimbaliModel(
      id: map['id'],
      activityDate: map['activityDate'],
      activityName: map['activityName'],
      beneficiariesCount: map['beneficiariesCount'],
      location: map['location'],
      mzungukoId: map['mzungukoId'],
      status: map['status'],
    );
  }
}
