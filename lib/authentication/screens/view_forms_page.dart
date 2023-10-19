import 'package:foresty/authentication/screens/forms_datails_page.dart';
import 'package:flutter/material.dart';
import 'package:foresty/components/forms.dart';
import 'package:provider/provider.dart';
import 'package:foresty/components/forms_provider.dart';

class ViewFormsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final formularioProvider = Provider.of<FormularioProvider>(context);
    final formularios = formularioProvider.formularios;

    return Scaffold(
      appBar: AppBar(
        title: Text('Visualizar Formulários'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(formularios.length, (formIndex) {
              final formulario = formularios[formIndex];
              return InkWell(
                onTap: () {
                  _showFormDetails(context, formulario);
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Formulário: ${formulario.formName}',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16.0),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  void _showFormDetails(BuildContext context, Formulario formulario) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => FormDetailsPage(formulario: formulario),
      ),
    );
  }
}
