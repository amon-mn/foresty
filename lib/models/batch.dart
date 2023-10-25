import 'package:uuid/uuid.dart';

class ProductBatch {
  String? id = const Uuid().v4();
  double largura;
  double comprimento;
  double? area;
  String? latitude;
  String? longitude;
  String finalidade;
  String ambiente;
  String tipoCultivo;

  ProductBatch({
    this.id,
    required this.largura,
    required this.comprimento,
    this.area,
    this.latitude,
    this.longitude,
    required this.finalidade,
    required this.ambiente,
    required this.tipoCultivo,
  });

  ProductBatch.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        largura = map["largura"],
        comprimento = map["comprimento"],
        area = map["area"],
        latitude = map["latitude"],
        longitude = map["longitude"],
        finalidade = map["finalidade"],
        ambiente = map["ambiente"],
        tipoCultivo = map["tipoCultivo"];

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "largura": largura,
      "comprimento": comprimento,
      "area": area,
      "latitude": latitude,
      "longitude": longitude,
      "finalidade": finalidade,
      "ambiente": ambiente,
      "tipoCultivo": tipoCultivo,
    };
  }
}
