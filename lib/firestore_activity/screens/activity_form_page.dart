import 'package:flutter/material.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:provider/provider.dart';
import 'package:foresty/components/my_dropdown.dart';
import 'package:foresty/components/my_button.dart';
import '../../components/my_textField.dart';
import '../../firestore_batch/models/batch.dart';

class ActivityFormPage extends StatefulWidget {
  final ProductBatch? batch;

  ActivityFormPage({Key? key, this.batch}) : super(key: key);

  @override
  _ActivityFormPageState createState() => _ActivityFormPageState();
}

class _ActivityFormPageState extends State<ActivityFormPage> {
  final TextEditingController _tamanho = TextEditingController();
  bool? _selectedRadioValue;
  bool? _selectedRadioValueUnid;
  String labelTitle = 'Adicionar Atividade';
  ValueNotifier<String> selectedAtividade = ValueNotifier<String>('Selecione');
  ValueNotifier<String> selectedPreparoSolo =
      ValueNotifier<String>('Selecione');
  ValueNotifier<String> selectedAdubacao = ValueNotifier<String>('Selecione');

  // Variável para armazenar a data selecionada
  String selectedDate = '';

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

  final itemListTipoPreparoSolo = [
    'Selecione',
    'Canteiro',
    'Leira',
    'Cova',
  ];

  final itemListAduboPlantio = [
    'Selecione',
    'Orgânica',
    'Química',
    'Não fez adubação',
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
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey[300]!,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: DateTimePicker(
                type: DateTimePickerType.date,
                dateMask: 'dd/MM/yyyy',
                initialValue: selectedDate,
                firstDate: DateTime(2023),
                lastDate: DateTime(2030),
                icon: Icon(
                  Icons.calendar_today,
                  color: Colors.green[800]!,
                ),
                dateLabelText: 'Selecione a data',
                onChanged: (val) {
                  setState(() {
                    selectedDate = val;
                  });
                },
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey[900]!,
                ),
              ),
            ),
            const SizedBox(height: 18),
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
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      'Tipo',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[900],
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  MyDropdownFormField(
                    selectedValueNotifier: selectedPreparoSolo,
                    itemsList: itemListTipoPreparoSolo,
                    onChanged: (value) {
                      setState(() {
                        selectedPreparoSolo.value = value!;
                      });
                    },
                  ),
                  const SizedBox(height: 18),
                  if (selectedPreparoSolo.value == 'Canteiro')
                    Column(
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            'Tamanho',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[900],
                            ),
                          ),
                        ),
                        MyTextFieldWrapper(
                          hintText: 'Digite um número',
                          controller: _tamanho,
                          obscureText: false,
                        ),
                      ],
                    ),
                  const SizedBox(height: 18),
                  Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      'Fez uso de calcário',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[900],
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Radio<bool>(
                        value: true,
                        groupValue: _selectedRadioValue,
                        onChanged: (value) {
                          setState(() {
                            _selectedRadioValue = value;
                          });
                        },
                        activeColor: Colors.green[800]!,
                      ),
                      Text('Sim'),
                      SizedBox(width: 20),
                      Radio<bool>(
                        value: false,
                        groupValue: _selectedRadioValue,
                        onChanged: (value) {
                          setState(() {
                            _selectedRadioValue = value;
                          });
                        },
                        activeColor: Colors.green[800]!,
                      ),
                      Text('Não'),
                    ],
                  ),
                  // Verifique se a opção selecionada é "Sim"
                  Visibility(
                    visible: _selectedRadioValue == true,
                    child: Column(
                      children: [
                        const SizedBox(height: 18),
                        Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            'Quantidade de calcário',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[900],
                            ),
                          ),
                        ),
                        MyTextFieldWrapper(
                          hintText: 'Digite um número',
                          controller: _tamanho,
                          obscureText: false,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  Column(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          'Quantidade de adubo',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[900],
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      MyTextFieldWrapper(
                        hintText: 'Digite um número',
                        controller: _tamanho,
                        obscureText: false,
                      ),
                      Row(
                        children: [
                          Radio<bool>(
                            value: true,
                            groupValue: _selectedRadioValueUnid,
                            onChanged: (value) {
                              setState(() {
                                _selectedRadioValueUnid = value;
                              });
                            },
                            activeColor: Colors.green[800]!,
                          ),
                          Text('T/ha'),
                          SizedBox(width: 20),
                          Radio<bool>(
                            value: false,
                            groupValue: _selectedRadioValueUnid,
                            onChanged: (value) {
                              setState(() {
                                _selectedRadioValueUnid = value;
                              });
                            },
                            activeColor: Colors.green[800]!,
                          ),
                          Text('Kg/m2'),
                        ],
                      ),
                    ],
                  ),
                ],
              ),

            if (selectedAtividade.value == 'Plantio')
              Column(
                children: [
                  Text('Campos adicionais para Plantio'),
                  // Adicione os campos e widgets adicionais aqui
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
