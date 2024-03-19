import 'package:flutter/material.dart';

class EtiquetaProduto extends StatelessWidget {
  final String titulo;
  final String peso;
  final String unidade;
  final String lote;
  final String dataExpedicao;
  final String endereco;
  final String cep;
  final String cpfCnpj;
  final ValueNotifier<double> valor; // Alterado para ValueNotifier
  final String imagemProduto;
  final String produtoRastreado;

  EtiquetaProduto({
    required this.titulo,
    required this.peso,
    required this.unidade,
    required this.lote,
    required this.dataExpedicao,
    required this.endereco,
    required this.cep,
    required this.cpfCnpj,
    required this.valor, // Atualizado para ValueNotifier
    required this.imagemProduto,
    required this.produtoRastreado,
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
            titulo,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
          ),
          SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Peso - $peso $unidade'),
                  Text('Lote: $lote'),
                  Text('Data de Expedição: $dataExpedicao'),
                  Text('Endereço: $endereco'),
                  Text('CEP: $cep'),
                  Text('CPF/CNPJ: $cpfCnpj'),
                ],
              ),
              SizedBox(width: 16.0),
              Container(
                height: 90,
                width: 90,
                color: Colors.grey,
                child: Center(
                  child: Text('QR Code'),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              '<< $produtoRastreado >>',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16.0),
              Image.asset(
                imagemProduto,
                height: 80,
                width: 100,
              ),
            ],
          ),
          SizedBox(height: 16.0),
        ],
      ),
    );
  }
}
