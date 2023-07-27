import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../components/my_button.dart';
import '../../components/my_textfild.dart';
import '../../components/show_snackbar.dart';
import '../services/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // text editing controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmationController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();

  // variables
  List<String> statesList = [
    "Acre",
    "Alagoas",
    "Amapá",
    "Amazonas",
    "Bahia",
    "Ceará",
    "Distrito Federal",
    "Espírito Santo",
    "Goiás",
    "Maranhão",
    "Mato Grosso",
    "Mato Grosso do Sul",
    "Minas Gerais",
    "Pará",
    "Paraíba",
    "Paraná",
    "Pernambuco",
    "Piauí",
    "Rio de Janeiro",
    "Rio Grande do Norte",
    "Rio Grande do Sul",
    "Rondônia",
    "Roraima",
    "Santa Catarina",
    "São Paulo",
    "Sergipe",
    "Tocantins",
  ];

  Map<String, List<String>> citiesByState = {
    'São Paulo': [
      'São Paulo',
      'Campinas',
      // Adicione mais cidades de São Paulo conforme necessário
    ],
    'Rio de Janeiro': [
      'Rio de Janeiro',
      'Niterói',
      // Adicione mais cidades do Rio de Janeiro conforme necessário
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
  };

  String _selectedState = '';
  String _selectedCity = '';

  final _formKey = GlobalKey<FormState>();

  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 46),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // logo
                    Icon(
                      Icons.forest,
                      size: 80,
                      color: Color.fromARGB(255, 0, 90, 3),
                    ),
                    // welcome
                    Text(
                      'Cadastro',
                      style: TextStyle(
                        color: Color.fromARGB(255, 0, 90, 3),
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                const Text(
                  'Dados pessoais',
                  style: TextStyle(
                    color: Color.fromARGB(255, 0, 90, 3),
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 16),
                      MyTextField(
                        controller: _nameController,
                        hintText: 'Nome completo',
                        obscureText: false,
                      ),
                      const SizedBox(height: 8),
                      MyTextField(
                        controller: _emailController,
                        hintText: 'Digite seu e-mail',
                        obscureText: false,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "O valor de e-mail deve ser preenchido";
                          }
                          if (!value.contains("@") ||
                              !value.contains(".") ||
                              value.length < 4) {
                            return "O e-mail precisa ser válido";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 8),
                      MyTextField(
                        controller: _cpfController,
                        hintText: 'Digite seu CPF',
                        obscureText: true,
                        validator: (value) {
                          // ... (código de validação do CPF aqui)
                        },
                      ),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        value: _selectedState,
                        items: statesList.map((estado) {
                          return DropdownMenuItem<String>(
                            value: estado,
                            child: Text(estado),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedState = value!;
                            // Ao selecionar um estado, resetar a cidade selecionada
                            _selectedCity = '';
                          });
                        },
                        decoration: const InputDecoration(
                          labelText: 'Estado',
                        ),
                      ),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        value: _selectedCity,
                        items: _selectedState.isEmpty
                            ? null
                            : citiesByState[_selectedState]?.map((cidade) {
                                return DropdownMenuItem<String>(
                                  value: cidade,
                                  child: Text(cidade),
                                );
                              }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedCity = value!;
                          });
                        },
                        decoration: const InputDecoration(
                          labelText: 'Cidade',
                        ),
                      ),
                      const SizedBox(height: 16),
                      MyButton(
                        onTap: sendRegisterUser,
                        text_button: 'Entrar',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Register Method
  void sendRegisterUser() {
    String email = _emailController.text;
    String password = _passwordController.text;
    String name = _nameController.text;
    String cpf = _cpfController.text;
    String state = _selectedState;
    String city = _selectedCity;

    if (_formKey.currentState!.validate()) {
      _createUser(
          email: email,
          password: password,
          name: name,
          cpf: cpf,
          state: state,
          city: city);
    }
  }

  _createUser(
      {required String email,
      required String password,
      required String name,
      required String cpf,
      required String state,
      required String city}) {
    authService
        .registerUser(
      password: password,
      email: email,
      name: name,
      state: state,
      city: city,
    )
        .then((String? erro) {
      if (erro != null) {
        showSnackBar(context: context, mensagem: erro);
      }
    });
  }
}
