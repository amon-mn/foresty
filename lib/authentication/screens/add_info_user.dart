import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foresty/authentication/screens/welcome_page.dart';
import 'package:foresty/authentication/services/auth_service.dart';
import 'package:foresty/authentication/services/via_cep_service.dart';
import 'package:foresty/components/my_button.dart';
import 'package:foresty/components/my_dropdown.dart';
import 'package:foresty/components/show_snackbar.dart';
import 'package:foresty/home_page.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:validadores/Validador.dart';

import '../../components/my_textfield.dart';

class AddInfoGoogleUser extends StatefulWidget {
  final User user;

  AddInfoGoogleUser({required this.user});

  @override
  State<AddInfoGoogleUser> createState() => _AddInfoGoogleUserState();
}

class _AddInfoGoogleUserState extends State<AddInfoGoogleUser> {
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _propertyNameController = TextEditingController();
  final TextEditingController _cepController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _neighborhoodController = TextEditingController();
  final TextEditingController _localityController = TextEditingController();
  final TextEditingController _cnpjController = TextEditingController();

  final ValueNotifier<String> _selectedUserType = ValueNotifier('Selecione');
  final GlobalKey<FormState> infoKey = GlobalKey();
  @override
  void initState() {
    super.initState();
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
        title: Text('Complete seu cadastro'),
        leading: GestureDetector(
          onTap: () => handleLogout(context),
          child: Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Form(
          key: infoKey,
          child: Center(
            child: FractionallySizedBox(
              widthFactor: 0.9,
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  MyDropdownFormField(
                    selectedValueNotifier: _selectedUserType,
                    itemsList: const ['Selecione', 'Produtor', 'Comerciante'],
                    onChanged: (newValue) {
                      setState(() {
                        _selectedUserType.value = newValue!;
                      });
                    },
                    labelText: 'Tipo de Usuário',
                    prefixIcon: Icons.person,
                  ),
                  const SizedBox(height: 16),
                  // Mostrar ou ocultar campos com base no tipo de usuário
                  if (_selectedUserType.value != 'Selecione')
                    _selectedUserType.value == 'Produtor'
                        ? _buildProducerForm()
                        : _buildMerchantForm(),
                  const SizedBox(height: 16),
                  MyButton(
                    onTap: () {
                      _saveAdditionalInfo();
                    },
                    textButton: 'Salvar',
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProducerForm() {
    return Column(
      children: [
        const SizedBox(height: 16),
        MyTextFieldWrapper(
          prefixIcon: Icons.person,
          controller: _nameController,
          hintText: 'Nome completo',
          obscureText: false,
          validator: (value) {
            if (value == null || value.isEmpty || value.length < 4) {
              return "O nome deve ser preenchido";
            } else {
              return null;
            }
          },
        ),
        const SizedBox(height: 8),
        MyTextFieldWrapper(
          inputFormatter: MaskTextInputFormatter(
            mask: '###.###.###-##',
            filter: {"#": RegExp(r'[0-9xX]')},
            type: MaskAutoCompletionType.lazy,
          ),
          prefixIcon: Icons.person,
          controller: _cpfController,
          hintText: 'Digite seu CPF',
          obscureText: false,
          validator: (value) {
            return Validador()
                .add(Validar.CPF, msg: 'CPF Inválido')
                .add(Validar.OBRIGATORIO, msg: 'O CPF deve ser preenchido')
                .minLength(11)
                .maxLength(11)
                .valido(value, clearNoNumber: true);
          },
        ),
        const SizedBox(height: 8),
        MyTextFieldWrapper(
          prefixIcon: Icons.location_on,
          controller: _stateController,
          hintText: 'Estado',
          obscureText: false,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "O Estado deve ser preenchido";
            }
            if (value.length < 2) {
              return "Informe o nome do estado ou sua sigla";
            }
            return null;
          },
        ),
        const SizedBox(height: 8),
        MyTextFieldWrapper(
          prefixIcon: Icons.location_on,
          controller: _cityController,
          hintText: 'Cidade',
          obscureText: false,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "A Cidade deve ser preenchida";
            }
            if (value.length < 5) {
              return "A Cidade está incorreta";
            }
            return null;
          },
        ),
        const SizedBox(height: 24),
        MyTextFieldWrapper(
          prefixIcon: Icons.business,
          controller: _propertyNameController,
          hintText: 'Nome da Propriedade',
          obscureText: false,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "O nome da propriedade deve ser preenchido";
            } else {
              return null;
            }
          },
        ),
        const SizedBox(height: 8),
        MyTextFieldWrapper(
          inputFormatter: MaskTextInputFormatter(
            mask: '#####-###',
            filter: {"#": RegExp(r'[0-9]')},
            type: MaskAutoCompletionType.lazy,
          ),
          prefixIcon: Icons.pin_drop,
          suffixIcon: Icons.search,
          onSuffixIconPressed: () => _autoFillAddress(context),
          controller: _cepController,
          hintText: 'CEP',
          obscureText: false,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "O CEP deve ser preenchido";
            }
            if (value.length != 9) {
              return "O CEP deve ter exatamente 9 dígitos";
            }
            return null;
          },
        ),
        const SizedBox(height: 8),
        MyTextFieldWrapper(
          prefixIcon: Icons.location_on,
          controller: _streetController,
          hintText: 'Logradouro',
          obscureText: false,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "O logradouro deve ser preenchido";
            }
            return null;
          },
        ),
        const SizedBox(height: 8),
        MyTextFieldWrapper(
          prefixIcon: Icons.location_city,
          controller: _neighborhoodController,
          hintText: 'Bairro',
          obscureText: false,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "O bairro deve ser preenchido";
            }
            return null;
          },
        ),
        const SizedBox(height: 8),
        MyTextFieldWrapper(
          prefixIcon: Icons.location_city,
          controller: _localityController,
          hintText: 'Localidade',
          obscureText: false,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "A localidade deve ser preenchida";
            }
            // Outras validações específicas da localidade, se necessário.
            return null;
          },
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildMerchantForm() {
    final List<Widget> producerFields = [_buildProducerForm()];

    return Column(
      children: [
        const SizedBox(height: 16),
        ...producerFields,
        MyTextFieldWrapper(
          inputFormatter: MaskTextInputFormatter(
            mask: '##.###.###/####-##',
            filter: {"#": RegExp(r'[0-9]')},
            type: MaskAutoCompletionType.lazy,
          ),
          prefixIcon: Icons.business,
          controller: _cnpjController,
          hintText: 'CNPJ',
          obscureText: false,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "O CNPJ deve ser preenchido";
            } else {
              return Validador()
                  .add(Validar.CNPJ, msg: 'CNPJ Inválido')
                  .minLength(14)
                  .maxLength(14)
                  .valido(value, clearNoNumber: true);
            }
          },
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Future<void> _saveAdditionalInfo() async {
    if (infoKey.currentState != null && infoKey.currentState!.validate()) {
      try {
        // Referência ao documento do usuário no Firestore
        final userDocRef =
            FirebaseFirestore.instance.collection('users').doc(widget.user.uid);

        // Dados a serem salvos
        final data = {
          'name': _nameController.text,
          'cpf': _cpfController.text,
          'state': _stateController.text,
          'city': _cityController.text,
          'userType': _selectedUserType.value,
          if (_selectedUserType.value == 'Comerciante')
            'cnpj': _cnpjController.text,
          'cep': _cepController.text,
          'locality': _localityController.text,
          'neighborhood': _neighborhoodController.text,
          'propertyName': _propertyNameController.text,
          'street': _streetController.text,
        };

        // Salvar os dados no Firestore
        await userDocRef.set(data, SetOptions(merge: true));

        // Redirecionar o usuário para a página inicial
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomePage(user: widget.user)),
          (route) => false,
        );
      } catch (error) {
        // Lidar com erros, como exibir uma mensagem de erro para o usuário
        print('Erro ao salvar informações adicionais: $error');
        // Exibir uma mensagem de erro para o usuário
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Erro ao salvar informações adicionais. Por favor, tente novamente.'),
          ),
        );
      }
    }
  }

  Future<void> _autoFillAddress(BuildContext context) async {
    final cep = _cepController.text.replaceAll('-', '');

    try {
      await ViaCepService.fetchCep(cep).then(
        (result) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Preenchimento Automático'),
                content: Text('Deseja preencher automaticamente o endereço?'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Fechar o dialog
                    },
                    child: Text('Cancelar'),
                  ),
                  TextButton(
                    onPressed: () {
                      // Preencher automaticamente os campos
                      _streetController.text = result.logradouro;
                      _neighborhoodController.text = result.bairro;
                      _localityController.text = result.localidade;
                      Navigator.of(context).pop(); // Fechar o dialog
                    },
                    child: Text('Sim'),
                  ),
                ],
              );
            },
          );
        },
      );
    } catch (e) {
      print('Erro ao consultar o ViaCep: $e');
      showSnackBar(
        context: context,
        mensagem: 'Erro ao consultar o ViaCep: $e',
        isErro: true,
      );
    }
  }
}
