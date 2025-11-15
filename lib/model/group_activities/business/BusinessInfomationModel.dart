import 'package:chomoka/model/BaseModel.dart';

class BusinessInformationModel extends BaseModel {
  int? id;
  int? groupId;
  int? mzungukoId;
  String? businessName;
  String? businessLocation;
  String? startDate;
  String? productType;
  String? otherProductType;
  String? status;

  BusinessInformationModel({
    this.id,
    this.groupId,
    this.mzungukoId,
    this.businessName,
    this.businessLocation,
    this.startDate,
    this.productType,
    this.otherProductType,
    this.status,
  });

  @override
  String get tableName => 'business_information';

  @override
  Map<String, String> get columns => {
        'id': 'INTEGER PRIMARY KEY AUTOINCREMENT',
        'groupId': 'INTEGER NULLABLE',
        'mzungukoId': 'INTEGER NULLABLE',
        'businessName': 'TEXT NULLABLE',
        'businessLocation': 'TEXT NULLABLE',
        'startDate': 'TEXT NULLABLE',
        'productType': 'TEXT NULLABLE',
        'otherProductType': 'TEXT NULLABLE',
        'status': 'TEXT NULLABLE',
      };

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'groupId': groupId,
      'mzungukoId': mzungukoId,
      'businessName': businessName,
      'businessLocation': businessLocation,
      'startDate': startDate,
      'productType': productType,
      'otherProductType': otherProductType,
      'status': status,
    };
  }

  @override
  BusinessInformationModel fromMap(Map<String, dynamic> map) {
    return BusinessInformationModel(
      id: map['id'],
      groupId: map['groupId'],
      mzungukoId: map['mzungukoId'],
      businessName: map['businessName'],
      businessLocation: map['businessLocation'],
      startDate: map['startDate'],
      productType: map['productType'],
      otherProductType: map['otherProductType'],
      status: map['status'],
    );
  }
}
