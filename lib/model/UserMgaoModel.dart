import 'package:chomoka/model/BaseModel.dart';

class UserMgaoModel extends BaseModel {
  int? id;
  int? userId;
  int? mzungukoId;
  double? mgaoAmount;
  double? akibaBinafsi;
  double? mzungukoUjaoAkiba;
  String? type;
  String? status;

  UserMgaoModel({
    this.id,
    this.userId,
    this.mzungukoId,
    this.mgaoAmount,
    this.akibaBinafsi,
    this.mzungukoUjaoAkiba,
    this.type,
    this.status,
  });

  @override
  String get tableName => 'user_mgao';

  @override
  Map<String, String> get columns => {
        'id': 'INTEGER PRIMARY KEY AUTOINCREMENT',
        'userId': 'INTEGER NULLABLE',
        'mzungukoId': 'INTEGER NULLABLE',
        'mgaoAmount': 'REAL NULLABLE',
        'akibaBinafsi': 'REAL NULLABLE',
        'mzungukoUjaoAkiba': 'REAL NULLABLE',
        'type': 'TEXT NULLABLE',
        'status': 'TEXT NULLABLE',
      };

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'mzungukoId': mzungukoId,
      'mgaoAmount': mgaoAmount,
      'akibaBinafsi': akibaBinafsi,
      'mzungukoUjaoAkiba': mzungukoUjaoAkiba,
      'type': type,
      'status': status,
    };
  }

  @override
  UserMgaoModel fromMap(Map<String, dynamic> map) {
    return UserMgaoModel(
      id: map['id'],
      userId: map['userId'],
      mzungukoId: map['mzungukoId'],
      mgaoAmount: map['mgaoAmount'],
      akibaBinafsi: map['akibaBinafsi'],
      mzungukoUjaoAkiba: map['mzungukoUjaoAkiba'],
      type: map['type'],
      status: map['status'],
    );
  }
}
