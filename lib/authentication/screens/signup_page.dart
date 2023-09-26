import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foresty/components/signup_form.dart';
import '../../components/my_button.dart';
import '../../components/show_snackbar.dart';
import '../../home_page.dart';
import '../services/auth_service.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  // Controladores de texto para o formulário de produtor
  final TextEditingController _producerNameController = TextEditingController();
  final TextEditingController _producerEmailController =
      TextEditingController();
  final TextEditingController _producerPasswordController =
      TextEditingController();
  final TextEditingController _producerConfirmationController =
      TextEditingController();
  final TextEditingController _producerCpfController = TextEditingController();
  final TextEditingController _producerCepController = TextEditingController();
  final TextEditingController _producerStreetController =
      TextEditingController();
  final TextEditingController _producerNeighborhoodController =
      TextEditingController();
  final TextEditingController _producerStateController =
      TextEditingController();
  final TextEditingController _producerCityController = TextEditingController();
  final TextEditingController _producerLocalityController =
      TextEditingController();
  final TextEditingController _producerPropertyNameController =
      TextEditingController();

  // Controladores de texto para o formulário de comerciante
  final TextEditingController _merchantNameController = TextEditingController();
  final TextEditingController _merchantEmailController =
      TextEditingController();
  final TextEditingController _merchantPasswordController =
      TextEditingController();
  final TextEditingController _merchantConfirmationController =
      TextEditingController();
  final TextEditingController _merchantCpfController = TextEditingController();
  final TextEditingController _merchantCnpjController = TextEditingController();
  final TextEditingController _merchantCepController = TextEditingController();
  final TextEditingController _merchantStreetController =
      TextEditingController();
  final TextEditingController _merchantNeighborhoodController =
      TextEditingController();
  final TextEditingController _merchantStateController =
      TextEditingController();
  final TextEditingController _merchantCityController = TextEditingController();
  final TextEditingController _merchantLocalityController =
      TextEditingController();
  final TextEditingController _merchantPropertyNameController =
      TextEditingController();

  final GlobalKey<FormState> _producerFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _merchantFormKey = GlobalKey<FormState>();

  AuthService authService = AuthService();
  bool _isLoading = false;
  bool isProducerScreen = true;
  bool isRememberMe = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: SizedBox(
              height: 300,
              child: Container(
                padding: EdgeInsets.only(top: 90, left: 20),
                color: Color.fromARGB(255, 0, 90, 3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: "Seja bem-vindo",
                        style: TextStyle(
                          fontSize: 22,
                          letterSpacing: 2,
                          color: Colors.white70,
                        ),
                        children: [
                          TextSpan(
                            text: isProducerScreen
                                ? " Produtor,"
                                : " Comerciante,",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white70,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Cadastre-se para Continuar",
                      style: TextStyle(
                        letterSpacing: 1,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          //Main Container for Signup Producer or Merchant
          Positioned(
            top: 180,
            child: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height - 250,
                padding: EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width - 40,
                margin: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 15,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isProducerScreen = true;
                            });
                          },
                          child: Column(
                            children: [
                              Text(
                                "PRODUTOR",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: isProducerScreen
                                      ? Color.fromARGB(255, 0, 90, 3)
                                      : Color.fromRGBO(167, 188, 199, 1),
                                ),
                              ),
                              if (!isProducerScreen)
                                Container(
                                  margin: EdgeInsets.only(top: 3),
                                  height: 2,
                                  width: 55,
                                  color: Colors.white30,
                                )
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isProducerScreen = false;
                            });
                          },
                          child: Column(
                            children: [
                              Text(
                                "COMERCIANTE",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: !isProducerScreen
                                      ? Color.fromARGB(255, 0, 90, 3)
                                      : Color.fromRGBO(167, 188, 199, 1),
                                ),
                              ),
                              if (isProducerScreen)
                                Container(
                                  margin: EdgeInsets.only(top: 3),
                                  height: 2,
                                  width: 55,
                                  color: Colors.white30,
                                )
                            ],
                          ),
                        )
                      ],
                    ),
                    if (isProducerScreen)
                      buildProducerSection()
                    else
                      buildMerchantSection(),
                    Expanded(
                      flex: 1,
                      child: FractionallySizedBox(
                        widthFactor: 0.86,
                        child: Container(
                          margin: EdgeInsets.only(
                              top: 40,
                              bottom: 16), // Margem inferior para o botão
                          child: MyButton(
                            onTap: () {
                              _signUserUp(isProducerScreen);
                            },
                            textButton: 'Cadastrar',
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: FractionallySizedBox(
                        widthFactor: 0.86,
                        child: Container(
                          margin: EdgeInsets.only(top: 8),
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text:
                                  "Ao clicar em 'Cadastrar' você concorda com nossos ",
                              style: TextStyle(
                                  color: Color.fromRGBO(120, 131, 137, 1)),
                              children: [
                                TextSpan(
                                  //recognizer: ,
                                  text: "Termos de Uso",
                                  style: TextStyle(
                                    color: Colors.green[800],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
          // Bottom buttons
        ],
      ),
    );
  }

  // Altere buildProducerSection para usar ListView.builder
  Expanded buildProducerSection() {
    return Expanded(
      flex: 3,
      child: SignupUserForm(
        nameController: _producerNameController,
        emailController: _producerEmailController,
        passwordController: _producerPasswordController,
        confirmationController: _producerConfirmationController,
        cpfController: _producerCpfController,
        propertyNameController: _producerPropertyNameController,
        stateController: _producerStateController,
        cepController:
            _producerCepController, // Adicione aqui o controlador que você está usando
        streetController:
            _producerStreetController, // Adicione aqui o controlador que você está usando
        neighborhoodController:
            _producerNeighborhoodController, // Adicione aqui o controlador que você está usando
        cityController: _producerCityController,
        localityController:
            _producerLocalityController, // Adicione aqui o controlador que você está usando
        formKey: _producerFormKey,
      ),
    );
  }

  Expanded buildMerchantSection() {
    return Expanded(
      flex: 3,
      child: SignupUserForm(
        nameController: _merchantNameController,
        emailController: _merchantEmailController,
        passwordController: _merchantPasswordController,
        confirmationController: _merchantConfirmationController,
        cpfController: _merchantCpfController,
        propertyNameController: _merchantPropertyNameController,
        cnpjController: _merchantCnpjController,
        cepController: _merchantCepController, // Adicionado
        streetController: _merchantStreetController, // Adicionado
        neighborhoodController: _merchantNeighborhoodController, // Adicionado
        stateController: _merchantStateController,
        cityController: _merchantCityController,
        localityController: _merchantLocalityController, // Adicionado
        formKey: _merchantFormKey,
      ),
    );
  }

  // Register Method
  void _signUserUp(bool isProducer) async {
    final TextEditingController nameController =
        isProducer ? _producerNameController : _merchantNameController;
    final TextEditingController emailController =
        isProducer ? _producerEmailController : _merchantEmailController;
    final TextEditingController passwordController =
        isProducer ? _producerPasswordController : _merchantPasswordController;
    final TextEditingController cpfController =
        isProducer ? _producerCpfController : _merchantCpfController;
    final TextEditingController propertyNameController = isProducer
        ? _producerPropertyNameController
        : _merchantPropertyNameController;
    final TextEditingController cnpjController = _merchantCnpjController;
    final TextEditingController cepController =
        isProducer ? _producerCepController : _merchantCepController;
    final TextEditingController streetController =
        isProducer ? _producerStreetController : _merchantStreetController;
    final TextEditingController neighborhoodController = isProducer
        ? _producerNeighborhoodController
        : _merchantNeighborhoodController;
    final TextEditingController stateController =
        isProducer ? _producerStateController : _merchantStateController;
    final TextEditingController cityController =
        isProducer ? _producerCityController : _merchantCityController;
    final TextEditingController localityController =
        isProducer ? _producerLocalityController : _merchantLocalityController;

    final GlobalKey<FormState> formKey =
        isProducer ? _producerFormKey : _merchantFormKey;

    if (formKey.currentState != null && formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Chame a função de registro aqui com os dados do formulário validado
      _createUser(
              email: emailController.text,
              password: passwordController.text,
              name: nameController.text,
              cpf: cpfController.text,
              state: stateController.text,
              city: cityController.text,
              propertyName: propertyNameController.text,
              cnpj: cnpjController.text,
              cep: cepController.text,
              street: streetController.text,
              neighborhood: neighborhoodController.text,
              locality: localityController.text,
              isProducer: isProducer)
          .then((String? error) {
        if (error != null) {
          showSnackBar(context: context, mensagem: error);
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
      formKey.currentState!.validate();
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

  @override
  void dispose() {
    // Dispose dos controladores quando a tela for descartada para evitar vazamentos de memória
    _producerNameController.dispose();
    _producerEmailController.dispose();
    _producerPasswordController.dispose();
    _producerConfirmationController.dispose();
    _producerCpfController.dispose();
    _producerPropertyNameController.dispose();
    _producerCepController.dispose();
    _producerCityController.dispose();
    _producerStateController.dispose();
    _producerStreetController.dispose();
    _producerNeighborhoodController.dispose();

    _merchantNameController.dispose();
    _merchantEmailController.dispose();
    _merchantPasswordController.dispose();
    _merchantConfirmationController.dispose();
    _merchantCpfController.dispose();
    _merchantPropertyNameController.dispose();
    _merchantCnpjController.dispose();
    _merchantCepController.dispose();
    _merchantCityController.dispose();
    _merchantStateController.dispose();
    _merchantStreetController.dispose();
    _merchantNeighborhoodController.dispose();

    super.dispose();
  }
}
