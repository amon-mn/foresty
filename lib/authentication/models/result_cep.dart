import 'dart:convert';

class ResultCep {
  String cep;
  String logradouro;
  String complemento;
  String bairro;
  String localidade;
  String uf;
  String unidade;
  String ibge;
  String gia;

  ResultCep({
    required this.cep,
    required this.logradouro,
    required this.complemento,
    required this.bairro,
    required this.localidade,
    required this.uf,
    required this.unidade,
    required this.ibge,
    required this.gia,
  });

  factory ResultCep.fromRawJson(String str) =>
      ResultCep.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ResultCep.fromJson(Map<String, dynamic> json) => ResultCep(
        cep: json["cep"] ??
            "", // Use uma string vazia como valor padrão se for nulo
        logradouro: json["logradouro"] ?? "",
        complemento: json["complemento"] ?? "",
        bairro: json["bairro"] ?? "",
        localidade: json["localidade"] ?? "",
        uf: json["uf"] ?? "",
        unidade: json["unidade"] ?? "",
        ibge: json["ibge"] ?? "",
        gia: json["gia"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "cep": cep,
        "logradouro": logradouro,
        "complemento": complemento,
        "bairro": bairro,
        "localidade": localidade,
        "uf": uf,
        "unidade": unidade,
        "ibge": ibge,
        "gia": gia,
      };
}
