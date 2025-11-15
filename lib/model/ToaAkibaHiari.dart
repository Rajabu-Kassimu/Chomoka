import 'dart:convert';
import 'package:chomoka/model/BaseModel.dart';

class ToaAkibaHiariModel extends BaseModel {
  int? id;
  int? userId;
  int? mzungukoId;
  int? meetingId;
  double? amount;
  List<Map<String, dynamic>>? history;
  double? availableAmount;
  double? remainAmount;

  ToaAkibaHiariModel({
    this.id,
    this.userId,
    this.mzungukoId,
    this.meetingId,
    this.amount,
    this.history,
    this.availableAmount,
    this.remainAmount,
  });

  @override
  String get tableName => 'toa_akiba_hiari';

  @override
  Map<String, String> get columns => {
        'id': 'INTEGER PRIMARY KEY AUTOINCREMENT',
        'user_id': 'INTEGER NULLABLE',
        'mzungukoId': 'INTEGER NULLABLE',
        'meeting_id': 'INTEGER NULLABLE',
        'amount': 'REAL NULLABLE',
        'history': 'TEXT NULLABLE',
        'available_amount': 'REAL NULLABLE',
        'remain_amount': 'REAL NULLABLE',
      };

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'mzungukoId': mzungukoId,
      'meeting_id': meetingId,
      'amount': amount,
      'history':
          history != null ? jsonEncode(history) : null,  
      'available_amount': availableAmount,
      'remain_amount': remainAmount,
    };
  }

  @override
  ToaAkibaHiariModel fromMap(Map<String, dynamic> map) {
    return ToaAkibaHiariModel(
      id: map['id'] as int?,
      userId: map['user_id'] as int?,
      mzungukoId: map['mzungukoId'] as int?,
      meetingId: map['meeting_id'] as int?,
      amount: (map['amount'] as num?)?.toDouble(),
      history: map['history'] != null
          ? List<Map<String, dynamic>>.from(jsonDecode(map['history']))
          : null, // Deserialize from JSON
      availableAmount: (map['available_amount'] as num?)?.toDouble(),
      remainAmount: (map['remain_amount'] as num?)?.toDouble(),
    );
  }
}
