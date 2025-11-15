import 'package:chomoka/model/BaseModel.dart';

class ToaMkopoModel extends BaseModel {
  int? id;
  int? userId;
  int? mzungukoId;
  int? meetingId;
  String? sababuKukopa;
  double? loanAmount;
  double? repayAmount;
  String? mkopoTime;
  String? referees;

  ToaMkopoModel({
    this.id,
    this.userId,
    this.mzungukoId,
    this.meetingId,
    this.sababuKukopa,
    this.loanAmount,
    this.repayAmount,
    this.mkopoTime,
    this.referees,
  });

  @override
  String get tableName => 'toa_mkopo';

  @override
  Map<String, String> get columns => {
        'id': 'INTEGER PRIMARY KEY AUTOINCREMENT',
        'userId': 'INTEGER NULLABLE',
        'mzungukoId': 'INTEGER NULLABLE',
        'meetingId': 'INTEGER NULLABLE',
        'sababuKukopa': 'TEXT NULLABLE',
        'loanAmount': 'REAL NULLABLE',
        'repayAmount': 'REAL NULLABLE',
        'mkopoTime': 'TEXT NULLABLE',
        'referees': 'TEXT NULLABLE',
      };

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'mzungukoId': mzungukoId,
      'meetingId': meetingId,
      'sababuKukopa': sababuKukopa,
      'loanAmount': loanAmount,
      'repayAmount': repayAmount,
      'mkopoTime': mkopoTime,
      'referees': referees,
    };
  }

  @override
  ToaMkopoModel fromMap(Map<String, dynamic> map) {
    return ToaMkopoModel(
      id: map['id'],
      userId: map['userId'],
      mzungukoId: map['mzungukoId'],
      meetingId: map['meetingId'],
      sababuKukopa: map['sababuKukopa'],
      loanAmount: map['loanAmount'],
      repayAmount: map['repayAmount'],
      mkopoTime: map['mkopoTime'],
      referees: map['referees'],
    );
  }
}
