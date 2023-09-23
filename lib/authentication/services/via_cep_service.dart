import 'dart:convert';
import 'package:foresty/models/result_cep.dart';
import 'package:http/http.dart' as http;

class ViaCepService {
  static Future<ResultCep> fetchCep(String cep) async {
    final response =
        await http.get(Uri.parse('https://viacep.com.br/ws/$cep/json/'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      return ResultCep.fromJson(responseData);
    } else {
      throw Exception('Requisição inválida!');
    }
  }
}
