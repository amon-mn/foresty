import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Importe o pacote para usar o Firestore
import 'package:foresty/authentication/screens/welcome_page.dart';
import 'package:foresty/authentication/services/auth_service.dart';
import 'package:foresty/components/my_button.dart';
import 'package:foresty/components/my_dropdown.dart';
import 'package:foresty/home_page.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:validadores/Validador.dart';

import '../../components/my_textfild.dart';

class AddInfoGoogleUser extends StatefulWidget {
  final User user;

  AddInfoGoogleUser({required this.user});

  @override
  State<AddInfoGoogleUser> createState() => _AddInfoGoogleUserState();
}

class _AddInfoGoogleUserState extends State<AddInfoGoogleUser> {
  String _selectedState = 'Acre'; // Valor inicial padrão
  String _selectedCity = 'Rio Branco'; // Valor inicial padrão
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  List<String> statesList = [
    'Acre',
    'Alagoas',
    'Amapá',
    'Amazonas',
    'Bahia',
    'Ceará',
    'Distrito Federal',
    'Espírito Santo',
    'Goiás',
    'Maranhão',
    'Mato Grosso',
    'Mato Grosso do Sul',
    'Minas Gerais',
    'Pará',
    'Paraíba',
    'Paraná',
    'Pernambuco',
    'Piauí',
    'Rio de Janeiro',
    'Rio Grande do Norte',
    'Rio Grande do Sul',
    'Rondônia',
    'Roraima',
    'Santa Catarina',
    'São Paulo',
    'Sergipe',
    'Tocantins',
  ];

  Map<String, List<String>> citiesByState = {
    'Acre': [
      'Rio Branco',
      'Cruzeiro do Sul',
      // Add more cities of Acre if needed
    ],
    'Alagoas': [
      'Maceió',
      'Arapiraca',
      // Add more cities of Alagoas if needed
    ],
    'Amapá': [
      'Macapá',
      'Santana',
      // Add more cities of Amapá if needed
    ],
    'Amazonas': [
      'Alvarães',
      'Amaturá',
      'Anamã',
      'Anori',
      'Apuí',
      'Atalaia do Norte',
      'Autazes',
      'Barcelos',
      'Barreirinha',
      'Benjamin Constant',
      'Beruri',
      'Boa Vista do Ramos',
      'Boca do Acre',
      'Borba',
      'Caapiranga',
      'Carauari',
      'Careiro',
      'Careiro da Várzea',
      'Coari',
      'Codajás',
      'Eirunepé',
      'Guajará',
      'Humaitá',
      'Ipixuna',
      'Iranduba',
      'Itacoatiara',
      'Itamarati',
      'Itapiranga',
      'Japurá',
      'Juruá',
      'Jutaí',
      'Lábrea',
      'Manacapuru',
      'Manaquiri',
      'Manaus',
      'Manicoré',
      'Maués',
      'Nhamundá',
      'Nova Olinda do Norte',
      'Novo Airão',
      'Novo Aripuanã',
      'Parintins',
      'Presidente Figueiredo',
      'Rio Preto da Eva',
      'Santa Isabel do Rio Negro',
      'Santo Antônio do Içá',
      'São Gabriel da Cachoeira',
      'São Paulo de Olivença',
      'São Sebastião do Uatumã',
      'Silves',
      'Tabatinga',
      'Tefé',
      'Tonantins',
      'Uarini',
      'Urucará',
      'Urucurituba',
    ],
    'Bahia': [
      'Salvador',
      'Feira de Santana',
      // Add more cities of Bahia if needed
    ],
    'Ceará': [
      'Fortaleza',
      'Caucaia',
      // Add more cities of Ceará if needed
    ],
    'Distrito Federal': [
      'Brasília',
      'Planaltina',
      // Add more cities of Distrito Federal if needed
    ],
    'Espírito Santo': [
      'Vitória',
      'Vila Velha',
      // Add more cities of Espírito Santo if needed
    ],
    'Goiás': [
      'Goiânia',
      'Aparecida de Goiânia',
      // Add more cities of Goiás if needed
    ],
    'Maranhão': [
      'São Luís',
      'Imperatriz',
      // Add more cities of Maranhão if needed
    ],
    'Mato Grosso': [
      'Cuiabá',
      'Várzea Grande',
      // Add more cities of Mato Grosso if needed
    ],
    'Mato Grosso do Sul': [
      'Campo Grande',
      'Dourados',
      // Add more cities of Mato Grosso do Sul if needed
    ],
    'Minas Gerais': [
      'Belo Horizonte',
      'Uberlândia',
      // Add more cities of Minas Gerais if needed
    ],
    'Pará': [
      'Belém',
      'Ananindeua',
      // Add more cities of Pará if needed
    ],
    'Paraíba': [
      'João Pessoa',
      'Campina Grande',
      // Add more cities of Paraíba if needed
    ],
    'Paraná': [
      'Curitiba',
      'Londrina',
      // Add more cities of Paraná if needed
    ],
    'Pernambuco': [
      'Recife',
      'Jaboatão dos Guararapes',
      // Add more cities of Pernambuco if needed
    ],
    'Piauí': [
      'Teresina',
      'Parnaíba',
      // Add more cities of Piauí if needed
    ],
    'Rio de Janeiro': [
      'Rio de Janeiro',
      'Niterói',
      // Add more cities of Rio de Janeiro if needed
    ],
    'Rio Grande do Norte': [
      'Natal',
      'Mossoró',
      // Add more cities of Rio Grande do Norte if needed
    ],
    'Rio Grande do Sul': [
      'Porto Alegre',
      'Caxias do Sul',
      // Add more cities of Rio Grande do Sul if needed
    ],
    'Rondônia': [
      'Porto Velho',
      'Ji-Paraná',
      // Add more cities of Rondônia if needed
    ],
    'Roraima': [
      'Boa Vista',
      'Caracaraí',
      // Add more cities of Roraima if needed
    ],
    'Santa Catarina': [
      'Florianópolis',
      'Joinville',
      // Add more cities of Santa Catarina if needed
    ],
    'São Paulo': [
      'São Paulo',
      'Campinas',
      // Add more cities of São Paulo if needed
    ],
    'Sergipe': [
      'Aracaju',
      'Nossa Senhora do Socorro',
      // Add more cities of Sergipe if needed
    ],
    'Tocantins': [
      'Palmas',
      'Araguaína',
      // Add more cities of Tocantins if needed
    ],
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

  void handleLogout(BuildContext context) {
    AuthService().logout().then((String? erro) {
      if (erro == null) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const WelcomeScreen()),
          (route) => false,
        );
      } else {
        print("Erro durante o logout: $erro");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Informações de Cadastro'),
        leading: GestureDetector(
          onTap: () => handleLogout(context),
          child: Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: FractionallySizedBox(
          widthFactor: 0.9,
          child: Column(
            children: [
              MyTextField(
                prefixIcon: Icons.person,
                controller: _nameController,
                hintText: 'Nome completo',
                obscureText: false,
                validator: (value) {
                  if (value == null || value.isEmpty || value.length < 4) {
                    return "O nome deve ser preenchido";
                  } else {
                    null;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              MyTextField(
                inputFormatter: MaskTextInputFormatter(
                    mask: '###.###.###-##',
                    filter: {"#": RegExp(r'[0-9xX]')},
                    type: MaskAutoCompletionType.lazy),
                prefixIcon: Icons.person,
                controller: _cpfController,
                hintText: 'Digite seu CPF',
                obscureText: false,
                validator: (value) {
                  return Validador()
                      .add(Validar.CPF, msg: 'CPF Inválido')
                      .add(Validar.OBRIGATORIO,
                          msg: 'O CPF deve ser preenchido')
                      .minLength(11)
                      .maxLength(11)
                      .valido(value, clearNoNumber: true);
                },
              ),
              const SizedBox(height: 16),
              MyDropdownFormField(
                selectedValueNotifier: ValueNotifier<String>(_selectedState),
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
                selectedValueNotifier: ValueNotifier<String>(_selectedCity),
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
                textButton: 'Salvar',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _saveAdditionalInfo() async {
    try {
      // Referência ao documento do usuário no Firestore
      final userDocRef =
          FirebaseFirestore.instance.collection('users').doc(widget.user.uid);

      // Dados a serem salvos
      final data = {
        'name': _nameController.text,
        'cpf': _cpfController.text,
        'state': _selectedState,
        'city': _selectedCity,
        // Outras informações que você desejar salvar
      };

      // Salvar os dados no Firestore
      await userDocRef.set(data, SetOptions(merge: true)).then((_) {
        // Redirecionar o usuário para a página inicial
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomePage(user: widget.user)),
          (route) => false,
        );
      });
    } catch (error) {
      // Lidar com erros, como exibir uma mensagem de erro para o usuário
      print('Erro ao salvar informações adicionais: $error');
    }
  }
}
