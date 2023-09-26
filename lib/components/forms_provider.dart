import 'package:foresty/components/forms.dart';
import 'package:flutter/foundation.dart';

class FormularioProvider with ChangeNotifier {
  List<Formulario> formularios = [];

  void salvarFormulario(
      String formName, List<String> questions, List<String> userAnswers) {
    final formulario = Formulario(
      formName: formName,
      questions: questions,
      userAnswers: userAnswers,
    );
    formularios.add(formulario);
    notifyListeners();
  }
}
