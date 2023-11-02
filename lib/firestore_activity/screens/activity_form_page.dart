import 'package:flutter/material.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:foresty/components/my_dropdown.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../../components/my_textfield.dart';
import '../../firestore_batch/models/batch.dart';

class ActivityFormPage extends StatefulWidget {
  final ProductBatch? batch;

  ActivityFormPage({Key? key, this.batch}) : super(key: key);

  @override
  _ActivityFormPageState createState() => _ActivityFormPageState();
}

class _ActivityFormPageState extends State<ActivityFormPage> {
  final TextEditingController _tamanho = TextEditingController();
  final TextEditingController _nomeDaDoenca = TextEditingController();
  final TextEditingController _quantidadeSDController = TextEditingController();
  final TextEditingController _larguraPlantioController =
      TextEditingController();
  final TextEditingController _comprimentoPlantioController =
      TextEditingController();
  bool? _selectedRadioValue;
  bool? _selectedRadioVetores;
  bool? _selectedRadioValueUnid;
  String labelTitle = 'Adicionar Atividade';
  ValueNotifier<String> selectedAtividade = ValueNotifier<String>('Selecione');
  ValueNotifier<String> selectedPreparoSolo =
      ValueNotifier<String>('Selecione');
  ValueNotifier<String> selectedAdubacao = ValueNotifier<String>('Selecione');
  ValueNotifier<String> selectedPlantio = ValueNotifier<String>('Selecione');
  ValueNotifier<String> selectedTipoAduboQuimico =
      ValueNotifier<String>('Selecione');
  ValueNotifier<String> selectedTipoAduboOrganico =
      ValueNotifier<String>('Selecione');
  ValueNotifier<String> selectedAduboComplementar =
      ValueNotifier<String>('Selecione');
  ValueNotifier<String> selectedTipoControle =
      ValueNotifier<String>('Selecione');
  ValueNotifier<String> selectedTipoCapina = ValueNotifier<String>('Selecione');

  // Variável para armazenar a data selecionada
  String selectedDate = '';
  String selectedDateSD = '';

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

  final itemListTipoPlantio = [
    'Selecione',
    'Semeadura direta',
    'Transplantio de mudas',
    'Replantio',
  ];

  final itemListTipoControle = [
    'Selecione',
    'Remoção de plantas infectadas',
    'Controle de vetores',
  ];

  final itemListTipoCapina = [
    'Selecione',
    'Manual',
    'Mecanizada',
    'Química',
  ];

  final itemListTipoAduboQuimico = [
    'Selecione',
    'NPK',
    'Uréia',
    'Superfosfato triplo',
    'Superfosfato simples',
    'Cloreto de potássio',
    'FTE-BR12',
    'Outro (especificar)',
  ];

  final itemListTipoAduboOrganico = [
    'Selecione',
    'Adubação Verde',
    'Esterco de aves',
    'Esterco de gado',
    'Outro (especificar)',
  ];

  final itemListAduboComplementar = [
    'Selecione',
    'Esterco de aves',
    'Esterco de gado',
    'Matéria orgânica',
    'Composto orgânico',
    'Humus',
    'Outro (especificar)',
    'Não',
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
                'Data da Atividade',
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
                dateLabelText: 'Ex: 31/10/2023',
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
                  if (selectedPreparoSolo.value != 'Selecione')
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
                      ],
                    ),
                  const SizedBox(height: 18),
                  Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      'Adubação pré-plantio',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[900],
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  MyDropdownFormField(
                    selectedValueNotifier: selectedAdubacao,
                    itemsList: itemListAduboPlantio,
                    onChanged: (value) {
                      setState(() {
                        selectedAdubacao.value = value!;
                      });
                    },
                  ),
                  const SizedBox(height: 18),
                  if (selectedAdubacao.value != 'Selecione' &&
                      selectedAdubacao.value != 'Não fez adubação' &&
                      selectedAdubacao.value != 'Química')
                    Column(
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            'Tipo de Adubo',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[900],
                            ),
                          ),
                        ),
                        MyDropdownFormField(
                          selectedValueNotifier: selectedTipoAduboOrganico,
                          itemsList: itemListTipoAduboOrganico,
                          onChanged: (value) {
                            setState(() {
                              selectedTipoAduboOrganico.value = value!;
                            });
                          },
                        ),
                      ],
                    ),
                  if (selectedAdubacao.value == 'Química')
                    Column(
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            'Tipo de Adubo',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[900],
                            ),
                          ),
                        ),
                        MyDropdownFormField(
                          selectedValueNotifier: selectedTipoAduboQuimico,
                          itemsList: itemListTipoAduboQuimico,
                          onChanged: (value) {
                            setState(() {
                              selectedTipoAduboQuimico.value = value!;
                            });
                          },
                        ),
                      ],
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
                            'Data da Semeadura',
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
                            dateLabelText: 'Ex: 31/10/2023',
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
                          hintText: 'Quantidade',
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
                              width: 232,
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
                  const SizedBox(height: 8),
                  Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      'Nome da doença',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[900],
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  MyTextFieldWrapper(
                    hintText: 'Nome',
                    controller: _nomeDaDoenca,
                    obscureText: false,
                  ),
                  const SizedBox(height: 8),
                  Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      'Tipo de Controle',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[900],
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  MyDropdownFormField(
                    selectedValueNotifier: selectedTipoControle,
                    itemsList: itemListTipoControle,
                    onChanged: (value) {
                      setState(() {
                        selectedTipoControle.value = value!;
                      });
                    },
                  ),
                  if (selectedTipoControle.value == 'Controle de vetores')
                    Row(
                      children: [
                        Radio<bool>(
                          value: true,
                          groupValue: _selectedRadioVetores,
                          onChanged: (value) {
                            setState(() {
                              _selectedRadioVetores = value;
                            });
                          },
                          activeColor: Colors.green[800]!,
                        ),
                        Text('Químico'),
                        SizedBox(width: 20),
                        Radio<bool>(
                          value: false,
                          groupValue: _selectedRadioVetores,
                          onChanged: (value) {
                            setState(() {
                              _selectedRadioVetores = value;
                            });
                          },
                          activeColor: Colors.green[800]!,
                        ),
                        Text('Natural'),
                      ],
                    ),
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
                  const SizedBox(height: 8),
                  Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      'Data da Capina',
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
                      dateLabelText: 'Ex: 31/10/2023',
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
                  const SizedBox(height: 8),
                  Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      'Tipo de Capina',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[900],
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  MyDropdownFormField(
                    selectedValueNotifier: selectedTipoCapina,
                    itemsList: itemListTipoCapina,
                    onChanged: (value) {
                      setState(() {
                        selectedTipoCapina.value = value!;
                      });
                    },
                  ),
                  const SizedBox(height: 8),
                  Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      'Qual a dimensão da capina?',
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
                        groupValue: _selectedRadioVetores,
                        onChanged: (value) {
                          setState(() {
                            _selectedRadioVetores = value;
                          });
                        },
                        activeColor: Colors.green[800]!,
                      ),
                      Text('Parte'),
                      SizedBox(width: 20),
                      Radio<bool>(
                        value: false,
                        groupValue: _selectedRadioVetores,
                        onChanged: (value) {
                          setState(() {
                            _selectedRadioVetores = value;
                          });
                        },
                        activeColor: Colors.green[800]!,
                      ),
                      Text('Todo'),
                    ],
                  ),
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
