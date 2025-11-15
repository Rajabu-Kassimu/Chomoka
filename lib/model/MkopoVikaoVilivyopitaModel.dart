import 'package:chomoka/model/BaseModel.dart';

class MkopoVikaoVilivyopitaModel extends BaseModel {
  int? id;
  String? userId;
  String? sababuYaMkopo;
  String? loanAmount;
  String? paidAmount;
  String? kikaoAlichokopa;
  String? loanTime;
  String? ziadaYaMkopo;
  String? referees;
  String? outstandingAmount;

  MkopoVikaoVilivyopitaModel({
    this.id,
    this.userId,
    this.sababuYaMkopo,
    this.loanAmount,
    this.paidAmount,
    this.kikaoAlichokopa,
    this.loanTime,
    this.ziadaYaMkopo,
    this.referees,
    this.outstandingAmount,
  });

  @override
  String get tableName => 'mkopo_vikao_vilivyopita';

  @override
  Map<String, String> get columns => {
        'id': 'INTEGER PRIMARY KEY AUTOINCREMENT', // Corrected line
        'user_id': 'TEXT NULLABLE',
        'sababu_ya_mkopo': 'TEXT NULLABLE',
        'loan_amount': 'TEXT NULLABLE',
        'paid_amount': 'TEXT NULLABLE',
        'kikao_alichokopa': 'TEXT NULLABLE',
        'loan_time': 'TEXT NULLABLE',
        'ziada_ya_mkopo': 'TEXT NULLABLE',
        'referees': 'TEXT NULLABLE',
        'outstandingAmount': 'TEXT NULLABLE',
      };

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'sababu_ya_mkopo': sababuYaMkopo,
      'loan_amount': loanAmount,
      'paid_amount': paidAmount,
      'kikao_alichokopa': kikaoAlichokopa,
      'loan_time': loanTime,
      'ziada_ya_mkopo': ziadaYaMkopo,
      'referees': referees,
      'outstandingAmount': outstandingAmount,
    };
  }

  @override
  MkopoVikaoVilivyopitaModel fromMap(Map<String, dynamic> map) {
    return MkopoVikaoVilivyopitaModel(
      id: map['id'] as int?, // Keep ID as int
      userId: map['user_id']?.toString(),
      sababuYaMkopo: map['sababu_ya_mkopo']?.toString(),
      loanAmount: map['loan_amount']?.toString(),
      paidAmount: map['paid_amount']?.toString(),
      kikaoAlichokopa: map['kikao_alichokopa']?.toString(),
      loanTime: map['loan_time']?.toString(),
      ziadaYaMkopo: map['ziada_ya_mkopo']?.toString(),
      referees: map['referees']?.toString(),
      outstandingAmount: map['outstandingAmount']?.toString(),
    );
  }
}
