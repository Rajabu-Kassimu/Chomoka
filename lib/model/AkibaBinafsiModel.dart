import 'package:chomoka/model/BaseModel.dart';

class AkibaBinafsiModel extends BaseModel {
  int? id;
  int? mzungukoId;
  int? meetingId;
  int? userId;
  int? amount;
  bool? isKiakaokilchopita;

  AkibaBinafsiModel({
    this.id,
    this.mzungukoId,
    this.meetingId,
    this.userId,
    this.amount,
    this.isKiakaokilchopita,
  });

  @override
  String get tableName => 'akiba_binafsi';

  @override
  Map<String, String> get columns => {
        'id': 'INTEGER PRIMARY KEY AUTOINCREMENT',
        'meeting_id': 'INTEGER NULLABLE',
        'mzungukoId': 'INTEGER NULLABLE',
        'user_id': 'INTEGER NULLABLE',
        'amount': 'INTEGER NULLABLE',
        'isKiakaokilchopita': 'INTEGER NOT NULL DEFAULT 0',
      };

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'mzungukoId': mzungukoId,
      'meeting_id': meetingId,
      'user_id': userId,
      'amount': amount,
      'isKiakaokilchopita': isKiakaokilchopita == true ? 1 : 0,
    };
  }

  @override
  AkibaBinafsiModel fromMap(Map<String, dynamic> map) {
    return AkibaBinafsiModel(
      id: map['id'] as int?,
      mzungukoId: map['mzungukoId'] as int?,
      meetingId: map['meeting_id'] as int?,
      userId: map['user_id'] as int?,
      amount: map['amount'] as int?,
      isKiakaokilchopita: (map['isKiakaokilchopita'] as int?) == 1,
    );
  }
}
