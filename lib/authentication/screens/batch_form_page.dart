import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foresty/components/my_dropdown.dart';
import 'package:foresty/components/my_textfield.dart';
import 'package:foresty/models/batch.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:foresty/components/forms_provider.dart';
import 'package:uuid/uuid.dart';

import '../../components/my_button.dart';
import '../../components/square_tile.dart';

class BatchFormPage extends StatefulWidget {
  const BatchFormPage({
    super.key,
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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text('Novo Lote'),
      ),
      body: Container(
        alignment: Alignment.topLeft,
        child: ListView(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          padding: EdgeInsets.all(16.0),
          children: [
            Container(
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
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            'Área do Lote',
                            style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[900]),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            SizedBox(
                              width: 232,
                              child: Column(
                                children: [
                                  MyTextFieldWrapper(
                                    inputFormatter: MaskTextInputFormatter(
                                        filter: {"#": RegExp(r'[0-9xX]')},
                                        type: MaskAutoCompletionType.lazy),
                                    controller: _larguraController,
                                    hintText: 'Largura',
                                    obscureText: false,
                                    validator: (value) {},
                                  ),
                                  SizedBox(height: 8),
                                  MyTextFieldWrapper(
                                    inputFormatter: MaskTextInputFormatter(
                                      filter: {"#": RegExp(r'[0-9xX]')},
                                      type: MaskAutoCompletionType.lazy,
                                    ),
                                    controller: _comprimentoController,
                                    hintText: 'Comprimento',
                                    obscureText: false,
                                    validator: (value) {},
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 16),
                            Column(
                              children: [
                                Text('m'),
                                SizedBox(height: 16),
                                Text('x'),
                                SizedBox(height: 16),
                                Text('m'),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(height: 16),
                        Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            'Localização',
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[900]),
                          ),
                        ),
                        SizedBox(height: 8),
                        Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.only(left: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment
                                .spaceBetween, // Adicione esta linha
                            children: [
                              Column(
                                children: [
                                  Container(
                                    alignment: Alignment.topLeft,
                                    padding: EdgeInsets.only(left: 10),
                                    child: Text(
                                      'Latitude:',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey[900],
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.topLeft,
                                    padding: EdgeInsets.only(left: 10),
                                    child: Text(
                                      'Longitude:',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey[900],
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                alignment: Alignment.topRight,
                                padding: EdgeInsets.all(10),
                                child: SizedBox(
                                  child: GestureDetector(
                                    onTap: () {},
                                    child:
                                        SquareTite(content: Icons.location_pin),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            'Finalidade',
                            style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[900]),
                          ),
                        ),
                        const SizedBox(height: 4),
                        MyDropdownFormField(
                          selectedValueNotifier:
                              _selectedValueNotifierFinalidade,
                          itemsList: itemList1,
                          onChanged: (value) {
                            setState(() {
                              _selectedValueNotifierFinalidade.value = value!;
                            });
                          },
                        ),
                        SizedBox(height: 16),
                        Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            'Ambiente',
                            style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[900]),
                          ),
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
                        SizedBox(height: 16),
                        Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            'Tipo de Cultivo',
                            style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[900]),
                          ),
                        ),
                        const SizedBox(height: 4),
                        MyDropdownFormField(
                          selectedValueNotifier:
                              _selectedValueNotifierTipoCultivo,
                          itemsList: itemList3,
                          onChanged: (value) {
                            setState(() {
                              _selectedValueNotifierTipoCultivo.value = value!;
                            });
                          },
                        ),
                        SizedBox(height: 18),
                        Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            'Produto',
                            style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[900]),
                          ),
                        ),
                        MyTextFieldWrapper(
                          hintText: 'Ex: Tomate',
                          controller: _batchNameController,
                          obscureText: false,
                        ),
                        SizedBox(height: 18),
                        Row(
                          children: [
                            SizedBox(
                              width: 140,
                              child: MyButton(
                                isRed: true,
                                textButton: 'Descartar',
                                onTap: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                            SizedBox(width: 18),
                            SizedBox(
                              width: 140,
                              child: MyButton(
                                onTap: () {
                                  ProductBatch batch = ProductBatch(
                                    id: Uuid().v4(),
                                    largura:
                                        double.parse(_larguraController.text),
                                    comprimento: double.parse(
                                        _comprimentoController.text),
                                    finalidade:
                                        _selectedValueNotifierFinalidade.value,
                                    ambiente:
                                        _selectedValueNotifierAmbiente.value,
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
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
