import 'package:chomoka/model/BaseModel.dart';

class RejeshaMkopoModel extends BaseModel {
  int? id;
  int? userId;
  int? mzungukoId;
  int? loanId;
  int? meetingId;
  double? paidAmount;
  double? unpaidAmount;
  double? paymentTime;
  String? payments;

  RejeshaMkopoModel({
    this.id,
    this.userId,
    this.mzungukoId,
    this.loanId,
    this.meetingId,
    this.paidAmount,
    this.unpaidAmount,
    this.paymentTime,
    this.payments,
  });

  @override
  String get tableName => 'rejesha_mkopo';

  @override
  Map<String, String> get columns => {
        'id': 'INTEGER PRIMARY KEY AUTOINCREMENT',
        'user_id': 'INTEGER NULLABLE',
        'mzungukoId': 'INTEGER NULLABLE',
        'loanId': 'INTEGER NULLABLE',
        'meeting_id': 'INTEGER NULLABLE',
        'paidAmount': 'REAL NULLABLE',
        'unpaidAmount': 'REAL NULLABLE',
        'paymentTime': 'REAL NULLABLE',
        'payments': 'TEXT NULLABLE',
      };

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'mzungukoId': mzungukoId,
      'loanId': loanId,
      'meeting_id': meetingId,
      'paidAmount': paidAmount,
      'unpaidAmount': unpaidAmount,
      'paymentTime': paymentTime,
      'payments': payments,
    };
  }

  @override
  RejeshaMkopoModel fromMap(Map<String, dynamic> map) {
    return RejeshaMkopoModel(
      id: map['id'] as int?,
      userId: map['user_id'] as int?,
      mzungukoId: map['mzungukoId'] as int?,
      loanId: map['loanId'] as int?,
      meetingId: map['meeting_id'] as int?,
      paidAmount: (map['paidAmount'] as num?)?.toDouble(),
      unpaidAmount: (map['unpaidAmount'] as num?)?.toDouble(),
      paymentTime: (map['paymentTime'] as num?)?.toDouble(),
      payments: map['payments']?.toString() ?? '[]',
    );
  }
}
