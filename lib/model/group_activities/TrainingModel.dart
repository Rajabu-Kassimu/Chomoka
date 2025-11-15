import 'package:chomoka/model/BaseModel.dart';

class TrainingModel extends BaseModel {
  int? id;
  int? mzungukoId;
  String? trainingType;
  String? organization;
  String? trainingDate;
  int? membersCount;
  String? trainer;
  String? status;

  TrainingModel({
    this.id,
    this.mzungukoId,
    this.trainingType,
    this.organization,
    this.trainingDate,
    this.membersCount,
    this.trainer,
    this.status,
  });

  @override
  String get tableName => 'trainings';

  @override
  Map<String, String> get columns => {
        'id': 'INTEGER PRIMARY KEY AUTOINCREMENT',
        'mzungukoId': 'INTEGER NULLABLE',
        'trainingType': 'TEXT NULLABLE',
        'organization': 'TEXT NULLABLE',
        'trainingDate': 'TEXT NULLABLE',
        'membersCount': 'INTEGER NULLABLE',
        'trainer': 'TEXT NULLABLE',
        'status': 'TEXT NULLABLE',
      };

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'mzungukoId': mzungukoId,
      'trainingType': trainingType,
      'organization': organization,
      'trainingDate': trainingDate,
      'membersCount': membersCount,
      'trainer': trainer,
      'status': status,
    };
  }

  @override
  TrainingModel fromMap(Map<String, dynamic> map) {
    return TrainingModel(
      id: map['id'],
      mzungukoId: map['mzungukoId'],
      trainingType: map['trainingType'],
      organization: map['organization'],
      trainingDate: map['trainingDate'],
      membersCount: map['membersCount'],
      trainer: map['trainer'],
      status: map['status'],
    );
  }
}
