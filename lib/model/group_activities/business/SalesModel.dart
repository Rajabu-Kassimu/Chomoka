import 'package:chomoka/model/BaseModel.dart';

class SalesModel extends BaseModel {
  int? id;
  int? businessId;
  int? mzungukoId;
  String? saleDate;
  String? customer;
  double? revenue;
  String? seller;
  String? description;
  String? status;

  SalesModel({
    this.id,
    this.businessId,
    this.mzungukoId,
    this.saleDate,
    this.customer,
    this.revenue,
    this.seller,
    this.description,
    this.status,
  });

  @override
  String get tableName => 'business_sales';

  @override
  Map<String, String> get columns => {
        'id': 'INTEGER PRIMARY KEY AUTOINCREMENT',
        'businessId': 'INTEGER NULLABLE',
        'mzungukoId': 'INTEGER NULLABLE',
        'saleDate': 'TEXT NULLABLE',
        'customer': 'TEXT NULLABLE',
        'revenue': 'REAL NULLABLE',
        'seller': 'TEXT NULLABLE',
        'description': 'TEXT NULLABLE',
        'status': 'TEXT NULLABLE',
      };

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'businessId': businessId,
      'mzungukoId': mzungukoId,
      'saleDate': saleDate,
      'customer': customer,
      'revenue': revenue,
      'seller': seller,
      'description': description,
      'status': status,
    };
  }

  @override
  SalesModel fromMap(Map<String, dynamic> map) {
    return SalesModel(
      id: map['id'],
      businessId: map['businessId'],
      mzungukoId: map['mzungukoId'],
      saleDate: map['saleDate'],
      customer: map['customer'],
      revenue: map['revenue'],
      seller: map['seller'],
      description: map['description'],
      status: map['status'],
    );
  }
}