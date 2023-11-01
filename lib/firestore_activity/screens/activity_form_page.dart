import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:foresty/components/my_dropdown.dart';
import 'package:foresty/components/my_button.dart';
import '../../components/my_textField.dart';
import '../../firestore_batch/models/batch.dart';

class ActivityFormPage extends StatefulWidget {
  ActivityFormPage({Key? key}) : super(key: key);

  @override
  _ActivityFormPageState createState() => _ActivityFormPageState();
}

class _ActivityFormPageState extends State<ActivityFormPage> {
  final TextEditingController _tamanho = TextEditingController();
  final TextEditingController _quantidadeSDController = TextEditingController();
  final TextEditingController _larguraPlantioController =
      TextEditingController();
  final TextEditingController _comprimentoPlantioController =
      TextEditingController();

  String labelTitle = 'Adicionar Atividade';
  String selectedDateAtividade = '';
  String selectedDateSD = '';
  ValueNotifier<String> selectedAtividade = ValueNotifier<String>('Selecione');
  ValueNotifier<String> selectedPlantio = ValueNotifier<String>('Selecione');

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final itemListTipoAtividade = [
    'Selecione',
    'Preparo do solo',
    'Plantio',
    'Manejo de pragas',
    'Manejo de doenças',
    'Adubação de cobertura',
    'Capina',
    'Outros tratos culturais',
  ];

  final itemListTipoPlantio = [
    'Selecione',
    'Semeadura direta',
    'Transplantio de mudas',
    'Replantio',
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text(labelTitle),
      ),
      body: Container(
        alignment: Alignment.topLeft,
        child: ListView(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          padding: EdgeInsets.all(16.0),
          children: [
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Atividade',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[900],
                ),
              ),
            ),
            const SizedBox(height: 4),
            MyDropdownFormField(
              selectedValueNotifier: selectedAtividade,
              itemsList: itemListTipoAtividade,
              onChanged: (value) {
                setState(() {
                  selectedAtividade.value = value!;
                });
              },
            ),
            if (selectedAtividade.value == 'Preparo do solo')
              Column(
                children: [
                  SizedBox(height: 18),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey[300]!, // Border color
                        width: 1.0, // Border width
                      ),
                      borderRadius:
                          BorderRadius.circular(15.0), // Border radius
                    ),
                    child: DateTimePicker(
                      type: DateTimePickerType.date,
                      dateMask: 'dd/MM/yyyy',
                      initialValue: selectedDateAtividade,
                      firstDate: DateTime(2023),
                      lastDate: DateTime(2030),
                      icon: Icon(
                        Icons.calendar_today,
                        color: Colors.green[800]!, // Calendar icon color
                      ),
                      dateLabelText: 'Selecione a data',
                      onChanged: (val) {
                        setState(() {
                          selectedDateAtividade = val;
                        });
                      },
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.grey[900]!,
                      ),
                    ),
                  ),
                ],
              ),
            if (selectedAtividade.value == 'Plantio')
              Column(
                children: [
                  SizedBox(height: 18),
                  Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      'Tipo de Plantio',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[900],
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  MyDropdownFormField(
                    selectedValueNotifier: selectedPlantio,
                    itemsList: itemListTipoPlantio,
                    onChanged: (value) {
                      setState(() {
                        selectedPlantio.value = value!;
                      });
                    },
                  ),
                  const SizedBox(height: 8),
                  if (selectedPlantio.value != 'Selecione')
                    Column(
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            'Data',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[900],
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey[300]!, // Border color
                              width: 1.0, // Border width
                            ),
                            borderRadius:
                                BorderRadius.circular(15.0), // Border radius
                          ),
                          child: DateTimePicker(
                            type: DateTimePickerType.date,
                            dateMask: 'dd/MM/yyyy',
                            initialValue: selectedDateSD,
                            firstDate: DateTime(2023),
                            lastDate: DateTime(2030),
                            icon: Icon(
                              Icons.calendar_today,
                              color: Colors.green[800]!, // Calendar icon color
                            ),
                            dateLabelText: '31/10/2023',
                            onChanged: (val) {
                              setState(() {
                                selectedDateSD = val;
                              });
                            },
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.grey[900]!,
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            'Quantidade',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[900],
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        MyTextFieldWrapper(
                          inputFormatter: MaskTextInputFormatter(
                            filter: {"#": RegExp(r'[0-9xX]')},
                            type: MaskAutoCompletionType.lazy,
                          ),
                          controller: _quantidadeSDController,
                          hintText: '3kg',
                          obscureText: false,
                          validator: (value) {},
                        ),
                      ],
                    ),
                  if (selectedPlantio.value == 'Semeadura direta')
                    Column(
                      children: [
                        const SizedBox(height: 8),
                        Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            'Espaçamento',
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
                              width: 336,
                              child: Column(
                                children: [
                                  MyTextFieldWrapper(
                                    inputFormatter: MaskTextInputFormatter(
                                        filter: {"#": RegExp(r'[0-9xX]')},
                                        type: MaskAutoCompletionType.lazy),
                                    controller: _larguraPlantioController,
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
                                    controller: _comprimentoPlantioController,
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
                      ],
                    ),
                ],
              ),
            if (selectedAtividade.value == 'Manejo de pragas')
              Column(
                children: [
                  Text('Campos adicionais para Manejo de pragas'),
                  // Adicione os campos e widgets adicionais aqui
                ],
              ),
            if (selectedAtividade.value == 'Manejo de doenças')
              Column(
                children: [
                  Text('Campos adicionais para Manejo de doenças'),
                  // Adicione os campos e widgets adicionais aqui
                ],
              ),
            if (selectedAtividade.value == 'Adubação de cobertura')
              Column(
                children: [
                  Text('Campos adicionais para Adubação de cobertura'),
                  // Adicione os campos e widgets adicionais aqui
                ],
              ),
            if (selectedAtividade.value == 'Capina')
              Column(
                children: [
                  Text('Campos adicionais para Capina'),
                  // Adicione os campos e widgets adicionais aqui
                ],
              ),
            if (selectedAtividade.value == 'Outros tratos culturais')
              Column(
                children: [
                  Text('Campos adicionais para Outros tratos culturais'),
                  // Adicione os campos e widgets adicionais aqui
                ],
              ),
            // Continue com outras opções de finalidade
          ],
        ),
      ),
    );
  }
}
