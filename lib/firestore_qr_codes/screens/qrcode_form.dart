import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foresty/components/my_button.dart';
import 'package:foresty/components/my_dropdown.dart';
import 'package:foresty/components/my_textfield.dart';
import 'package:foresty/firestore_batch/models/batch.dart';
import 'package:foresty/firestore_qr_codes/screens/components/label_generator.dart';
import 'package:intl/intl.dart'; // Importe a biblioteca intl

class QrCodeFormPage extends StatefulWidget {
  ProductBatch? batch;
  final User user;

  QrCodeFormPage({Key? key, this.batch, required this.user}) : super(key: key);

  @override
  _QrCodeFormPageState createState() => _QrCodeFormPageState();
}

class _QrCodeFormPageState extends State<QrCodeFormPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  ValueNotifier<String> selectedSaleType = ValueNotifier<String>('Selecione');
  final TextEditingController _saleValue = TextEditingController();
  final TextEditingController _labelValue = TextEditingController();
  final TextEditingController _quantitySold = TextEditingController();
  final TextEditingController _quantityOfLabels = TextEditingController();
  final TextEditingController _quantityLabel = TextEditingController();
  final _saleTypeItems = [
    'Selecione',
    'Direta (para o consumidor)',
    'Revenda (outro comerciante)',
  ];

  ValueNotifier<double> _saleAmount = ValueNotifier<double>(0.0);

  @override
  void initState() {
    super.initState();
    // Adicione um listener para o controlador _labelValue
    _labelValue.addListener(_updateSaleAmount);
  }

  @override
  void dispose() {
    // Remova o listener ao descartar a página para evitar memory leaks
    _labelValue.removeListener(_updateSaleAmount);
    super.dispose();
  }

  void _updateSaleAmount() {
    // Atualize _saleAmount apenas com o valor válido do campo _labelValue
    final double? saleAmount = double.tryParse(_labelValue.text);
    if (saleAmount != null) {
      _saleAmount.value = saleAmount;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text('Gerar QR Code'),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          alignment: Alignment.topLeft,
          child: ListView(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            padding: EdgeInsets.all(16.0),
            children: [
              const SizedBox(height: 16),
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  'Tipo de venda',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[900],
                  ),
                ),
              ),
              const SizedBox(height: 4),
              MyDropdownFormField(
                selectedValueNotifier: selectedSaleType,
                itemsList: _saleTypeItems,
                onChanged: (value) {
                  setState(() {
                    selectedSaleType.value = value!;
                  });
                },
              ),
              const SizedBox(height: 16),
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  'Quantidade de venda',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[900],
                  ),
                ),
              ),
              const SizedBox(height: 4),
              SizedBox(
                width: 180,
                child: MyTextFieldWrapper(
                  hintText: 'Número',
                  controller: _quantitySold,
                  obscureText: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, informe a quantidade vendida';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 16),
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  'Valor de venda',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[900],
                  ),
                ),
              ),
              const SizedBox(height: 4),
              SizedBox(
                width: 180,
                child: MyTextFieldWrapper(
                  hintText: 'Número',
                  controller: _labelValue,
                  obscureText: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, informe o valor que irá na etiqueta';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 16),
              EtiquetaProduto(
                titulo: 'Nome do Produto',
                peso: widget.batch?.colheita?.quantidadeProduzida.toString() ??
                    '',
                unidade: widget.batch?.colheita?.unidade.toString() ?? '',
                lote: widget.batch?.nomeLote.toString() ?? '',
                dataExpedicao: DateFormat('dd/MM/yyyy').format(DateTime.now()),
                endereco: '',
                cep: '',
                cpfCnpj: '', // Verifica se o usuário tem CPF ou CNPJ
                valor: _saleAmount, // Passando o valor atualizado
                imagemProduto:
                    'lib/assets/logo_produto_organico.png', // Substitua pelo caminho real da imagem
                produtoRastreado: 'PRODUTO RASTREADO',
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.43,
                    child: MyButton(
                      textButton: 'Descartar',
                      isRed: true,
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.43,
                    child: MyButton(
                      onTap: () async {
                        // Feche o formulário ou faça qualquer outra ação necessária
                        Navigator.pop(context);
                      },
                      textButton: 'Salvar',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
