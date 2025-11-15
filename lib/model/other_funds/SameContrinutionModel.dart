import 'package:chomoka/model/BaseModel.dart';

class SameContributionModel extends BaseModel {
  int? id;
  int? mzungukoId;
  int? meetingId;
  int? mfukoId;
  int? userId;
  String? status;
  double? amount;  // Added amount field

  SameContributionModel({
    this.id,
    this.mzungukoId,
    this.meetingId,
    this.mfukoId,
    this.userId,
    this.status,
    this.amount,  // Added to constructor
  });

  @override
  String get tableName => 'same_contribution';

  @override
  Map<String, String> get columns => {
        'id': 'INTEGER PRIMARY KEY AUTOINCREMENT',
        'mzungukoId': 'INTEGER NULLABLE',
        'meetingId': 'INTEGER NULLABLE',
        'mfukoId': 'INTEGER NULLABLE',
        'userId': 'INTEGER NULLABLE',
        'status': 'TEXT NULLABLE',
        'amount': 'REAL NULLABLE',  // Added amount column
      };

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'mzungukoId': mzungukoId,
      'meetingId': meetingId,
      'mfukoId': mfukoId,
      'userId': userId,
      'status': status,
      'amount': amount,  // Added to map
    };
  }

  @override
  SameContributionModel fromMap(Map<String, dynamic> map) {
    return SameContributionModel(
      id: map['id'],
      mzungukoId: map['mzungukoId'],
      meetingId: map['meetingId'],
      mfukoId: map['mfukoId'],
      userId: map['userId'],
      status: map['status'],
      amount: map['amount'],  // Added to fromMap
    );
  }
}