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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    nomeDoProduto,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0),
                  ),
                  const SizedBox(width: 8.0),
                  Text(
                    '$peso $unidade',
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Image.asset(
                  'lib/assets/bw_rastech.png',
                  height: 50,
                  width: 50,
                ),
              ),
            ],
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
                      'Lote: $lote',
                      style: const TextStyle(fontSize: 12),
                    ),
                    Text(
                      'Data de expedição: $dataExpedicao',
                      style: const TextStyle(fontSize: 12),
                    ),
                    Text(
                      endereco,
                      style: const TextStyle(fontSize: 12),
                    ),
                    Text(
                      'CPF/CNPJ: ${mascararCpfCnpj(cpfCnpj)}',
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16.0),
              QrImageView(
                data: '$urlQrCode$userIdQrCode$urlBatchId$batchId',
                version: QrVersions.auto,
                size: 95.0,
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

  String extrairNumeros(String cpfCnpj) {
    return cpfCnpj.replaceAll(
        RegExp(r'\D'), ''); // Remove todos os caracteres não numéricos
  }

// Função para mascarar parcialmente o CPF/CNPJ
  String mascararCpfCnpj(String cpfCnpj) {
    final numeros = extrairNumeros(cpfCnpj); // Extrai apenas os números
    if (numeros.length == 11) {
      // Se for um CPF
      return '***.${numeros.substring(3, 6)}.${numeros.substring(6, 9)}-**';
    } else if (numeros.length == 14) {
      // Se for um CNPJ
      return '${numeros.substring(0, 2)}.***.***/${numeros.substring(8, 12)}*';
    } else {
      return 'CPF/CNPJ inválido';
    }
  }
}
