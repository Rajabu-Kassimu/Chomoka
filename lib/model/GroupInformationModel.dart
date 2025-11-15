import 'package:chomoka/model/BaseModel.dart';

class GroupInformationModel extends BaseModel {
  int? id;
  int? mzungukoId;
  String? name;
  String? yearMade;
  int? round;
  String? meetingFrequently;
  int? meetingAmount;
  String? meetingDescription;
  String? registrationStatus;
  String? registeredNumber;
  String? groupInstitution;
  String? projectType;
  String? projectName;
  String? teacherIdentification;
  String? country;
  String? region;
  String? district;
  String? ward;
  String? streetOrVillage;
  String? status;
  String? language;
  int? isReady;

  GroupInformationModel({
    this.id,
    this.mzungukoId,
    this.name,
    this.yearMade,
    this.round,
    this.meetingFrequently,
    this.meetingAmount,
    this.meetingDescription,
    this.registrationStatus,
    this.registeredNumber,
    this.groupInstitution,
    this.projectType,
    this.projectName,
    this.teacherIdentification,
    this.country,
    this.region,
    this.district,
    this.ward,
    this.language,
    this.streetOrVillage,
    this.status,
    this.isReady,
  });

  @override
  String get tableName => 'group_informations';
  @override
  Map<String, String> get columns => {
        'id': 'INTEGER PRIMARY KEY AUTOINCREMENT',
        'name': 'TEXT NULLABLE',
        'yearMade': 'TEXT NULLABLE',
        'round': 'INTEGER NULLABLE',
        'mzungukoId': 'INTEGER NULLABLE',
        'meetingFrequently': 'TEXT NULLABLE',
        'meetingAmount': 'INTEGER NULLABLE',
        'meetingDescription': 'TEXT NULLABLE',
        'registrationStatus': 'INTEGER NULLABLE',
        'registeredNumber': 'TEXT NULLABLE',
        'groupInstitution': 'TEXT NULLABLE',
        'projectType': 'TEXT NULLABLE',
        'projectName': 'TEXT NULLABLE',
        'teacherIdentification': 'TEXT NULLABLE',
        'country': 'TEXT NULLABLE',
        'region': 'TEXT NULLABLE',
        'district': 'TEXT NULLABLE',
        'ward': 'TEXT NULLABLE',
        'streetOrVillage': 'TEXT NULLABLE',
        'status': 'TEXT NULLABLE',
        'language': 'TEXT NULLABLE',
        'isReady': 'INTEGER',
      };

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'mzungukoId': mzungukoId,
      'name': name,
      'yearMade': yearMade,
      'round': round,
      'meetingFrequently': meetingFrequently,
      'meetingAmount': meetingAmount,
      'meetingDescription': meetingDescription,
      'registrationStatus': registrationStatus,
      'registeredNumber': registeredNumber,
      'groupInstitution': groupInstitution,
      'projectType': projectType,
      'projectName': projectName,
      'teacherIdentification': teacherIdentification,
      'country': country,
      'region': region,
      'district': district,
      'ward': ward,
      'streetOrVillage': streetOrVillage,
      'status': status,
      'language': language,
      'isReady': isReady,
    };
  }

  @override
  GroupInformationModel fromMap(Map<String, dynamic> map) {
    return GroupInformationModel(
      id: map['id'],
      mzungukoId: map['mzungukoId'],
      name: map['name'],
      yearMade: map['yearMade'],
      round: map['round'],
      meetingFrequently: map['meetingFrequently'],
      meetingAmount: map['meetingAmount'],
      meetingDescription: map['meetingDescription'],
      registrationStatus: map['registrationStatus'],
      registeredNumber: map['registeredNumber'],
      groupInstitution: map['groupInstitution'],
      projectType: map['projectType'],
      projectName: map['projectName'],
      teacherIdentification: map['teacherIdentification'],
      country: map['country'],
      region: map['region'],
      district: map['district'],
      ward: map['ward'],
      streetOrVillage: map['streetOrVillage'],
      status: map['status'],
      language: map['language'],
      isReady: map['isReady'],
    );
  }
}
