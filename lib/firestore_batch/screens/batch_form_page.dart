import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foresty/components/my_dropdown.dart';
import 'package:foresty/firestore_activity/models/batch_activity.dart';
import 'package:foresty/firestore_batch/models/batch.dart';
import 'package:foresty/firestore_batch/models/batch_location_controller.dart';
import 'package:foresty/firestore_batch/services/batch_service.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../components/my_button.dart';
import '../../components/my_textfield.dart';
import '../../components/square_tile.dart';

class BatchFormPage extends StatefulWidget {
  ProductBatch? batch;
  BatchActivity? activity;

  BatchFormPage({
    super.key,
    this.batch,
    this.activity,
  });

  @override
  _BatchFormPageState createState() => _BatchFormPageState();
}

class _BatchFormPageState extends State<BatchFormPage> {
  //FirebaseFirestore db = FirebaseFirestore.instance;
  String labelTitle = 'Novo Lote';
  BatchService batchService = BatchService();
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _batchNameController = TextEditingController();
  final TextEditingController _larguraController = TextEditingController();
  final TextEditingController _comprimentoController = TextEditingController();
  final TextEditingController _especificarFinalidadeController =
      TextEditingController();
  final TextEditingController _especificarAmbienteController =
      TextEditingController();
  final TextEditingController _especificarTipoCultivoController =
      TextEditingController();

  double _latBatch = 0.0;
  double _longBatch = 0.0;

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
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    // Verifique se um objeto ProductBatch não nulo foi passado
    if (widget.batch != null) {
      labelTitle = 'Editando ${widget.batch!.nomeLote}';
      // Preencha os campos do formulário com os valores do objeto ProductBatch
      _batchNameController.text = widget.batch!.nomeLote ?? '';
      _larguraController.text = widget.batch!.largura.toString();
      _comprimentoController.text = widget.batch!.comprimento.toString();
      _latBatch = widget.batch!.latitude;
      _longBatch = widget.batch!.longitude;
      _selectedValueNotifierFinalidade.value = widget.batch!.finalidade;
      _selectedValueNotifierAmbiente.value = widget.batch!.ambiente;
      _selectedValueNotifierTipoCultivo.value = widget.batch!.tipoCultivo;
      _productNameController.text = widget.batch!.nomeProduto ?? '';

      if (widget.batch!.outraFinalidade != null) {
        _especificarFinalidadeController.text = widget.batch!.outraFinalidade!;
      }

      if (widget.batch!.outroAmbiente != null) {
        _especificarAmbienteController.text = widget.batch!.outroAmbiente!;
      }

      if (widget.batch!.outroTipoCultivo != null) {
        _especificarTipoCultivoController.text =
            widget.batch!.outroTipoCultivo!;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text(labelTitle),
      ),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        padding: EdgeInsets.all(16.0),
        child: Container(
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
                        'Nome do Lote',
                        style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[900]),
                      ),
                    ),
                    const SizedBox(height: 4),
                    MyTextFieldWrapper(
                      hintText: 'Nome',
                      controller: _batchNameController,
                      obscureText: false,
                    ),
                    const SizedBox(height: 8),
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
                        'Geolocalização',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[900]),
                      ),
                    ),
                    if (widget.batch == null)
                      ChangeNotifierProvider<BatchLocationController>(
                        create: (context) => BatchLocationController(),
                        child: Builder(builder: (context) {
                          final location =
                              context.watch<BatchLocationController>();
                          if (location.error == '') {
                            _latBatch = location.lat;
                            _longBatch = location.long;
                            // Caso não haja erro, exibir latitude e longitude
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: LayoutBuilder(
                                    builder: (context, constraints) {
                                      final maxWidth = constraints.maxWidth;
                                      return Container(
                                        width: maxWidth *
                                            0.6, // Ajuste esse valor para definir a largura máxima do primeiro container
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Color.fromRGBO(
                                                  135, 135, 135, 1)),
                                          color:
                                              Color.fromRGBO(238, 238, 238, 1),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: Column(
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  left: 5),
                                              alignment: Alignment.topLeft,
                                              padding:
                                                  EdgeInsets.only(left: 10),
                                              child: Text(
                                                'Latitude: $_latBatch',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.grey[800],
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  left: 5),
                                              alignment: Alignment.topLeft,
                                              padding:
                                                  EdgeInsets.only(left: 10),
                                              child: Text(
                                                'Longitude: $_longBatch',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.grey[800],
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.topRight,
                                  padding: EdgeInsets.all(10),
                                  child: SizedBox(
                                    width:
                                        50, // Ajuste esse valor para definir o tamanho máximo do ícone
                                    child: GestureDetector(
                                      onTap: () {
                                        location
                                            .getPosition(); // Chama a atualização da geolocalização
                                      },
                                      child: const SquareTite(
                                        borderColor:
                                            Color.fromRGBO(135, 135, 135, 1),
                                        isIcon: true,
                                        content: Icon(
                                          Icons.location_pin,
                                          color: Color.fromARGB(255, 0, 90, 3),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          } else {
                            // Caso haja erro, exibir a mensagem de erro
                            return Container(
                              alignment: Alignment.topLeft,
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                location.error,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[900],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            );
                          }
                        }),
                      ),
                    if (widget.batch != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Container(
                          width: MediaQuery.of(context).size.width - 32,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Color.fromRGBO(135, 135, 135, 1)),
                            color: Color.fromRGBO(238, 238, 238, 1),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(left: 05),
                                alignment: Alignment.topLeft,
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                  'Latitude: $_latBatch',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[800],
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 05),
                                alignment: Alignment.topLeft,
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                  'Longitude: $_longBatch',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[800],
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
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
                      selectedValueNotifier: _selectedValueNotifierFinalidade,
                      itemsList: itemList1,
                      onChanged: (value) {
                        setState(() {
                          _selectedValueNotifierFinalidade.value = value!;
                        });
                      },
                    ),
                    if (_selectedValueNotifierFinalidade.value ==
                        'Outro (Especificar)')
                      Column(
                        children: [
                          const SizedBox(height: 16),
                          Container(
                            alignment: Alignment.topLeft,
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              'Especifique a Finalidade',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[900],
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          MyTextFieldWrapper(
                            controller: _especificarFinalidadeController,
                            hintText: 'Especificar',
                            obscureText: false,
                            validator: (value) {},
                          ),
                        ],
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
                    if (_selectedValueNotifierAmbiente.value ==
                        'Outro (Especificar)')
                      Column(
                        children: [
                          const SizedBox(height: 16),
                          Container(
                            alignment: Alignment.topLeft,
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              'Especifique o Ambiente',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[900],
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          MyTextFieldWrapper(
                            controller: _especificarAmbienteController,
                            hintText: 'Especificar',
                            obscureText: false,
                            validator: (value) {},
                          ),
                        ],
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
                      selectedValueNotifier: _selectedValueNotifierTipoCultivo,
                      itemsList: itemList3,
                      onChanged: (value) {
                        setState(() {
                          _selectedValueNotifierTipoCultivo.value = value!;
                        });
                      },
                    ),
                    if (_selectedValueNotifierTipoCultivo.value ==
                        'Outro (Especificar)')
                      Column(
                        children: [
                          const SizedBox(height: 16),
                          Container(
                            alignment: Alignment.topLeft,
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              'Especifique o Tipo de Cultivo',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[900],
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          MyTextFieldWrapper(
                            controller: _especificarTipoCultivoController,
                            hintText: 'Especificar',
                            obscureText: false,
                            validator: (value) {},
                          ),
                        ],
                      ),
                    SizedBox(height: 16),
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
                      controller: _productNameController,
                      obscureText: false,
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 131,
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
                          width: 131,
                          child: MyButton(
                            onTap: () {
                              ProductBatch batch = ProductBatch(
                                id: widget.batch?.id ?? Uuid().v4(),
                                nomeLote: _batchNameController.text,
                                largura: double.parse(_larguraController.text),
                                comprimento:
                                    double.parse(_comprimentoController.text),
                                area: double.parse(_larguraController.text) *
                                    double.parse(_comprimentoController.text),
                                latitude: _latBatch,
                                longitude: _longBatch,
                                finalidade:
                                    _selectedValueNotifierFinalidade.value,
                                outraFinalidade:
                                    _selectedValueNotifierFinalidade.value ==
                                            'Outro (Especificar)'
                                        ? _especificarFinalidadeController.text
                                        : '',
                                ambiente: _selectedValueNotifierAmbiente.value,
                                outroAmbiente:
                                    _selectedValueNotifierAmbiente.value ==
                                            'Outro (Especificar)'
                                        ? _especificarAmbienteController.text
                                        : '',
                                tipoCultivo:
                                    _selectedValueNotifierTipoCultivo.value,
                                outroTipoCultivo:
                                    _selectedValueNotifierTipoCultivo.value ==
                                            'Outro (Especificar)'
                                        ? _especificarTipoCultivoController.text
                                        : '',
                                nomeProduto: _productNameController.text,
                                atividades: widget.batch?.atividades ?? [],
                              );

                              batchService.addBatch(batch: batch);

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
      ),
    );
  }
}
