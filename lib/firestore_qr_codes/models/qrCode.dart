class BatchQrCode {
  String id;
  String tipoDeVenda;
  String pesoDaVenda;
  String unidadeDeMedida;
  bool isOrganico;
  Etiqueta? etiqueta;

  BatchQrCode({
    required this.id,
    required this.tipoDeVenda,
    required this.pesoDaVenda,
    required this.unidadeDeMedida,
    this.isOrganico = false,
    required this.etiqueta,
  });

  BatchQrCode.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        tipoDeVenda = map['tipoDeVenda'],
        pesoDaVenda = map['pesoDaVenda'].toString(),
        unidadeDeMedida = map['unidadeDeMedida'],
        isOrganico = map['isOrganico'] ?? false,
        etiqueta =
            map['etiqueta'] != null ? Etiqueta.fromMap(map['etiqueta']) : null;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'tipoDeVenda': tipoDeVenda,
      'pesoDaVenda': pesoDaVenda,
      'unidadeDeMedida': unidadeDeMedida,
      'isOrganico': isOrganico,
      'etiqueta': etiqueta?.toMap(),
    };
  }
}

// Subclasses for each activity type

class Etiqueta {
  String peso;
  String unidade;
  String codLote;
  String dataExpedicao;
  String endereco;
  String cpfCnpj;
  String dataQrCode;
  String nomeDoProduto;
  String valor;

  Etiqueta({
    required this.peso,
    required this.unidade,
    required this.codLote,
    required this.dataExpedicao,
    required this.endereco,
    required this.cpfCnpj,
    required this.dataQrCode,
    required this.valor,
    required this.nomeDoProduto,
  });

  // Método construtor vazio
  Etiqueta.empty()
      : peso = '',
        unidade = '',
        codLote = '',
        dataExpedicao = '',
        endereco = '',
        cpfCnpj = '',
        dataQrCode = '',
        valor = '',
        nomeDoProduto = '';

  // Método construtor a partir de um mapa
  Etiqueta.fromMap(Map<String, dynamic> map)
      : peso = map['peso'] ?? '',
        unidade = map['unidade'] ?? '',
        codLote = map['codLote'] ?? '',
        dataExpedicao = map['dataExpedicao'] ?? '',
        endereco = map['endereco'] ?? '',
        cpfCnpj = map['cpfCnpj'] ?? '',
        dataQrCode = map['dataQrCode'] ?? '',
        valor = map['valor'] ?? '',
        nomeDoProduto = map['nomeDoProduto'] ?? '';

  // Método para converter a classe em um mapa
  Map<String, dynamic> toMap() {
    return {
      'peso': peso,
      'unidade': unidade,
      'codLote': codLote,
      'dataExpedicao': dataExpedicao,
      'endereco': endereco,
      'cpfCnpj': cpfCnpj,
      'dataQrCode': dataQrCode,
      'valor': valor,
      'nomeDoProduto': nomeDoProduto,
    };
  }
}
