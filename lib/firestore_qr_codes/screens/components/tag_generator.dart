import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart'; // Importe a biblioteca qr_flutter

class EtiquetaProduto extends StatelessWidget {
  final ValueNotifier<double> peso;
  final String lote;
  final String dataExpedicao;
  final String endereco;
  final String cpfCnpj;
  static const String urlQrCode = 'https://rastechoficial.com/?userId=';
  final String dataQrCode;
  final ValueNotifier<double> valor;
  final ValueNotifier<String> unidade;
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
    required this.dataQrCode,
    required this.valor,
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
          Row(
            children: [
              Text(
                nomeDoProduto,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0),
              ),
              const SizedBox(width: 8.0),
              ValueListenableBuilder<double>(
                valueListenable: peso,
                builder: (context, pesoAtual, _) {
                  return Text(
                    '$pesoAtual ${unidade.value}',
                    style: const TextStyle(fontSize: 18),
                  );
                },
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
                data: '$urlQrCode$dataQrCode',
                version: QrVersions.auto,
                size: 100.0,
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
                              'Valor: R\$ ${formatarValor(valorAtual)}', // Usando valorAtual
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
                  'lib/assets/logo_produto_organico.png',
                  height: 70,
                  width: 95,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Função para formatar o valor para exibição
  String formatarValor(double valor) {
    // Utilizando formatação de string para substituir o ponto pela vírgula
    return '${valor.toStringAsFixed(2).replaceAll('.', ',')}';
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
