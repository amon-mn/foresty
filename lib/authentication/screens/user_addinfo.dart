import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:foresty/components/my_button.dart';
import 'package:foresty/components/my_dropdown.dart';

class AddInfoGoogleUser extends StatefulWidget {
  final User user;

  AddInfoGoogleUser({required this.user});

  @override
  State<AddInfoGoogleUser> createState() => _AddInfoGoogleUserState();
}

class _AddInfoGoogleUserState extends State<AddInfoGoogleUser> {
  String _selectedState = 'Acre'; // Valor inicial padrão
  String _selectedCity = 'Rio Branco'; // Valor inicial padrão

  List<String> statesList = [
    'Acre',
    'Alagoas',
    // ... Lista de estados
  ];

  Map<String, List<String>> citiesByState = {
    'Acre': [
      'Rio Branco',
      'Cruzeiro do Sul', /* ... Lista de cidades */
    ],
    // ... Mapa de cidades por estado
  };

  @override
  void initState() {
    super.initState();

    // Define os valores iniciais para _selectedState e _selectedCity
    if (statesList.isNotEmpty) {
      _selectedState = statesList.first;
      if (citiesByState.containsKey(_selectedState) &&
          citiesByState[_selectedState]!.isNotEmpty) {
        _selectedCity = citiesByState[_selectedState]!.first;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Informações'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),
            MyDropdownFormField(
              selectedValue: _selectedState,
              itemsList: statesList,
              onChanged: (value) {
                setState(() {
                  _selectedState = value!;
                  _selectedCity = citiesByState[_selectedState]![0];
                });
              },
              labelText: 'Estado',
              prefixIcon: Icons.location_on,
            ),
            const SizedBox(height: 8),
            MyDropdownFormField(
              selectedValue: _selectedCity,
              itemsList: _selectedState.isEmpty ||
                      citiesByState[_selectedState] == null
                  ? []
                  : citiesByState[_selectedState]!,
              onChanged: (value) {
                setState(() {
                  _selectedCity = value!;
                });
              },
              labelText: 'Cidade',
              prefixIcon: Icons.location_on,
            ),
            const SizedBox(height: 16),
            MyButton(
              onTap: () {
                _saveAdditionalInfo();
              },
              text_button: 'Salvar',
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveAdditionalInfo() async {
    // Implemente aqui a lógica para salvar as informações adicionais do usuário
    // Use os valores _selectedState, _selectedCity e widget.user
    // Depois de salvar, você pode redirecionar o usuário para a página inicial
  }
}
