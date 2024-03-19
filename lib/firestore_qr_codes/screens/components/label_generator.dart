import 'package:flutter/material.dart';

class EtiquetaProduto extends StatelessWidget {
  final String titulo;
  final String peso;
  final String lote;
  final String dataExpedicao;
  final String endereco;
  final String cep;
  final String cpfCnpj;
  final double valor;
  final String imagemProduto;
  final String produtoRastreado;

  EtiquetaProduto({
    required this.titulo,
    required this.peso,
    required this.lote,
    required this.dataExpedicao,
    required this.endereco,
    required this.cep,
    required this.cpfCnpj,
    required this.valor,
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
                  Text('Peso - $peso'),
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
                color: Colors.grey, // Adapte conforme sua necessidade
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
                    Center(
                      child: Column(
                        children: [
                          Text(
                            'Valor: R\$ ${valor.toStringAsFixed(2)}',
                            style: TextStyle(fontSize: 18.0),
                          ),
                          Text(
                            '<< $produtoRastreado >>',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16.0),
              Image.asset(
                imagemProduto,
                height: 80, // Aumentei o tamanho da imagem
                width: 100, // Aumentei o tamanho da imagem
              ),
            ],
          ),
          SizedBox(height: 16.0),
        ],
      ),
    );
  }
}
