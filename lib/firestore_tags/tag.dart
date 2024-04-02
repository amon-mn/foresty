import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class Tag extends StatelessWidget {
  final String peso;
  final String lote;
  final String dataExpedicao;
  final String endereco;
  final String cpfCnpj;
  static const String urlQrCode = 'https://rastechoficial.com/?userId=';
  static const String urlBatchId = '&batchId=';
  final String batchId;
  final String userIdQrCode;
  final String valor;
  final String unidade;
  final String nomeDoProduto;
  final bool showImage;

  Tag({
    required this.peso,
    required this.unidade,
    required this.lote,
    required this.dataExpedicao,
    required this.endereco,
    required this.cpfCnpj,
    required this.userIdQrCode,
    required this.batchId,
    required this.valor,
    required this.nomeDoProduto,
    required this.showImage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            nomeDoProduto,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0),
          ),
          SizedBox(height: 4.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$peso $unidade',
                      style: const TextStyle(fontSize: 16),
                    ),
                    Row(
                      children: [
                        Text(
                          'Lote: $lote',
                          style: const TextStyle(fontSize: 10),
                        ),
                        const SizedBox(width: 4.0),
                        Text(
                          'Data de expedição: $dataExpedicao',
                          style: const TextStyle(fontSize: 10),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      endereco,
                      style: const TextStyle(fontSize: 10),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      'CPF/CNPJ: $cpfCnpj',
                      style: const TextStyle(fontSize: 10),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16.0),
              QrImageView(
                data: '$urlQrCode$userIdQrCode$urlBatchId$batchId',
                version: QrVersions.auto,
                size: 90.0,
              ),
            ],
          ),
          SizedBox(height: 4.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Valor: R\$ $valor',
                          style: TextStyle(fontSize: 18.0),
                        ),
                        Text(
                          '<< PRODUTO RASTREADO >>',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8.0),
              Visibility(
                visible: showImage,
                child: Image.asset(
                  'lib/assets/logo_produto_organico.png',
                  height: 70,
                  width: 90,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
