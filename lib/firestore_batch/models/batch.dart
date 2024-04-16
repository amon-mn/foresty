import 'package:foresty/firestore_activity/models/batch_activity.dart';
import 'package:foresty/firestore_harvest/models/harvest.dart';
import 'package:foresty/firestore_qr_codes/models/qrCode.dart';

class ProductBatch {
  String id;
  String? nomeLote;
  double largura;
  double comprimento;
  double? area;
  double latitude;
  double longitude;
  String finalidade;
  String? outraFinalidade;
  String ambiente;
  String? outroAmbiente;
  String tipoCultivo;
  String? outroTipoCultivo;
  String? nomeProduto;
  List<BatchActivity> atividades; // Lista de atividades
  Harvest? colheita;
  BatchQrCode? qrCode;

  ProductBatch({
    required this.id,
    this.nomeLote,
    required this.largura,
    required this.comprimento,
    this.area,
    required this.latitude,
    required this.longitude,
    required this.finalidade,
    this.outraFinalidade,
    required this.ambiente,
    this.outroAmbiente,
    required this.tipoCultivo,
    this.outroTipoCultivo,
    this.nomeProduto,
    List<BatchActivity>? atividades,
    this.colheita,
    this.qrCode, // Inicialize a lista de atividades
  }) : atividades = atividades ?? [];

  ProductBatch.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        nomeLote = map['nomeLote'],
        largura = map["largura"],
        comprimento = map["comprimento"],
        area = map["area"],
        latitude = map["latitude"],
        longitude = map["longitude"],
        finalidade = map["finalidade"],
        outraFinalidade = map["outraFinalidade"],
        ambiente = map["ambiente"],
        outroAmbiente = map["outroAmbiente"],
        tipoCultivo = map["tipoCultivo"],
        outroTipoCultivo = map["outroTipoCultivo"],
        nomeProduto = map["nomeProduto"],
        colheita =
            map['colheita'] != null ? Harvest.fromMap(map['colheita']) : null,
        qrCode =
            map['qrcode'] != null ? BatchQrCode.fromMap(map['qrcode']) : null,
        atividades = (map['atividades'] as List<dynamic>?)
                ?.map((activity) => BatchActivity.fromMap(activity))
                .toList() ??
            [];

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
      "outraFinalidade": outraFinalidade,
      "ambiente": ambiente,
      "outroAmbiente": outroAmbiente,
      "tipoCultivo": tipoCultivo,
      "outroTipoCultivo": outroTipoCultivo,
      "nomeProduto": nomeProduto,
      'colheita': colheita?.toMap(),
      'qrcode': qrCode?.toMap(),
      'atividades': atividades.map((activity) => activity.toMap()).toList(),
    };
  }

  void addActivity(BatchActivity activity) {
    atividades.add(activity);
  }

  void addHarvest(Harvest harvest) {
    colheita = harvest;
  }

  void addQrCode(BatchQrCode qrcode) {
    qrCode = qrcode;
  }
}
