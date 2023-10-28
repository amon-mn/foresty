import 'package:uuid/uuid.dart';

class ProductBatch {
  String? id = const Uuid().v4();
  String nomeLote;
  double largura;
  double comprimento;
  double? area;
  double latitude;
  double longitude;
  String finalidade;
  String ambiente;
  String tipoCultivo;
  String? nomeProduto;

  ProductBatch({
    this.id,
    required this.nomeLote,
    required this.largura,
    required this.comprimento,
    this.area,
    required this.latitude,
    required this.longitude,
    required this.finalidade,
    required this.ambiente,
    required this.tipoCultivo,
    this.nomeProduto,
  });

  ProductBatch.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        nomeLote = map['nomeLote'],
        largura = map["largura"],
        comprimento = map["comprimento"],
        area = map["area"],
        latitude = map["latitude"],
        longitude = map["longitude"],
        finalidade = map["finalidade"],
        ambiente = map["ambiente"],
        tipoCultivo = map["tipoCultivo"],
        nomeProduto = map["nomeProduto"];

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "nomeLote": nomeLote,
      "largura": largura,
      "comprimento": comprimento,
      "area": area,
      "latitude": latitude,
      "longitude": longitude,
      "finalidade": finalidade,
      "ambiente": ambiente,
      "tipoCultivo": tipoCultivo,
      "nomeProduto": nomeProduto,
    };
  }
}
