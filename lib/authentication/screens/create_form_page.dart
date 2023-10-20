import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:foresty/components/forms_provider.dart';

import '../../components/my_button.dart';

class CreateFormPage extends StatefulWidget {
  @override
  _CreateFormPageState createState() => _CreateFormPageState();
}

class _CreateFormPageState extends State<CreateFormPage> {
  final TextEditingController formNameController = TextEditingController();

  List<String> questions = [
    'Qual é a sua cor favorita?',
    'Qual é o seu animal favorito?',
    'Qual é a sua comida favorita?',
    'Qual é a sua estação do ano favorita?',
    'Qual é o seu filme favorito?',
  ];

  List<String> answers = List.filled(5, ''); // Inicialize com respostas vazias

  void _saveForm(BuildContext context) {
    final formularioProvider =
        Provider.of<FormularioProvider>(context, listen: false);
    final formName = formNameController.text;

    if (formName.isNotEmpty) {
      formularioProvider.salvarFormulario(formName, questions, answers);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Formulário cadastrado com sucesso'),
      ));
      Navigator.of(context).pop(); // Volte para a página anterior
    }
  }

  @override
  void dispose() {
    formNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text('Cadastrar Produção'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nome do Produto',
              style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700]),
            ),
            TextField(
              controller: formNameController,
            ),
            SizedBox(height: 60.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(questions.length, (index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16.0),
                    Text(
                      questions[index],
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[700]),
                    ),
                    TextField(
                      onChanged: (value) {
                        answers[index] = value;
                      },
                      decoration: InputDecoration(),
                    ),
                    SizedBox(height: 16.0),
                  ],
                );
              }),
            ),
            MyButton(
              onTap: () => _saveForm(context),
              textButton: 'Salvar Formulário',
            ),
          ],
        ),
      ),
    );
  }
}
