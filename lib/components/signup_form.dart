import 'package:flutter/material.dart';
import 'package:foresty/authentication/services/via_cep_service.dart';
import 'package:foresty/components/show_snackbar.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:validadores/Validador.dart';
import 'my_textfield.dart';

class SignupUserForm extends StatefulWidget {
  final TextEditingController nameController,
      emailController,
      passwordController,
      confirmationController,
      cpfController,
      propertyNameController,
      cepController,
      streetController,
      neighborhoodController,
      stateController,
      cityController,
      localityController;
  final TextEditingController? cnpjController;
  final GlobalKey<FormState> formKey;

  SignupUserForm({
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmationController,
    required this.cpfController,
    required this.propertyNameController,
    this.cnpjController,
    required this.cepController,
    required this.streetController,
    required this.neighborhoodController,
    required this.cityController,
    required this.stateController,
    required this.localityController,
    required this.formKey,
  });

  @override
  State<SignupUserForm> createState() => _SignupUserFormState();
}

class _SignupUserFormState extends State<SignupUserForm> {
  bool _obscurePassword = true;
  bool _obscureConfirmation = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: ListView.builder(
        itemCount: 14, // Número de campos de entrada
        itemBuilder: (BuildContext context, int index) {
          print('Building item at index $index'); // Adicione esta linha
          return FractionallySizedBox(
            widthFactor: 0.85,
            child: Column(
              children: [
                const SizedBox(height: 8),
                if (index == 0)
                  MyTextFieldWrapper(
                    prefixIcon: Icons.person,
                    controller: widget.nameController,
                    hintText: 'Nome Completo',
                    obscureText: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "O nome deve ser preenchido";
                      }
                      if (value.length < 4) {
                        return "O nome deve possuir pelo menos 4 letras";
                      }
                      return null;
                    },
                  ),
                if (index == 1)
                  MyTextFieldWrapper(
                    inputFormatter: MaskTextInputFormatter(
                      mask: '###.###.###-##',
                      filter: {"#": RegExp(r'[0-9xX]')},
                      type: MaskAutoCompletionType.lazy,
                    ),
                    prefixIcon: Icons.person,
                    controller: widget.cpfController,
                    hintText: 'CPF',
                    obscureText: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "O CPF deve ser preenchido";
                      } else {
                        return Validador()
                            .add(Validar.CPF, msg: 'CPF Inválido')
                            .minLength(11)
                            .maxLength(11)
                            .valido(value, clearNoNumber: true);
                      }
                    },
                  ),
                if (index == 2)
                  MyTextFieldWrapper(
                    prefixIcon: Icons.email,
                    controller: widget.emailController,
                    hintText: 'E-mail',
                    obscureText: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "O e-mail deve ser preenchido";
                      } else {
                        return Validador()
                            .add(Validar.EMAIL,
                                msg: 'O e-mail precisa ser válido')
                            .valido(value);
                      }
                    },
                  ),
                if (index == 3)
                  MyTextFieldWrapper(
                    prefixIcon: Icons.lock,
                    suffixIcon: _obscurePassword
                        ? Icons.visibility
                        : Icons.visibility_off,
                    onSuffixIconPressed: togglePasswordVisibility,
                    controller: widget.passwordController,
                    hintText: 'Defina sua Senha',
                    obscureText: _obscurePassword,
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
                if (index == 4)
                  MyTextFieldWrapper(
                    prefixIcon: Icons.lock,
                    suffixIcon: _obscureConfirmation
                        ? Icons.visibility
                        : Icons.visibility_off,
                    onSuffixIconPressed: togglePasswordVisibility,
                    controller: widget.confirmationController,
                    hintText: 'Confirme sua Senha',
                    obscureText: _obscureConfirmation,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "A confirmação de senha deve ser preenchida";
                      }
                      if (value != widget.passwordController.text) {
                        return "As senhas não coincidem";
                      }
                      return null; // Retorna null se a validação for bem-sucedida
                    },
                  ),
                if (index == 5)
                  MyTextFieldWrapper(
                    prefixIcon: Icons.location_on,
                    controller: widget.stateController,
                    hintText: 'Estado',
                    obscureText: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "O Estado deve ser preenchido";
                      }
                      if (value.length < 5) {
                        return "O Estado está incorreto";
                      }
                      return null;
                    },
                  ),
                if (index == 6)
                  MyTextFieldWrapper(
                    prefixIcon: Icons.location_on,
                    controller: widget.cityController,
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
                if (index == 7) const SizedBox(height: 16),
                if (index == 8)
                  MyTextFieldWrapper(
                    prefixIcon: Icons.business,
                    controller: widget.propertyNameController,
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
                if (widget.cnpjController != null && index == 9)
                  MyTextFieldWrapper(
                    inputFormatter: MaskTextInputFormatter(
                      mask: '##.###.###/####-##',
                      filter: {"#": RegExp(r'[0-9]')},
                      type: MaskAutoCompletionType.lazy,
                    ),
                    prefixIcon: Icons.business,
                    controller: widget.cnpjController!,
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
                if (index == 10)
                  MyTextFieldWrapper(
                    inputFormatter: MaskTextInputFormatter(
                      mask: '#####-###',
                      filter: {"#": RegExp(r'[0-9]')},
                      type: MaskAutoCompletionType.lazy,
                    ),
                    prefixIcon: Icons.pin_drop,
                    suffixIcon: Icons.search,
                    onSuffixIconPressed: () => _autoFillAddress(context),
                    controller: widget.cepController,
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
                if (index == 11)
                  MyTextFieldWrapper(
                    prefixIcon: Icons.location_on,
                    controller: widget.streetController,
                    hintText: 'Logradouro',
                    obscureText: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "O logradouro deve ser preenchido";
                      }
                      return null;
                    },
                  ),
                if (index == 12)
                  MyTextFieldWrapper(
                    prefixIcon: Icons.location_city,
                    controller: widget.neighborhoodController,
                    hintText: 'Bairro',
                    obscureText: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "O bairro deve ser preenchido";
                      }
                      return null;
                    },
                  ),
                if (index == 13)
                  MyTextFieldWrapper(
                    prefixIcon: Icons.location_city,
                    controller: widget.localityController,
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
                if (index == 14) const SizedBox(height: 16),
              ],
            ),
          );
        },
      ),
    );
  }

  void togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
      _obscureConfirmation = !_obscureConfirmation;
    });
  }

  Future<void> _autoFillAddress(BuildContext context) async {
    final cep = widget.cepController.text.replaceAll('-', '');

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
                      widget.streetController.text = result.logradouro;
                      widget.neighborhoodController.text = result.bairro;
                      widget.localityController.text = result.localidade;
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
