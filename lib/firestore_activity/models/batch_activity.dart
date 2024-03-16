class BatchActivity {
  String id;
  String tipoAtividade;
  String dataDaAtividade;
  String custo;
  PreparoSolo? preparoSolo;
  Plantio? plantio;
  ManejoDoencas? manejoDoencas;
  AdubacaoCobertura? adubacaoCobertura;
  Capina? capina;
  ManejoPragas? manejoPragas;
  TratosCulturais? tratosCulturais;

  BatchActivity({
    required this.id,
    required this.tipoAtividade,
    required this.dataDaAtividade,
    required this.custo,
    this.preparoSolo,
    this.plantio,
    this.manejoDoencas,
    this.adubacaoCobertura,
    this.capina,
    this.manejoPragas,
    this.tratosCulturais,
  });

  BatchActivity.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        tipoAtividade = map['tipoAtividade'],
        dataDaAtividade = map['dataDaAtividade'],
        custo = map['custo'].toString(),
        preparoSolo = map['preparoSolo'] != null
            ? PreparoSolo.fromMap(map['preparoSolo'])
            : null,
        plantio =
            map['plantio'] != null ? Plantio.fromMap(map['plantio']) : null,
        manejoDoencas = map['manejoDoencas'] != null
            ? ManejoDoencas.fromMap(map['manejoDoencas'])
            : null,
        adubacaoCobertura = map['adubacaoCobertura'] != null
            ? AdubacaoCobertura.fromMap(map['adubacaoCobertura'])
            : null,
        capina = map['capina'] != null ? Capina.fromMap(map['capina']) : null,
        manejoPragas = map['manejoPragas'] != null
            ? ManejoPragas.fromMap(map['manejoPragas'])
            : null,
        tratosCulturais = map['tratosCulturais'] != null
            ? TratosCulturais.fromMap(map['tratosCulturais'])
            : null;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'tipoAtividade': tipoAtividade,
      'dataDaAtividade': dataDaAtividade,
      'custo': custo,
      'preparoSolo': preparoSolo?.toMap(),
      'plantio': plantio?.toMap(),
      'manejoDoencas': manejoDoencas?.toMap(),
      'adubacaoCobertura': adubacaoCobertura?.toMap(),
      'capina': capina?.toMap(),
      'manejoPragas': manejoPragas?.toMap(),
      'tratosCulturais': tratosCulturais?.toMap(),
    };
  }
}

// Subclasses for each activity type

class PreparoSolo {
  String tipo;
  String tamanho;
  bool? usouCalcario;
  String? quantidadeCalcario;
  String tipoAdubo;
  String? tipoAdubacao;
  String? quantidade;
  String? unidade;
  String? produtoUtilizado;
  String? doseAplicada;
  bool naoFezAdubacao;

  PreparoSolo({
    required this.tipo,
    required this.tamanho,
    this.usouCalcario,
    this.quantidadeCalcario,
    required this.tipoAdubo,
    this.tipoAdubacao,
    this.quantidade,
    this.unidade,
    this.produtoUtilizado,
    this.doseAplicada,
    required this.naoFezAdubacao,
  });

  PreparoSolo.empty()
      : tipo = '',
        tamanho = '0',
        usouCalcario = false,
        quantidadeCalcario = '0',
        tipoAdubo = '',
        tipoAdubacao = '',
        quantidade = '0',
        unidade = '',
        doseAplicada = '0',
        produtoUtilizado = '',
        naoFezAdubacao = false;

  PreparoSolo.fromMap(Map<String, dynamic> map)
      : tipo = map['tipo'] ?? '',
        tamanho = map['tamanho'] ?? '0',
        usouCalcario = map['usouCalcário'] ?? false,
        quantidadeCalcario = map['quantidadeCalcário'] ?? '0',
        tipoAdubo = map['tipoAdubo'] ?? '',
        tipoAdubacao = map['tipoAdubacao'] ?? '',
        quantidade = map['quantidade'] ?? '0',
        unidade = map['unidade'] ?? '',
        doseAplicada = map['doseAplicada'] ?? '0',
        produtoUtilizado = map['produtoUtilizado'] ?? '',
        naoFezAdubacao = map['naoFezAdubacao'] ?? false;

  Map<String, dynamic> toMap() {
    return {
      'tipo': tipo,
      'tamanho': tamanho,
      'usouCalcário': usouCalcario,
      'quantidadeCalcário': quantidadeCalcario,
      'tipoAdubo': tipoAdubo,
      'tipoAdubacao': tipoAdubacao,
      'quantidade': quantidade,
      'unidade': unidade,
      'doseAplicada': doseAplicada,
      'produtoUtilizado': produtoUtilizado,
      'não fez adubação': naoFezAdubacao,
    };
  }
}

class Plantio {
  String tipo;
  int quantidade;
  double? largura;
  double? comprimento;

  Plantio({
    required this.tipo,
    required this.quantidade,
    this.largura,
    this.comprimento,
  });

  Plantio.empty()
      : tipo = '',
        quantidade = 0,
        largura = 0.0,
        comprimento = 0.0;

  Plantio.fromMap(Map<String, dynamic> map)
      : tipo = map['tipo'],
        quantidade = map['quantidade'],
        largura = map['largura'],
        comprimento = map['comprimento'];

  Map<String, dynamic> toMap() {
    return {
      'tipo': tipo,
      'quantidade': quantidade,
      'largura': largura,
      'comprimento': comprimento,
    };
  }
}

class ManejoDoencas {
  String nomeDoenca;
  String tipoControle;
  String? tipoVetor;
  String? produtoUtilizado;
  double? doseAplicada;

  ManejoDoencas(
      {required this.nomeDoenca,
      required this.tipoControle,
      this.tipoVetor,
      this.produtoUtilizado,
      this.doseAplicada});

  ManejoDoencas.empty()
      : nomeDoenca = '',
        tipoControle = '',
        tipoVetor = '',
        doseAplicada = 0,
        produtoUtilizado = '';

  ManejoDoencas.fromMap(Map<String, dynamic> map)
      : nomeDoenca = map['nomeDoenca'],
        tipoControle = map['tipoControle'],
        tipoVetor = map['tipoVetor'],
        doseAplicada = map['doseAplicada'],
        produtoUtilizado = map['produtoUtilizado'];

  Map<String, dynamic> toMap() {
    return {
      'nomeDoenca': nomeDoenca,
      'tipoControle': tipoControle,
      'tipoVetor': tipoVetor,
      'doseAplicada': doseAplicada,
      'produtoUtilizado': produtoUtilizado,
    };
  }
}

class AdubacaoCobertura {
  String tipo;
  String tipoAdubo;
  String? tipoAdubacao;
  String? quantidade;
  String? unidade;
  String? produtoUtilizado;
  String? doseAplicada;
  bool naoFezAdubacao;

  AdubacaoCobertura({
    required this.tipo,
    required this.tipoAdubo,
    this.tipoAdubacao,
    this.quantidade,
    this.unidade,
    this.produtoUtilizado,
    this.doseAplicada,
    required this.naoFezAdubacao,
  });

  AdubacaoCobertura.empty()
      : tipo = '',
        tipoAdubo = '',
        tipoAdubacao = '',
        quantidade = '0',
        unidade = '',
        doseAplicada = '0',
        produtoUtilizado = '',
        naoFezAdubacao = false;

  AdubacaoCobertura.fromMap(Map<String, dynamic> map)
      : tipo = map['tipo'] ?? '',
        tipoAdubo = map['tipoAdubo'] ?? '',
        tipoAdubacao = map['tipoAdubacao'] ?? '',
        quantidade = map['quantidade'] ?? '0',
        unidade = map['unidade'] ?? '',
        doseAplicada = map['doseAplicada'] ?? '0',
        produtoUtilizado = map['produtoUtilizado'] ?? '',
        naoFezAdubacao = map['naoFezAdubacao'] ?? false;

  Map<String, dynamic> toMap() {
    return {
      'tipo': tipo,
      'tipoAdubo': tipoAdubo,
      'tipoAdubacao': tipoAdubacao,
      'quantidade': quantidade,
      'unidade': unidade,
      'doseAplicada': doseAplicada,
      'produtoUtilizado': produtoUtilizado,
      'naoFezAdubacao': naoFezAdubacao,
    };
  }
}

/*
class Adubacao {
  String tipoAdubo;
  String? tipoAdubacao;
  String? quantidade;
  String? unidade;
  String? produtoUtilizado;
  String? doseAplicada;

  Adubacao({
    required this.tipoAdubo,
    this.tipoAdubacao,
    this.quantidade,
    this.unidade,
    this.produtoUtilizado,
    this.doseAplicada,
  });

  Adubacao.empty()
      : tipoAdubo = '',
        tipoAdubacao = '',
        quantidade = '0',
        unidade = '',
        doseAplicada = '0',
        produtoUtilizado = '';

  Adubacao.fromMap(Map<String, dynamic> map)
      : tipoAdubo = map['tipoAdubo'],
        tipoAdubacao = map['tipoAdubacao'],
        quantidade = map['quantidade'],
        unidade = map['unidade'],
        doseAplicada = map['doseAplicada'],
        produtoUtilizado = map['produtoUtilizado'];

  Map<String, dynamic> toMap() {
    return {
      'tipoAdubo': tipoAdubo,
      'tipoAdubacao': tipoAdubacao,
      'quantidade': quantidade,
      'unidade': unidade,
      'doseAplicada': doseAplicada,
      'produtoUtilizado': produtoUtilizado,
    };
  }
}
*/

class Capina {
  String tipo;
  String? nomeProduto;
  double? quantidadeAplicada;
  String dimensao;

  Capina({
    required this.tipo,
    this.nomeProduto,
    required this.quantidadeAplicada,
    required this.dimensao,
  });

  Capina.empty()
      : tipo = '',
        nomeProduto = '',
        quantidadeAplicada = 0.0,
        dimensao = '';

  Capina.fromMap(Map<String, dynamic> map)
      : tipo = map['tipo'],
        nomeProduto = map['nomeProduto'],
        quantidadeAplicada = map['quantidadeAplicada'],
        dimensao = map['dimensao'];

  Map<String, dynamic> toMap() {
    return {
      'tipo': tipo,
      'nomeProduto': nomeProduto,
      'quantidadeAplicada': quantidadeAplicada,
      'dimensao': dimensao,
    };
  }
}

class ManejoPragas {
  String nomePraga;
  String tipo;
  String? nomeAgrotoxico;
  String? quantidadeRecomendadaAgrotoxico;
  String? quantidadeAplicadaAgrotoxico;
  String? unidadeRecomendadaAgrotoxico;
  String? unidadeAplicadaAgrotoxico;
  String? tipoControle;
  String? nomeDefensivoNatural;
  String? quantidadeRecomendadaDefensivoNatural;
  String? quantidadeAplicadaDefensivoNatural;
  String? unidadeRecomendadaDefensivoNatural;
  String? unidadeAplicadaDefensivoNatural;
  String? tipoColeta;
  String? nomeInimigoNatural;
  String? formaUsoInimigoNatural;

  ManejoPragas({
    required this.nomePraga,
    required this.tipo,
    this.nomeAgrotoxico,
    this.quantidadeRecomendadaAgrotoxico,
    this.quantidadeAplicadaAgrotoxico,
    this.unidadeRecomendadaAgrotoxico,
    this.unidadeAplicadaAgrotoxico,
    this.tipoControle,
    this.nomeDefensivoNatural,
    this.quantidadeRecomendadaDefensivoNatural,
    this.quantidadeAplicadaDefensivoNatural,
    this.unidadeRecomendadaDefensivoNatural,
    this.unidadeAplicadaDefensivoNatural,
    this.tipoColeta,
    this.nomeInimigoNatural,
    this.formaUsoInimigoNatural,
  });

  ManejoPragas.empty()
      : nomePraga = '',
        tipo = '',
        nomeAgrotoxico = '',
        quantidadeRecomendadaAgrotoxico = '0',
        quantidadeAplicadaAgrotoxico = '0',
        unidadeRecomendadaAgrotoxico = '',
        unidadeAplicadaAgrotoxico = '',
        tipoControle = '',
        nomeDefensivoNatural = '',
        quantidadeRecomendadaDefensivoNatural = '0',
        quantidadeAplicadaDefensivoNatural = '0',
        unidadeRecomendadaDefensivoNatural = '',
        unidadeAplicadaDefensivoNatural = '',
        tipoColeta = '',
        nomeInimigoNatural = '',
        formaUsoInimigoNatural = '';

  ManejoPragas.fromMap(Map<String, dynamic> map)
      : nomePraga = map['nomePraga'],
        tipo = map['tipo'],
        nomeAgrotoxico = map['nomeAgrotoxico'],
        quantidadeRecomendadaAgrotoxico =
            map['quantidadeRecomendadaAgrotoxico'],
        quantidadeAplicadaAgrotoxico = map['quantidadeAplicadaAgrotoxico'],
        unidadeRecomendadaAgrotoxico = map['unidadeRecomendadaAgrotoxico'],
        unidadeAplicadaAgrotoxico = map['unidadeAplicadaAgrotoxico'],
        tipoControle = map['tipoControle'],
        nomeDefensivoNatural = map['nomeDefensivoNatural'],
        quantidadeRecomendadaDefensivoNatural =
            map['quantidadeRecomendadaDefensivoNatural'],
        quantidadeAplicadaDefensivoNatural =
            map['quantidadeAplicadaDefensivoNatural'],
        unidadeRecomendadaDefensivoNatural =
            map['unidadeRecomendadaDefensivoNatural'],
        unidadeAplicadaDefensivoNatural =
            map['unidadeAplicadaDefensivoNatural'],
        tipoColeta = map['tipoColeta'],
        nomeInimigoNatural = map['nomeInimigoNatural'],
        formaUsoInimigoNatural = map['formaUsoInimigoNatural'];

  Map<String, dynamic> toMap() {
    return {
      'nomePraga': nomePraga,
      'tipo': tipo,
      'nomeAgrotoxico': nomeAgrotoxico,
      'quantidadeRecomendadaAgrotoxico': quantidadeRecomendadaAgrotoxico,
      'quantidadeAplicadaAgrotoxico': quantidadeAplicadaAgrotoxico,
      'unidadeRecomendadaAgrotoxico': unidadeRecomendadaAgrotoxico,
      'unidadeAplicadaAgrotoxico': unidadeAplicadaAgrotoxico,
      'tipoControle': tipoControle,
      'nomeDefensivoNatural': nomeDefensivoNatural,
      'quantidadeRecomendadaDefensivoNatural':
          quantidadeRecomendadaDefensivoNatural,
      'quantidadeAplicadaDefensivoNatural': quantidadeAplicadaDefensivoNatural,
      'unidadeRecomendadaDefensivoNatural': unidadeRecomendadaDefensivoNatural,
      'unidadeAplicadaDefensivoNatural': unidadeAplicadaDefensivoNatural,
      'tipoColeta': tipoColeta,
      'nomeInimigoNatural': nomeInimigoNatural,
      'formaUsoInimigoNatural': formaUsoInimigoNatural,
    };
  }
}

class TratosCulturais {
  String tipoControle;
  String? outroTipo;

  TratosCulturais({required this.tipoControle, this.outroTipo});

  TratosCulturais.empty()
      : tipoControle = '',
        outroTipo = '';

  TratosCulturais.fromMap(Map<String, dynamic> map)
      : tipoControle = map['tipoControle'],
        outroTipo = map['outroTipo'];

  Map<String, dynamic> toMap() {
    return {'tipoControle': tipoControle, 'outroTipo': outroTipo};
  }
}
