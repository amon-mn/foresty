import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart'; // Importe a biblioteca qr_flutter

class EtiquetaProduto extends StatelessWidget {
  final ValueNotifier<double> peso;
  final String lote;
  final String dataExpedicao;
  final String endereco;
  final String cpfCnpj;
  final ValueNotifier<double> valor;
  final ValueNotifier<String> unidade;
  final String imagemProduto;
  final String nomeDoProduto;
  final bool
      showImage; // Adicionado o atributo para controlar a visibilidade da imagem

  EtiquetaProduto({
    required this.peso,
    required this.unidade,
    required this.lote,
    required this.dataExpedicao,
    required this.endereco,
    required this.cpfCnpj,
    required this.valor,
    required this.imagemProduto,
    required this.nomeDoProduto,
    required this.showImage, // Adicionado o parâmetro showImage
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
                    ValueListenableBuilder<double>(
                      valueListenable: peso,
                      builder: (context, pesoAtual, _) {
                        return Text(
                          '$pesoAtual ${unidade.value}',
                          style: const TextStyle(fontSize: 16),
                        );
                      },
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
                data: 'RASTECH ',
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
                    ValueListenableBuilder<double>(
                      valueListenable: valor,
                      builder: (context, valorAtual, _) {
                        return Column(
                          children: [
                            Text(
                              'Valor: R\$ ${valorAtual.toStringAsFixed(2)}', // Usando valorAtual
                              style: TextStyle(fontSize: 18.0),
                            ),
                            Text(
                              '<< PRODUTO RASTREADO >>',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8.0),
              Visibility(
                visible:
                    showImage, // Controla a visibilidade com base no estado do checkbox
                child: Image.asset(
                  imagemProduto,
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
