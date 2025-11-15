import 'package:chomoka/model/BaseModel.dart';

class PasswordModel extends BaseModel {
  int? id;
  int? mzungukoId;
  String? password;
  String? question;
  String? answer;
  String? status;

  PasswordModel({
    this.id,
    this.password,
    this.mzungukoId,
    this.question,
    this.answer,
    this.status,
  });

  @override
  String get tableName => 'passwords';

  @override
  Map<String, String> get columns => {
        'id': 'INTEGER PRIMARY KEY AUTOINCREMENT',
        'password': 'TEXT NULLABLE',
        'mzungukoId ': 'INTEGER NULLABLE',
        'question': 'TEXT NULLABLE',
        'answer': 'TEXT NULLABLE',
        'status': 'TEXT NULLABLE',
      };

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'password': password,
      'mzungukoId ': mzungukoId,
      'question': question,
      'answer': answer,
      'status': status,
    };
  }

  @override
  PasswordModel fromMap(Map<String, dynamic> map) {
    return PasswordModel(
      id: map['id'],
      password: map['password'],
      mzungukoId: map['mzungukoId '],
      question: map['question'],
      answer: map['answer'],
      status: map['status'],
    );
  }
}
