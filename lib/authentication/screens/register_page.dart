import 'package:flutter/material.dart';
import 'package:validadores/Validador.dart';
import 'package:foresty/components/my_dropdown.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../../components/my_button.dart';
import '../../components/my_textfield.dart';
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
  bool isProducer = true;

  // variables
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

  String _selectedState = '';
  String _selectedCity = '';
  AuthService authService = AuthService();
  bool _isLoading = false;

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

  // Global Keys
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.grey[300],
          body: SingleChildScrollView(
            reverse: true,
            child: SafeArea(
              child: Center(
                child: Column(
                  children: [
                    const SizedBox(height: 46),
                    const Text(
                      'Dados pessoais',
                      style: TextStyle(
                        color: Color.fromARGB(255, 0, 90, 3),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    FractionallySizedBox(
                      widthFactor: 0.85,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            const SizedBox(height: 16),
                            MyTextFieldWrapper(
                              prefixIcon: Icons.person,
                              controller: _nameController,
                              hintText: 'Nome completo',
                              obscureText: false,
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    value.length < 4) {
                                  return "O nome deve ser preenchido";
                                } else {
                                  null;
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 8),
                            MyTextFieldWrapper(
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
                            const SizedBox(height: 8),
                            MyTextFieldWrapper(
                              prefixIcon: Icons.email,
                              controller: _emailController,
                              hintText: 'Digite seu e-mail',
                              obscureText: false,
                              validator: (value) {
                                return Validador()
                                    .add(Validar.EMAIL,
                                        msg: 'O e-mail precisa ser válido')
                                    .add(Validar.OBRIGATORIO,
                                        msg: 'O e-mail deve ser preenchido')
                                    .valido(value);
                              },
                            ),
                            const SizedBox(height: 8),
                            MyTextFieldWrapper(
                              prefixIcon: Icons.lock,
                              controller: _passwordController,
                              hintText: 'Defina sua senha',
                              obscureText: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "A senha deve ser preenchida";
                                }
                                if (value.length < 6) {
                                  return "A senha deve conter pelo menos 6 caracteres";
                                }
                                return null; // Retorna null se a validação for bem-sucedida
                              },
                            ),
                            const SizedBox(height: 8),
                            MyTextFieldWrapper(
                              prefixIcon: Icons.lock,
                              controller: _confirmationController,
                              hintText: 'Confirme sua senha',
                              obscureText: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "A confirmação de senha deve ser preenchida";
                                }
                                if (value != _passwordController.text) {
                                  return "As senhas não coincidem";
                                }
                                return null; // Retorna null se a validação for bem-sucedida
                              },
                            ),
                            const SizedBox(height: 8),
                            MyDropdownFormField(
                              hint: "Escolha seu Estado",
                              selectedValueNotifier:
                                  ValueNotifier<String>(_selectedState),
                              itemsList: statesList,
                              onChanged: (value) {
                                setState(() {
                                  _selectedState = value!;
                                  _selectedCity =
                                      citiesByState[_selectedState]![0];
                                });
                              },
                              labelText: 'Estado',
                              prefixIcon: Icons.location_on,
                            ),
                            const SizedBox(height: 8),
                            MyDropdownFormField(
                              selectedValueNotifier:
                                  ValueNotifier<String>(_selectedCity),
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
                              onTap: () {},
                              textButton: 'Cadastrar',
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        if (_isLoading)
          Container(
            color: Colors.black.withOpacity(0.5),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
      ],
    );
  }
/*
  // Register Method
  void signUserUp() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      _createUser(
        email: _emailController.text,
        password: _passwordController.text,
        name: _nameController.text,
        cpf: _cpfController.text,
        state: _selectedState,
        city: _selectedCity,
      ).then((String? erro) {
        if (erro != null) {
          showSnackBar(context: context, mensagem: erro);
        } else {
          showSnackBar(
            context: context,
            mensagem: 'Cadastro realizado com sucesso!',
            isErro: false,
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  HomePage(user: FirebaseAuth.instance.currentUser!),
            ),
          );
        }
      });
    } else {
      _formKey.currentState!.validate();
    }
  }

  Future<String?> _createUser({
    required String email,
    required String password,
    required String name,
    required String cpf,
    required String state,
    required String city,
    required String propertyName,
    String? cnpj,
    required String cep,
    required String street,
    required String neighborhood,
    required String locality,
    required bool isProducer,
  }) async {
    try {
      return await authService.registerUser(
        password: password,
        email: email,
        name: name,
        cpf: cpf,
        state: state,
        city: city,
        propertyName: propertyName,
        cnpj: cnpj,
        cep: cep,
        street: street,
        neighborhood: neighborhood,
        locality: locality,
        isProducer: isProducer,
      );
    } catch (error) {
      return error.toString();
    }
  }
  */
}
