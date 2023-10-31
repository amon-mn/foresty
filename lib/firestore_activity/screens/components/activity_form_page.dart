import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:foresty/components/my_dropdown.dart';
import 'package:foresty/components/my_button.dart';
import '../../../components/my_textField.dart';
import '../../../firestore_batch/models/batch.dart';

class ActivityFormPage extends StatefulWidget {
  final ProductBatch? batch;

  ActivityFormPage({Key? key, this.batch}) : super(key: key);

  @override
  _ActivityFormPageState createState() => _ActivityFormPageState();
}

class _ActivityFormPageState extends State<ActivityFormPage> {
  final TextEditingController tamanho = TextEditingController();
  String labelTitle = 'Adicionar Atividade';
  final TextEditingController _batchNameController = TextEditingController();
  ValueNotifier<String> selectedFinalidade = ValueNotifier<String>('Selecione');

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final itemList1 = [
    'Selecione',
    'Preparo do solo',
    'Plantio',
    'Manejo de pragas',
    'Manejo de doenças',
    'Adubação de cobertura',
    'Capina',
    'Outros tratos culturais',
  ];

  @override
  void initState() {
    super.initState();

    if (widget.batch != null) {
      _batchNameController.text = widget.batch!.nomeLote ?? '';
      selectedFinalidade.value = widget.batch!.finalidade ?? 'Selecione';
    }
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
                'Finalidade',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[900],
                ),
              ),
            ),
            const SizedBox(height: 4),
            MyDropdownFormField(
              selectedValueNotifier: selectedFinalidade,
              itemsList: itemList1,
              onChanged: (value) {
                setState(() {
                  selectedFinalidade.value = value!;
                });
              },
            ),
            if (selectedFinalidade.value == 'Preparo do solo')
              Column(
                children: [
                  Text('Campos adicionais para Preparo do solo'),
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
                    hintText: 'Digite um número',
                    controller: tamanho,
                    obscureText: false,
                  ),
                ],
              ),
            if (selectedFinalidade.value == 'Plantio')
              Column(
                children: [
                  Text('Campos adicionais para Plantio'),
                  // Adicione os campos e widgets adicionais aqui
                ],
              ),
            if (selectedFinalidade.value == 'Manejo de pragas')
              Column(
                children: [
                  Text('Campos adicionais para Manejo de pragas'),
                  // Adicione os campos e widgets adicionais aqui
                ],
              ),
            if (selectedFinalidade.value == 'Manejo de doenças')
              Column(
                children: [
                  Text('Campos adicionais para Manejo de doenças'),
                  // Adicione os campos e widgets adicionais aqui
                ],
              ),
            if (selectedFinalidade.value == 'Adubação de cobertura')
              Column(
                children: [
                  Text('Campos adicionais para Adubação de cobertura'),
                  // Adicione os campos e widgets adicionais aqui
                ],
              ),
            if (selectedFinalidade.value == 'Capina')
              Column(
                children: [
                  Text('Campos adicionais para Capina'),
                  // Adicione os campos e widgets adicionais aqui
                ],
              ),
            if (selectedFinalidade.value == 'Outros tratos culturais')
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
