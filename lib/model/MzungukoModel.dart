import 'package:chomoka/model/BaseModel.dart';

class MzungukoModel extends BaseModel {
  int? id;
  String? status;
  double? faida;
  double? jumlaPesaZote;
  double? pesaYaMgao;
  double? akibaMzungukoUjao;

  MzungukoModel({
    this.id,
    this.status,
    this.faida,
    this.jumlaPesaZote,
    this.pesaYaMgao,
    this.akibaMzungukoUjao,
  });

  @override
  String get tableName => 'mzunguko';

  @override
  Map<String, String> get columns => {
        'id': 'INTEGER PRIMARY KEY AUTOINCREMENT',
        'status': 'TEXT NULLABLE',
        'faida': 'REAL NULLABLE',
        'jumlaPesaZote': 'REAL NULLABLE',
        'pesaYaMgao': 'REAL NULLABLE',
        'akibaMzungukoUjao': 'REAL NULLABLE',
      };

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'status': status,
      'faida': faida,
      'jumlaPesaZote': jumlaPesaZote,
      'pesaYaMgao': pesaYaMgao,
      'akibaMzungukoUjao': akibaMzungukoUjao,
    };
  }

  @override
  MzungukoModel fromMap(Map<String, dynamic> map) {
    return MzungukoModel(
      id: map['id'],
      status: map['status'],
      faida: map['faida'],
      jumlaPesaZote: map['jumlaPesaZote'],
      pesaYaMgao: map['pesaYaMgao'],
      akibaMzungukoUjao: map['akibaMzungukoUjao'],
    );
  }
}
