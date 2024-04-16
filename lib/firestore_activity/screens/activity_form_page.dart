import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:foresty/components/my_button.dart';
import 'package:foresty/components/my_dropdown.dart';
import 'package:foresty/components/show_snackbar.dart';
import 'package:foresty/firestore_activity/models/batch_activity.dart';
import 'package:foresty/firestore_batch/services/batch_service.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:uuid/uuid.dart';
import '../../components/my_textfield.dart';
import '../../firestore_batch/models/batch.dart';

class ActivityFormPage extends StatefulWidget {
  ProductBatch? batch;
  BatchActivity? activity;

  ActivityFormPage({Key? key, this.batch, this.activity}) : super(key: key);

  @override
  _ActivityFormPageState createState() => _ActivityFormPageState();
}

class _ActivityFormPageState extends State<ActivityFormPage> {
  BatchService batchService = BatchService();
  final TextEditingController _tamanho1 = TextEditingController();
  final TextEditingController _custo = TextEditingController();
  final TextEditingController _quantidade1 = TextEditingController();
  final TextEditingController _quantidade2 = TextEditingController();
  final TextEditingController _quantidade3 = TextEditingController();
  final TextEditingController _produtoUtilizado = TextEditingController();
  final TextEditingController _outroTratoController = TextEditingController();
  final TextEditingController _nomeDaDoenca = TextEditingController();
  final TextEditingController _nomeDaPraga = TextEditingController();
  final TextEditingController _nomeOuTipo = TextEditingController();
  final TextEditingController _nomeAgrotoxico = TextEditingController();
  final TextEditingController _nomeInimigoNatural = TextEditingController();
  final TextEditingController _formaUsoInimigoNatural = TextEditingController();
  final TextEditingController _larguraPlantioController =
      TextEditingController();
  final TextEditingController _comprimentoPlantioController =
      TextEditingController();
  bool? _selectedRadioValue;
  bool? _selectedRadioValueUnid;
  bool? _selectedRadioValueDim;
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
  ValueNotifier<String> selectedTipoManejoPragas =
      ValueNotifier<String>('Selecione');
  ValueNotifier<String> selectedTipoControlePragas =
      ValueNotifier<String>('Selecione');
  ValueNotifier<String> selectedTipoControleDoenca =
      ValueNotifier<String>('Selecione');
  ValueNotifier<String> selectedTipoCapina = ValueNotifier<String>('Selecione');
  ValueNotifier<String> selectedTipoTrato = ValueNotifier<String>('Selecione');
  final TextEditingController selectedTipoUnid1 = TextEditingController();
  final TextEditingController selectedTipoUnid2 = TextEditingController();
  ValueNotifier<String> selectedTipoColeta = ValueNotifier<String>('Selecione');

  // Variável para armazenar a data selecionada
  String selectedDate = DateTime.now().toString();
  String selectedDateSD = '';

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final itemListTipoAtividade = [
    'Selecione',
    'Preparo do solo',
    'Plantio',
    'Manejo de pragas',
    'Manejo de doenças',
    'Adubação de cobertura',
    'Capina',
    'Tratos culturais',
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

  final itemListTipoUnid = [
    'Selecione',
    'T/ha',
    'Kg/m2',
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

  final itemListTipoTrato = [
    'Selecione',
    'Poda de limpeza',
    'Limpeza de restos culturais',
    'Outro'
  ];

  final itemListTipoManejoPragas = [
    'Selecione',
    'Aplicação de agrotóxico',
    'Controle natural',
  ];

  final itemListTipoControlePragas = [
    'Selecione',
    'Aplicação de defensivo natural',
    'Coleta e eliminação',
    'Uso de inimigo natural',
  ];

  final itemListTipoControleDoenca = [
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

  final itemListTipoColeta = [
    'Selecione',
    'Coleta de frutos',
    'Coleta de parte da planta',
  ];

  bool _isLoading = false; // Variável para controlar o estado do loading

  // Método para exibir o diálogo de loading
  Widget _buildLoadingIndicator() {
    return Container(
      color: Colors.black.withOpacity(
          0.5), // Define um fundo semi-transparente para destacar o indicador de progresso
      child: Center(
        child:
            CircularProgressIndicator(), // Indicador de progresso centralizado
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    // Verifica se uma atividade existente foi fornecida
    if (widget.activity != null) {
      // Preenche os campos do formulário com as informações da atividade existente
      selectedDate = widget.activity!.dataDaAtividade;
      selectedAtividade.value = widget.activity!.tipoAtividade;
      _custo.text = widget.activity!.custo;

      // Outros campos específicos de cada tipo de atividade
      if (selectedAtividade.value == 'Preparo do solo') {
        // Atividade de Preparo do solo
        var preparoSolo = widget.activity!.preparoSolo;
        selectedPreparoSolo.value = preparoSolo?.tipo ?? 'Selecione';
        _tamanho1.text = preparoSolo?.tamanho ?? '';
        _selectedRadioValue = preparoSolo?.usouCalcario ?? false;
        _quantidade1.text = preparoSolo?.quantidadeCalcario ?? '';
        selectedAdubacao.value = preparoSolo?.tipoAdubacao ?? 'Selecione';
        selectedTipoAduboOrganico.value = preparoSolo?.tipoAdubo ?? 'Selecione';
        selectedTipoAduboQuimico.value = preparoSolo?.tipoAdubo ?? 'Selecione';
        _quantidade3.text = preparoSolo?.quantidade ?? '';
        selectedTipoUnid1.text = preparoSolo?.unidade ?? '';
        _produtoUtilizado.text = preparoSolo?.produtoUtilizado ?? '';
        _quantidade2.text = preparoSolo?.doseAplicada ?? '';
      } else if (selectedAtividade.value == 'Plantio') {
        // Atividade de Plantio
        var plantio = widget.activity!.plantio;
        selectedPlantio.value = plantio?.tipo ?? 'Selecione';
        _quantidade1.text = plantio?.quantidade.toString() ?? '';
        _larguraPlantioController.text = plantio?.largura.toString() ?? '';
        _comprimentoPlantioController.text =
            plantio?.comprimento.toString() ?? '';
      } else if (selectedAtividade.value == 'Manejo de doenças') {
        // Atividade de Manejo de doenças
        var manejoDoencas = widget.activity!.manejoDoencas;
        _nomeDaDoenca.text = manejoDoencas?.nomeDoenca ?? '';
        selectedTipoControleDoenca.value =
            manejoDoencas?.tipoControle ?? 'Selecione';
        _selectedRadioValueUnid = manejoDoencas?.tipoVetor == 'Químico';
        _produtoUtilizado.text = manejoDoencas?.produtoUtilizado ?? '';
        _quantidade1.text = manejoDoencas?.doseAplicada.toString() ?? '';
      } else if (selectedAtividade.value == 'Adubação de cobertura') {
        // Atividade de Adubação de cobertura
        var adubacaoCobertura = widget.activity!.adubacaoCobertura;
        selectedAdubacao.value = adubacaoCobertura?.tipo ?? 'Selecione';
        selectedTipoAduboOrganico.value =
            adubacaoCobertura?.tipoAdubo ?? 'Selecione';
        selectedTipoAduboQuimico.value =
            adubacaoCobertura?.tipoAdubo ?? 'Selecione';
        _quantidade1.text = adubacaoCobertura?.quantidade ?? '';
        selectedTipoUnid1.text = adubacaoCobertura?.unidade ?? 'Selecione';
        _produtoUtilizado.text = adubacaoCobertura?.produtoUtilizado ?? '';
        _quantidade2.text = adubacaoCobertura?.doseAplicada ?? '';
      } else if (selectedAtividade.value == 'Manejo de pragas') {
        // Atividade de Manejo de pragas
        var manejoPragas = widget.activity!.manejoPragas;
        _nomeDaPraga.text = manejoPragas?.nomePraga ?? '';
        selectedTipoManejoPragas.value = manejoPragas?.tipo ?? 'Selecione';
        _nomeAgrotoxico.text = manejoPragas?.nomeAgrotoxico ?? '';
        _quantidade1.text = manejoPragas?.quantidadeRecomendadaAgrotoxico ?? '';
        _quantidade2.text = manejoPragas?.quantidadeAplicadaAgrotoxico ?? '';
        selectedTipoUnid1.text =
            manejoPragas?.unidadeRecomendadaAgrotoxico ?? 'Selecione';
        selectedTipoUnid2.text =
            manejoPragas?.unidadeAplicadaAgrotoxico ?? 'Selecione';
      } else if (selectedAtividade.value == 'Capina') {
        // Atividade de Capina
        var capina = widget.activity!.capina;
        selectedTipoCapina.value = capina?.tipo ?? 'Selecione';
        _produtoUtilizado.text = capina?.nomeProduto ?? '';
        _quantidade1.text = capina?.quantidadeAplicada.toString() ?? '';
        _selectedRadioValueDim = capina?.dimensao == 'Parte';
      } else if (selectedAtividade.value == 'Tratos culturais') {
        // Atividade de Tratos culturais
        var tratosCulturais = widget.activity!.tratosCulturais;
        selectedTipoTrato.value = tratosCulturais?.tipoControle ?? 'Selecione';
        _outroTratoController.text = tratosCulturais?.outroTipo ?? '';
      }

      // Atualiza o estado para refletir as alterações nos campos do formulário
      setState(() {});
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
      body: Form(
        key: formKey,
        child: Stack(
          children: [
            if (_isLoading) _buildLoadingIndicator(),
            Container(
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
                  const SizedBox(height: 16),
                  Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      'Custo da Atividade',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[900],
                      ),
                    ),
                  ),
                  MyTextFieldWrapper(
                    hintText: 'Digite um número',
                    controller: _custo,
                    obscureText: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Informe o custo da atividade.";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 16),
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
                        SizedBox(height: 16),
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
                        const SizedBox(height: 8),
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
                                controller: _tamanho1,
                                obscureText: false,
                              ),
                              const SizedBox(height: 16),
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
                                    const SizedBox(height: 16),
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
                                      controller: _quantidade1,
                                      obscureText: false,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Informe a quantidade de calcário.";
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        const SizedBox(height: 16),
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
                        const SizedBox(height: 16),
                        if (selectedAdubacao.value == 'Química')
                          Column(
                            children: [
                              Container(
                                alignment: Alignment.topLeft,
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                  'Nome do Produto Utilizado',
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
                                controller:
                                    _produtoUtilizado, // Use um novo controller
                                obscureText: false,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Informe o nome do produto utilizado.";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              const SizedBox(height: 16),
                              Container(
                                alignment: Alignment.topLeft,
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                  'Dose Aplicada',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[900],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Expanded(
                                    flex:
                                        10, // Define a proporção do primeiro componente
                                    child: SizedBox(
                                      width: double
                                          .infinity, // Para ocupar todo o espaço disponível
                                      child: Column(
                                        children: [
                                          MyTextFieldWrapper(
                                            inputFormatter:
                                                MaskTextInputFormatter(
                                              filter: {"#": RegExp(r'[0-9xX]')},
                                              type: MaskAutoCompletionType.lazy,
                                            ),
                                            controller:
                                                _quantidade2, // Use um novo controller
                                            hintText: 'Quantidade',
                                            obscureText: false,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return "Informe a quantidade utilizada.";
                                              } else {
                                                return null;
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ), // Adiciona espaço entre os componentes
                                  Expanded(
                                    flex:
                                        1, // Define a proporção do segundo componente
                                    child: Column(
                                      children: [
                                        Text('ml'),
                                        Text('/'),
                                        Text('L'),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 16),
                            ],
                          ),
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
                                selectedValueNotifier:
                                    selectedTipoAduboOrganico,
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
                        const SizedBox(height: 16),
                        if (selectedAdubacao.value != 'Selecione' &&
                            selectedAdubacao.value != 'Não fez adubação')
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
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
                                    SizedBox(
                                      width: double.infinity,
                                      child: MyTextFieldWrapper(
                                        hintText: 'Número',
                                        controller: _quantidade3,
                                        obscureText: false,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Informe a quantidade de adubo utilizado.";
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      alignment: Alignment.topLeft,
                                      padding: EdgeInsets.only(left: 10),
                                      child: Text(
                                        'Unid',
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[900],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    SizedBox(
                                      width: double.infinity,
                                      child: MyTextFieldWrapper(
                                        controller: selectedTipoUnid1,
                                        hintText: 'Unidade',
                                        obscureText: false,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Informe a unidade.";
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  if (selectedAtividade.value == 'Plantio')
                    Column(
                      children: [
                        SizedBox(height: 16),
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
                                controller: _quantidade1,
                                hintText: 'Quantidade',
                                obscureText: false,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Informe a quantidade utilizada.";
                                  } else {
                                    return null;
                                  }
                                },
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
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        MyTextFieldWrapper(
                                          inputFormatter:
                                              MaskTextInputFormatter(
                                            filter: {"#": RegExp(r'[0-9xX]')},
                                            type: MaskAutoCompletionType.lazy,
                                          ),
                                          controller: _larguraPlantioController,
                                          hintText: 'Largura',
                                          obscureText: false,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "Informe a largura.";
                                            } else {
                                              return null;
                                            }
                                          },
                                        ),
                                        SizedBox(height: 8),
                                        MyTextFieldWrapper(
                                          inputFormatter:
                                              MaskTextInputFormatter(
                                            filter: {"#": RegExp(r'[0-9xX]')},
                                            type: MaskAutoCompletionType.lazy,
                                          ),
                                          controller:
                                              _comprimentoPlantioController,
                                          hintText: 'Comprimento',
                                          obscureText: false,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "Informe o comprimento.";
                                            } else {
                                              return null;
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 16),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                  SizedBox(height: 16),
                  if (selectedAtividade.value == 'Manejo de pragas')
                    Column(
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            'Nome da Praga',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[900],
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        MyTextFieldWrapper(
                          hintText: 'Digite um nome',
                          controller: _nomeDaPraga,
                          obscureText: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Informe o nome da praga.";
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(height: 16),
                        Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            'Tipo de Manejo',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[900],
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        MyDropdownFormField(
                          selectedValueNotifier: selectedTipoManejoPragas,
                          itemsList: itemListTipoManejoPragas,
                          onChanged: (value) {
                            setState(() {
                              selectedTipoManejoPragas.value = value!;
                            });
                          },
                        ),
                      ],
                    ),
                  const SizedBox(height: 16),
                  if (selectedTipoManejoPragas.value ==
                          'Aplicação de agrotóxico' &&
                      selectedAtividade.value == 'Manejo de pragas')
                    Column(
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            'Nome do Agrotóxico',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[900],
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        MyTextFieldWrapper(
                          hintText: 'Digite um nome',
                          controller: _nomeAgrotoxico,
                          obscureText: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Informe o nome do agrotóxico.";
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(height: 16),
                        Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        alignment: Alignment.topLeft,
                                        padding: EdgeInsets.only(left: 10),
                                        child: Text(
                                          'Qtd. Recomendada',
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey[900],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      SizedBox(
                                        width: double
                                            .infinity, // Define a largura para ocupar todo o espaço disponível
                                        child: MyTextFieldWrapper(
                                          hintText: 'Número',
                                          controller: _quantidade1,
                                          obscureText: false,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "Informe a quantidade recomendada.";
                                            } else {
                                              return null;
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        alignment: Alignment.topLeft,
                                        padding: EdgeInsets.only(left: 10),
                                        child: Text(
                                          'Unid',
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey[900],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      SizedBox(
                                        width: double
                                            .infinity, // Define a largura para ocupar todo o espaço disponível
                                        child: MyTextFieldWrapper(
                                          controller: selectedTipoUnid1,
                                          hintText: 'Unidade',
                                          obscureText: false,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "Informe a unidade.";
                                            } else {
                                              return null;
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        alignment: Alignment.topLeft,
                                        padding: EdgeInsets.only(left: 10),
                                        child: Text(
                                          'Qtd. Aplicada',
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey[900],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      SizedBox(
                                        width: double
                                            .infinity, // Define a largura para ocupar todo o espaço disponível
                                        child: MyTextFieldWrapper(
                                          hintText: 'Número',
                                          controller: _quantidade2,
                                          obscureText: false,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "Informe a quantidade aplicada.";
                                            } else {
                                              return null;
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        alignment: Alignment.topLeft,
                                        padding: EdgeInsets.only(left: 10),
                                        child: Text(
                                          'Unid',
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey[900],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      SizedBox(
                                        width: double
                                            .infinity, // Define a largura para ocupar todo o espaço disponível
                                        child: MyTextFieldWrapper(
                                          controller: selectedTipoUnid2,
                                          hintText: 'Unidade',
                                          obscureText: false,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "Informe a unidade.";
                                            } else {
                                              return null;
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  if (selectedTipoManejoPragas.value == 'Controle natural' &&
                      selectedAtividade.value == 'Manejo de pragas')
                    Column(
                      children: [
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
                        MyDropdownFormField(
                          selectedValueNotifier: selectedTipoControlePragas,
                          itemsList: itemListTipoControlePragas,
                          onChanged: (value) {
                            setState(() {
                              selectedTipoControlePragas.value = value!;
                            });
                          },
                        ),
                      ],
                    ),
                  SizedBox(height: 16),
                  if (selectedTipoControlePragas.value ==
                          'Aplicação de defensivo natural' &&
                      selectedAtividade.value == 'Manejo de pragas' &&
                      selectedTipoManejoPragas.value == 'Controle natural')
                    Column(
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            'Nome ou Tipo',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[900],
                            ),
                          ),
                        ),
                        MyTextFieldWrapper(
                          hintText: 'Digite um nome',
                          controller: _nomeOuTipo,
                          obscureText: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Informe o nome.";
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(height: 16),
                        Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        alignment: Alignment.topLeft,
                                        padding: EdgeInsets.only(left: 10),
                                        child: Text(
                                          'Qtd. Recomendada',
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey[900],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      SizedBox(
                                        width: double
                                            .infinity, // Define a largura para ocupar todo o espaço disponível
                                        child: MyTextFieldWrapper(
                                          hintText: 'Número',
                                          controller: _quantidade1,
                                          obscureText: false,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "Informe a quantidade recomendada.";
                                            } else {
                                              return null;
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        alignment: Alignment.topLeft,
                                        padding: EdgeInsets.only(left: 10),
                                        child: Text(
                                          'Unid',
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey[900],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      SizedBox(
                                        width: double
                                            .infinity, // Define a largura para ocupar todo o espaço disponível
                                        child: MyTextFieldWrapper(
                                          controller: selectedTipoUnid1,
                                          hintText: 'Unidade',
                                          obscureText: false,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "Informe a unidade.";
                                            } else {
                                              return null;
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        alignment: Alignment.topLeft,
                                        padding: EdgeInsets.only(left: 10),
                                        child: Text(
                                          'Qtd. Aplicada',
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey[900],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      SizedBox(
                                        width: double
                                            .infinity, // Define a largura para ocupar todo o espaço disponível
                                        child: MyTextFieldWrapper(
                                          hintText: 'Número',
                                          controller: _quantidade2,
                                          obscureText: false,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "Informe a quantidade aplicada.";
                                            } else {
                                              return null;
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        alignment: Alignment.topLeft,
                                        padding: EdgeInsets.only(left: 10),
                                        child: Text(
                                          'Unid',
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey[900],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      SizedBox(
                                        width: double
                                            .infinity, // Define a largura para ocupar todo o espaço disponível
                                        child: MyTextFieldWrapper(
                                          controller: selectedTipoUnid2,
                                          hintText: 'Unidade',
                                          obscureText: false,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "Informe a unidade.";
                                            } else {
                                              return null;
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  if (selectedTipoControlePragas.value ==
                          'Coleta e eliminação' &&
                      selectedAtividade.value == 'Manejo de pragas' &&
                      selectedTipoManejoPragas.value == 'Controle natural')
                    Column(
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            'Tipo de Coleta',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[900],
                            ),
                          ),
                        ),
                        MyDropdownFormField(
                          selectedValueNotifier: selectedTipoColeta,
                          itemsList: itemListTipoColeta,
                          onChanged: (value) {
                            setState(() {
                              selectedTipoColeta.value = value!;
                            });
                          },
                        ),
                      ],
                    ),
                  if (selectedTipoControlePragas.value ==
                          'Uso de inimigo natural' &&
                      selectedAtividade.value == 'Manejo de pragas' &&
                      selectedTipoManejoPragas.value == 'Controle natural')
                    Column(
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            'Nome do Inimigo Natural',
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
                          controller: _nomeInimigoNatural,
                          obscureText: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Informe o nome do inimigo natural.";
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(height: 16),
                        Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            'Forma de Uso',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[900],
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        MyTextFieldWrapper(
                          hintText: 'Forma de Uso',
                          controller: _formaUsoInimigoNatural,
                          obscureText: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Informe a forma de uso.";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ],
                    ),
                  if (selectedAtividade.value == 'Manejo de doenças')
                    Column(
                      children: [
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Informe o nome da doença.";
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(height: 16),
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
                          selectedValueNotifier: selectedTipoControleDoenca,
                          itemsList: itemListTipoControleDoenca,
                          onChanged: (value) {
                            setState(() {
                              selectedTipoControleDoenca.value = value!;
                            });
                          },
                        ),
                        const SizedBox(height: 16),
                        if (selectedTipoControleDoenca.value ==
                            'Controle de vetores')
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
                              Text('Químico'),
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
                              Text('Natural'),
                            ],
                          ),
                        const SizedBox(
                          height: 16,
                        )
                      ],
                    ),
                  if (_selectedRadioValueUnid == true &&
                      selectedTipoControleDoenca.value ==
                          'Controle de vetores' &&
                      selectedAtividade.value ==
                          'Manejo de doenças') // Se "Químico" for selecionado
                    Column(
                      children: [
                        const SizedBox(height: 8),
                        Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            'Nome do Produto Utilizado',
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
                          controller:
                              _produtoUtilizado, // Use um novo controller
                          obscureText: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Informe o nome do produto utilizado.";
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(height: 16),
                        Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            'Dose Aplicada',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[900],
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  MyTextFieldWrapper(
                                    inputFormatter: MaskTextInputFormatter(
                                      filter: {"#": RegExp(r'[0-9xX]')},
                                      type: MaskAutoCompletionType.lazy,
                                    ),
                                    controller: _quantidade1,
                                    hintText: 'Quantidade',
                                    obscureText: false,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Informe a dose aplicada.";
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 16),
                            Column(
                              children: [
                                Text('ml'),
                                Text('/'),
                                Text('L'),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 16)
                      ],
                    ),
                  if (selectedAtividade.value == 'Adubação de cobertura')
                    Column(
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            'Adubação pós-plantio',
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
                        const SizedBox(height: 16),
                        if (selectedAdubacao.value == 'Química')
                          Column(
                            children: [
                              Container(
                                alignment: Alignment.topLeft,
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                  'Nome do Produto Utilizado',
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
                                controller:
                                    _produtoUtilizado, // Use um novo controller
                                obscureText: false,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Informe o nome do produto utilizado.";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              const SizedBox(height: 16),
                              Container(
                                alignment: Alignment.topLeft,
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                  'Dose Aplicada',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[900],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        MyTextFieldWrapper(
                                          inputFormatter:
                                              MaskTextInputFormatter(
                                            filter: {"#": RegExp(r'[0-9xX]')},
                                            type: MaskAutoCompletionType.lazy,
                                          ),
                                          controller:
                                              _quantidade1, // Use um novo controller
                                          hintText: 'Quantidade',
                                          obscureText: false,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "Informe a dose aplicada.";
                                            } else {
                                              return null;
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 16),
                                  Column(
                                    children: [
                                      Text('ml'),
                                      Text('/'),
                                      Text('L'),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        const SizedBox(height: 16),
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
                                selectedValueNotifier:
                                    selectedTipoAduboOrganico,
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
                        const SizedBox(height: 16),
                        if (selectedAdubacao.value != 'Selecione' &&
                            selectedAdubacao.value != 'Não fez adubação')
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
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
                                    SizedBox(
                                      width: double.infinity,
                                      child: MyTextFieldWrapper(
                                        hintText: 'Número',
                                        controller: _quantidade2,
                                        obscureText: false,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Informe a quantidade.";
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      alignment: Alignment.topLeft,
                                      padding: EdgeInsets.only(left: 10),
                                      child: Text(
                                        'Unid',
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[900],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    SizedBox(
                                      width: double.infinity,
                                      child: MyTextFieldWrapper(
                                        controller: selectedTipoUnid1,
                                        hintText: 'Unidade',
                                        obscureText: false,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Informe a unidade.";
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        SizedBox(height: 16)
                      ],
                    ),
                  if (selectedAtividade.value == 'Capina')
                    Column(
                      children: [
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
                        const SizedBox(height: 16),
                        if (selectedTipoCapina.value ==
                            'Química') // Mostrar campos adicionais apenas para "Química"
                          Column(
                            children: [
                              Container(
                                alignment: Alignment.topLeft,
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                  'Nome do Produto Utilizado',
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
                                controller:
                                    _produtoUtilizado, // Use um novo controller
                                obscureText: false,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Informe o nome do produto utilizado.";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              const SizedBox(height: 16),
                              Container(
                                alignment: Alignment.topLeft,
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                  'Dose Aplicada',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[900],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        MyTextFieldWrapper(
                                          inputFormatter:
                                              MaskTextInputFormatter(
                                            filter: {"#": RegExp(r'[0-9xX]')},
                                            type: MaskAutoCompletionType.lazy,
                                          ),
                                          controller:
                                              _quantidade1, // Use um novo controller
                                          hintText: 'Quantidade',
                                          obscureText: false,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "Informe a dose aplicada.";
                                            } else {
                                              return null;
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 16),
                                  Column(
                                    children: [
                                      Text('ml'),
                                      Text('/'),
                                      Text('L'),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        const SizedBox(height: 16),
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
                              groupValue: _selectedRadioValueDim,
                              onChanged: (value) {
                                setState(() {
                                  _selectedRadioValueDim = value;
                                });
                              },
                              activeColor: Colors.green[800]!,
                            ),
                            Text('Parte'),
                            SizedBox(width: 20),
                            Radio<bool>(
                              value: false,
                              groupValue: _selectedRadioValueDim,
                              onChanged: (value) {
                                setState(() {
                                  _selectedRadioValueDim = value;
                                });
                              },
                              activeColor: Colors.green[800]!,
                            ),
                            Text('Todo'),
                          ],
                        ),
                        const SizedBox(height: 16)
                      ],
                    ),
                  if (selectedAtividade.value == 'Tratos culturais')
                    Column(
                      children: [
                        const SizedBox(height: 8),
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
                          selectedValueNotifier: selectedTipoTrato,
                          itemsList: itemListTipoTrato,
                          onChanged: (value) {
                            setState(() {
                              selectedTipoTrato.value = value!;
                            });
                          },
                        ),
                        const SizedBox(height: 16),
                        if (selectedTipoTrato.value == 'Outro')
                          Column(
                            children: [
                              SizedBox(height: 8),
                              Container(
                                alignment: Alignment.topLeft,
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                  'Especifique:',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[900],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 4),
                              MyTextFieldWrapper(
                                controller: _outroTratoController,
                                hintText: 'Especificar',
                                obscureText: false,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Informe o tipo do trato cultural.";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              const SizedBox(height: 16),
                            ],
                          ),
                      ],
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1, // Define a proporção do primeiro botão
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: MyButton(
                            isRed: true,
                            textButton: 'Descartar',
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ),
                      SizedBox(width: 8), // Adiciona espaço entre os botões
                      Expanded(
                        flex: 1, // Define a proporção do segundo botão
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: MyButton(
                            onTap: () async {
                              try {
                                setState(() {
                                  _isLoading = true; // Ativa o loading
                                });
                                // Exiba o diálogo de loading
                                // Crie o objeto BatchActivity com base nas informações do formulário e do lote
                                BatchActivity batchActivity =
                                    createBatchActivityObject();

                                // Determine se é uma edição ou criação
                                bool isEdicao = widget.activity != null;

                                // Adicione o objeto ao banco de dados usando o serviço
                                await batchService.addBatchActivity(
                                  batch: widget.batch!,
                                  batchActivity: batchActivity,
                                );
                                // Feche o formulário ou faça qualquer outra ação necessária
                                Navigator.pop(context);
                                // Mostrar snackbar com a mensagem apropriada
                                String snackBarMessage = isEdicao
                                    ? "A atividade foi editada com sucesso."
                                    : "A atividade foi criada com sucesso.";
                                showSnackBar(
                                  context: context,
                                  mensagem: snackBarMessage,
                                  isErro: false,
                                );
                              } catch (error) {
                                // Trate qualquer erro aqui, se necessário
                              } finally {
                                // Oculte o diálogo de loading
                                setState(() {
                                  _isLoading = false; // Desativa o loading
                                });
                              }
                            },
                            textButton: 'Salvar',
                          ),
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
    );
  }

  BatchActivity createBatchActivityObject() {
    if (formKey.currentState != null && formKey.currentState!.validate()) {
      String activityId = widget.activity?.id ??
          Uuid().v4(); // Use o ID da atividade existente ou gere um novo

      PreparoSolo preparoSolo;

      if (selectedAtividade.value == 'Preparo do solo') {
        preparoSolo = PreparoSolo(
          tipo: selectedPreparoSolo.value,
          tamanho: _tamanho1.text,
          usouCalcario: _selectedRadioValue,
          quantidadeCalcario: _quantidade1.text,
          tipoAdubo: selectedAdubacao.value == 'Não fez adubação'
              ? ''
              : selectedAdubacao.value == 'Orgânica'
                  ? selectedTipoAduboOrganico.value
                  : selectedTipoAduboQuimico.value,
          tipoAdubacao: selectedAdubacao.value,
          quantidade: _quantidade3.text,
          unidade: selectedTipoUnid1.text,
          produtoUtilizado:
              selectedAdubacao.value == 'Química' ? _produtoUtilizado.text : '',
          doseAplicada:
              selectedAdubacao.value == 'Química' ? _quantidade2.text : '0',
          naoFezAdubacao: selectedAdubacao.value == 'Não fez adubação',
        );
      } else {
        preparoSolo = PreparoSolo.empty();
      }

      Plantio plantio;

      if (selectedAtividade.value == 'Plantio') {
        plantio = Plantio(
          tipo: selectedPlantio.value,
          quantidade: int.parse(_quantidade1.text),
          largura: selectedPlantio.value == 'Semeadura direta'
              ? double.parse(_larguraPlantioController.text)
              : 0,
          comprimento: selectedPlantio.value == 'Semeadura direta'
              ? double.parse(_comprimentoPlantioController.text)
              : 0,
        );
      } else {
        plantio = Plantio.empty();
      }

      ManejoDoencas manejoDoencas;

      if (selectedAtividade.value == 'Manejo de doenças') {
        manejoDoencas = ManejoDoencas(
          nomeDoenca: _nomeDaDoenca.text,
          tipoControle: selectedTipoControleDoenca.value,
          tipoVetor: _selectedRadioValueUnid == true ? 'Químico' : 'Natural',
          produtoUtilizado:
              _selectedRadioValueUnid == true ? _produtoUtilizado.text : '',
          doseAplicada: _selectedRadioValueUnid == true
              ? double.parse(_quantidade1.text)
              : 0,
        );
      } else {
        manejoDoencas = ManejoDoencas.empty();
      }

      AdubacaoCobertura adubacaoCobertura;

      if (selectedAtividade.value == 'Adubação de cobertura') {
        adubacaoCobertura = AdubacaoCobertura(
          tipo: selectedAdubacao.value,
          tipoAdubo: selectedAdubacao.value == 'Não fez adubação'
              ? ''
              : selectedAdubacao.value == 'Orgânica'
                  ? selectedTipoAduboOrganico.value
                  : selectedTipoAduboQuimico.value,
          tipoAdubacao: selectedAdubacao.value,
          quantidade: selectedAdubacao.value == 'Química'
              ? _quantidade1.text
              : _quantidade2.text,
          unidade: selectedTipoUnid1.text,
          produtoUtilizado:
              selectedAdubacao.value == 'Química' ? _produtoUtilizado.text : '',
          doseAplicada:
              selectedAdubacao.value == 'Química' ? _quantidade2.text : '0',
          naoFezAdubacao: selectedAdubacao.value == 'Não fez adubação',
        );
      } else {
        adubacaoCobertura = AdubacaoCobertura.empty();
      }

      ManejoPragas manejoPragas;

      if (selectedTipoManejoPragas.value == 'Aplicação de agrotóxico') {
        manejoPragas = ManejoPragas(
          nomePraga: _nomeDaPraga.text,
          tipo: selectedTipoManejoPragas.value,
          nomeAgrotoxico: _nomeAgrotoxico.text,
          quantidadeRecomendadaAgrotoxico: _quantidade1.text,
          quantidadeAplicadaAgrotoxico: _quantidade2.text,
          unidadeRecomendadaAgrotoxico: selectedTipoUnid1.text,
          unidadeAplicadaAgrotoxico: selectedTipoUnid2.text,
        );
      } else if (selectedTipoManejoPragas.value == 'Controle natural') {
        manejoPragas = ManejoPragas(
          nomePraga: _nomeDaPraga.text,
          tipo: selectedTipoManejoPragas.value,
          tipoControle: selectedTipoControlePragas.value,
          nomeDefensivoNatural: _nomeOuTipo.text,
          quantidadeRecomendadaDefensivoNatural: _quantidade1.text,
          quantidadeAplicadaDefensivoNatural: _quantidade2.text,
          unidadeRecomendadaDefensivoNatural: selectedTipoUnid1.text,
          unidadeAplicadaDefensivoNatural: selectedTipoUnid2.text,
          tipoColeta: selectedTipoColeta.value,
          nomeInimigoNatural: _nomeInimigoNatural.text,
          formaUsoInimigoNatural: _formaUsoInimigoNatural.text,
        );
      } else {
        manejoPragas = ManejoPragas.empty();
      }

      Capina capina;

      if (selectedAtividade.value == 'Capina') {
        capina = Capina(
          tipo: selectedTipoCapina.value,
          nomeProduto: selectedTipoCapina.value == 'Química'
              ? _produtoUtilizado.text
              : '',
          quantidadeAplicada: selectedTipoCapina.value == 'Química'
              ? double.parse(_quantidade1.text)
              : 0,
          dimensao: _selectedRadioValueDim == true ? 'Parte' : 'Todo',
        );
      } else {
        capina = Capina.empty();
      }

      TratosCulturais tratosCulturais;

      if (selectedAtividade.value == 'Tratos culturais') {
        tratosCulturais = TratosCulturais(
          tipoControle: selectedTipoTrato.value,
          outroTipo: selectedTipoTrato.value == 'Outro'
              ? _outroTratoController.text
              : '',
        );
      } else {
        tratosCulturais = TratosCulturais.empty();
      }

      // Crie um objeto BatchActivity com base nas informações do formulário
      BatchActivity batchActivity = BatchActivity(
        id: activityId, // Substitua pelo ID desejado
        tipoAtividade: selectedAtividade.value,
        dataDaAtividade: selectedDate,
        custo: _custo.text,
        preparoSolo: preparoSolo,
        plantio: plantio,
        manejoDoencas: manejoDoencas,
        manejoPragas: manejoPragas,
        adubacaoCobertura: adubacaoCobertura,
        capina: capina,
        tratosCulturais: tratosCulturais,
      );

      return batchActivity;
    }

    // Adicione uma instrução throw ou return para lidar com o caso em que o corpo do método não atende às condições anteriores
    // Neste exemplo, estou lançando uma exceção, mas você pode retornar um valor padrão ou fazer outra coisa, dependendo da lógica do seu aplicativo.
    throw Exception(
        'Não foi possível criar BatchActivity devido a condições inválidas.');
  }
}
