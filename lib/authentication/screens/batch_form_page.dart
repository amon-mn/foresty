import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foresty/components/my_dropdown.dart';
import 'package:foresty/components/my_textfield.dart';
import 'package:foresty/models/batch.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:foresty/components/forms_provider.dart';

import '../../components/my_button.dart';

class BatchFormPage extends StatefulWidget {
  final ProductBatch productBatch;

  const BatchFormPage({
    super.key,
    required this.productBatch,
  });

  @override
  _BatchFormPageState createState() => _BatchFormPageState();
}

class _BatchFormPageState extends State<BatchFormPage> {
  FirebaseFirestore db = FirebaseFirestore.instance;

  final TextEditingController _batchNameController = TextEditingController();
  final TextEditingController _larguraController = TextEditingController();
  final TextEditingController _comprimentoController = TextEditingController();
  final TextEditingController _localController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _selectedValueNotifierFinalidade = ValueNotifier<String>('Selecione');
  final _selectedValueNotifierAmbiente = ValueNotifier<String>('Selecione');
  final _selectedValueNotifierTipoCultivo = ValueNotifier<String>('Selecione');

  final itemList1 = [
    'Selecione',
    'Plantio de frutas',
    'Plantio de hortaliças',
    'Plantio de grãos',
    'Agrofloresta',
    'Área de extrativismo rural',
    'Outro (Especificar)',
  ];

  final itemList2 = [
    'Selecione',
    'Terra',
    'Praia',
    'Flutuante',
    'Suspenso',
    'Outro (Especificar)',
  ];

  final itemList3 = [
    'Selecione',
    'Orgânico',
    'Convencional',
    'Agroecológico',
    'Outro (Especificar)',
  ];

  @override
  void dispose() {
    _batchNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String currentBatchId = widget.productBatch.id!;
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text('Novo Lote'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Container(
          height: MediaQuery.of(context).size.height - 40,
          width: MediaQuery.of(context).size.width - 40,
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 15,
                spreadRadius: 5,
              ),
            ],
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            /*
              Text(
                'Nome do Lote',
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700]),
              ),
              MyTextFieldWrapper(
                controller: batchNameController,
                obscureText: false,
              ),
              */
            SizedBox(height: 32.0),
            Text(
              'Código do Novo Lote',
              style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[900]),
            ),
            SizedBox(height: 4.0),
            Container(
              height: 120,
              width: MediaQuery.of(context).size.width - 40,
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 244, 126, 63),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 15,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  currentBatchId,
                  style: TextStyle(
                    fontSize: 24.0, // Adjust the font size as needed
                    color: Colors.white, // Adjust the text color as needed
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(height: 16.0),
            FractionallySizedBox(
              widthFactor: 0.85,
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    Text(
                      'Área do Lote',
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[900]),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Expanded(
                          child: MyTextFieldWrapper(
                            inputFormatter: MaskTextInputFormatter(
                                filter: {"#": RegExp(r'[0-9xX]')},
                                type: MaskAutoCompletionType.lazy),
                            controller: _larguraController,
                            hintText: 'Largura',
                            obscureText: false,
                            validator: (value) {},
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text('m'),
                        const SizedBox(width: 16),
                        const Text('x'),
                        const SizedBox(width: 16),
                        const Text('m'),
                        const SizedBox(width: 8),
                        Expanded(
                          child: MyTextFieldWrapper(
                            inputFormatter: MaskTextInputFormatter(
                              filter: {"#": RegExp(r'[0-9xX]')},
                              type: MaskAutoCompletionType.lazy,
                            ),
                            controller: _comprimentoController,
                            hintText: 'Largura',
                            obscureText: false,
                            validator: (value) {},
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Localização',
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[900]),
                    ),
                    const SizedBox(height: 4),
                    MyTextFieldWrapper(
                      inputFormatter: MaskTextInputFormatter(
                        mask: '#####-###',
                        filter: {"#": RegExp(r'[0-9]')},
                        type: MaskAutoCompletionType.lazy,
                      ),
                      controller: _localController,
                      hintText: 'CEP',
                      obscureText: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "O CEP deve ser preenchido";
                        }
                        if (value.length != 9) {
                          return "O CEP deve ter exatamente 9 dígitos";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Finalidade',
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[900]),
                    ),
                    const SizedBox(height: 4),
                    MyDropdownFormField(
                      selectedValueNotifier: _selectedValueNotifierFinalidade,
                      itemsList: itemList1,
                      onChanged: (value) {
                        setState(() {
                          _selectedValueNotifierFinalidade.value = value!;
                        });
                      },
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Ambiente',
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[900]),
                    ),
                    const SizedBox(height: 4),
                    MyDropdownFormField(
                      selectedValueNotifier: _selectedValueNotifierAmbiente,
                      itemsList: itemList2,
                      onChanged: (value) {
                        setState(() {
                          _selectedValueNotifierAmbiente.value = value!;
                        });
                      },
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Tipo de Cultivo',
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[900]),
                    ),
                    const SizedBox(height: 4),
                    MyDropdownFormField(
                      selectedValueNotifier: _selectedValueNotifierTipoCultivo,
                      itemsList: itemList3,
                      onChanged: (value) {
                        setState(() {
                          _selectedValueNotifierTipoCultivo.value = value!;
                        });
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        MyButton(
                          isRed: true,
                          textButton: 'Descartar',
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                        MyButton(
                          onTap: () {
                            ProductBatch batch = ProductBatch(
                              id: currentBatchId,
                              largura: double.parse(_larguraController.text),
                              comprimento:
                                  double.parse(_comprimentoController.text),
                              finalidade:
                                  _selectedValueNotifierFinalidade.value,
                              ambiente: _selectedValueNotifierAmbiente.value,
                              tipoCultivo:
                                  _selectedValueNotifierTipoCultivo.value,
                            );

                            db
                                .collection("batchs")
                                .doc(batch.id)
                                .set(batch.toMap());

                            Navigator.pop(context);
                          },
                          textButton: 'Salvar',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

/*
  void _saveForm(BuildContext context) {
    final formularioProvider =
        Provider.of<FormularioProvider>(context, listen: false);
    final formName = batchNameController.text;

    if (formName.isNotEmpty) {
      formularioProvider.salvarFormulario(formName, questions, answers);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Lote cadastrado com sucesso'),
      ));
      Navigator.of(context).pop(); // Volte para a página anterior
    }
  }
  */
}
