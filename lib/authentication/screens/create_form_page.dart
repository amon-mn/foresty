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
        content: Text('Lote cadastrado com sucesso'),
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
        title: Text('Novo Lote'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Container(
          height: MediaQuery.of(context).size.height - 40,
          padding: EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width - 40,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nome do Lote',
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700]),
              ),
              TextField(
                controller: formNameController,
              ),
              SizedBox(height: 32.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(questions.length, (index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8.0),
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
                      SizedBox(height: 8.0),
                    ],
                  );
                }),
              ),
              SizedBox(height: 32.0),
              MyButton(
                onTap: () => _saveForm(context),
                textButton: 'Salvar Formulário',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
