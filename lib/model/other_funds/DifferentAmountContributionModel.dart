import 'package:chomoka/model/BaseModel.dart';

class DifferentAmountContributionModel extends BaseModel {
  int? id;
  int? userId;
  int? meetingId;
  double? paidAmount;
  double? unpaidAmount;
  int? mzungukoId;
  int? mfukoId;

  DifferentAmountContributionModel({
    this.id,
    this.userId,
    this.meetingId,
    this.paidAmount,
    this.unpaidAmount,
    this.mzungukoId,
    this.mfukoId,
  });

  @override
  String get tableName => 'different_amount_contribution';

  @override
  Map<String, String> get columns => {
        'id': 'INTEGER PRIMARY KEY AUTOINCREMENT',
        'userId': 'INTEGER NULLABLE',
        'meetingId': 'INTEGER NULLABLE',
        'paidAmount': 'REAL NULLABLE',
        'unpaidAmount': 'REAL NULLABLE',
        'mzungukoId': 'INTEGER NULLABLE',
        'mfukoId': 'INTEGER NULLABLE',
      };

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'meetingId': meetingId,
      'paidAmount': paidAmount,
      'unpaidAmount': unpaidAmount,
      'mzungukoId': mzungukoId,
      'mfukoId': mfukoId,
    };
  }

  @override
  DifferentAmountContributionModel fromMap(Map<String, dynamic> map) {
    return DifferentAmountContributionModel(
      id: map['id'] as int?,
      userId: map['userId'] as int?,
      meetingId: map['meetingId'] as int?,
      paidAmount: map['paidAmount'] as double?,
      unpaidAmount: map['unpaidAmount'] as double?,
      mzungukoId: map['mzungukoId'] as int?,
      mfukoId: map['mfukoId'] as int?,
    );
  }
}
