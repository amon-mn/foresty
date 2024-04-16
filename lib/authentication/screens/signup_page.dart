import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foresty/authentication/screens/components/signup_form.dart';
import '../../components/my_button.dart';
import '../../components/show_snackbar.dart';
import '../../home_page.dart';
import '../services/auth_service.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart' show rootBundle;

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
                height: MediaQuery.of(context).size.height - 200,
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
                    FractionallySizedBox(
                      widthFactor: 0.86,
                      child: Container(
                        margin: EdgeInsets.only(
                          top: 20,
                          bottom: 10, // Reduzido o espaço inferior para o botão
                        ),
                        child: MyButton(
                          onTap: () {
                            _signUserUp(isProducerScreen);
                          },
                          textButton: 'Cadastrar',
                          isRed: false, // Altere conforme necessário
                        ),
                      ),
                    ),
                    FractionallySizedBox(
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
                                // recognizer: ,
                                text: "Termos de Uso",
                                style: TextStyle(
                                  color: Colors.green[800],
                                  decoration: TextDecoration
                                      .underline, // Adicionando sublinhado
                                ),
                                // Adicionando ação ao TextSpan
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    _showTermsDialog(
                                        context); // Função para mostrar os termos em um dialog
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
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

  Future<String> _loadTermsText() async {
    return await rootBundle
        .loadString('lib/authentication/screens/components/termos.txt');
  }

  void _showTermsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Termos de Uso"),
          content: SingleChildScrollView(
            child: Text(
              "Termos de Uso do Aplicativo RASTECH\n\n"
              "Bem-vindo ao RASTECH! Estes Termos de Uso regem o uso do nosso aplicativo móvel e dos serviços relacionados. Ao baixar, instalar ou usar nosso aplicativo, você concorda em ficar vinculado a estes Termos de Uso. Por favor, leia-os com atenção.\n\n"
              "1. Aceitação dos Termos de Uso\n"
              "Ao acessar ou usar nosso aplicativo, você concorda em cumprir estes Termos de Uso. Se você não concordar com algum dos termos aqui apresentados, não poderá usar nosso aplicativo.\n\n"
              "2. Uso do Aplicativo\n"
              "Nosso aplicativo é fornecido para seu uso pessoal e comercial. Você concorda em usar o aplicativo somente para fins legais e de acordo com estes Termos de Uso. Ao gerar um QR Code dentro do aplicativo, você concorda que as informações fornecidas, como nome, endereço, CPF/CNPJ, datas, nome da propriedade e nome do produto, podem ser compartilhadas por meio do link gerado pelo QR Code.\n\n"
              "3. Propriedade Intelectual\n"
              "O conteúdo do aplicativo, incluindo textos, gráficos, logotipos, imagens, vídeos, áudios e software, é de nossa propriedade ou licenciado para nós e está protegido por leis de propriedade intelectual. Você concorda em não reproduzir, distribuir, modificar ou criar trabalhos derivados baseados no conteúdo do aplicativo.\n\n"
              "4. Privacidade\n"
              "Respeitamos sua privacidade e estamos empenhados em proteger suas informações pessoais. Nossa Política de Privacidade explica como coletamos, usamos e divulgamos suas informações quando você usa nosso aplicativo. Ao usar nosso aplicativo, você concorda com nossa Política de Privacidade.\n\n"
              "5. Limitação de Responsabilidade\n"
              "Em nenhuma circunstância seremos responsáveis por quaisquer danos diretos, indiretos, incidentais, especiais ou consequenciais decorrentes do uso ou incapacidade de usar nosso aplicativo.\n\n"
              "6. Modificações nos Termos de Uso\n"
              "Reservamos o direito de modificar estes Termos de Uso a qualquer momento, mediante aviso prévio. É sua responsabilidade revisar periodicamente os Termos de Uso para estar ciente de quaisquer alterações. O uso contínuo do aplicativo após as alterações significará sua aceitação dos novos termos.\n\n"
              "7. Lei Aplicável\n"
              "Estes Termos de Uso serão regidos e interpretados de acordo com as leis do Brasil, com exclusão de seus princípios de conflitos de leis. Você concorda irrevogavelmente que os tribunais competentes em Manaus, estado do Amazonas, terão jurisdição exclusiva sobre qualquer litígio decorrente ou relacionado a estes Termos de Uso.\n\n"
              "Se você tiver alguma dúvida sobre estes Termos de Uso, entre em contato conosco em rastech.oficial@gmail.com",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Fechar"),
            ),
          ],
        );
      },
    );
  }
}
