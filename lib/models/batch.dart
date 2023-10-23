import 'package:uuid/uuid.dart';

class ProductBatch {
  String codProd = const Uuid().v4();
  double largura;
  double comprimento;
  double? area;
  String local;
  String finalidade;
  String ambiente;
  String tipoCultivo;

  ProductBatch({
    required this.largura,
    required this.comprimento,
    this.area,
    required this.local,
    required this.finalidade,
    required this.ambiente,
    required this.tipoCultivo,
  });
}
