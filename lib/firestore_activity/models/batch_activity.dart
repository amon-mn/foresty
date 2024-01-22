class BatchActivity {
  String id;
  String tipoAtividade;
  String dataDaAtividade;
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
  Adubacao? adubacao;
  bool naoFezAdubacao;

  PreparoSolo({
    required this.tipo,
    required this.tamanho,
    this.usouCalcario,
    this.quantidadeCalcario,
    this.adubacao,
    required this.naoFezAdubacao,
  });

  PreparoSolo.empty()
      : tipo = '',
        tamanho = '0',
        usouCalcario = false,
        quantidadeCalcario = '0',
        adubacao = null,
        naoFezAdubacao = false;

  PreparoSolo.fromMap(Map<String, dynamic> map)
      : tipo = map['tipo'] ?? '',
        tamanho = map['tamanho'] ?? '0',
        usouCalcario = map['usouCalcário'] ?? false,
        quantidadeCalcario = map['quantidadeCalcário'] ?? '0',
        adubacao =
            map['adubacao'] != null ? Adubacao.fromMap(map['adubacao']) : null,
        naoFezAdubacao = map['naoFezAdubacao'] ?? false;

  Map<String, dynamic> toMap() {
    return {
      'tipo': tipo,
      'tamanho': tamanho,
      'usouCalcário': usouCalcario,
      'quantidadeCalcário': quantidadeCalcario,
      'adubação': adubacao?.toMap(),
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
  Adubacao? adubacao;
  bool naoFezAdubacao;

  AdubacaoCobertura({
    required this.tipo,
    this.adubacao,
    required this.naoFezAdubacao,
  });

  AdubacaoCobertura.empty()
      : tipo = '',
        adubacao = null,
        naoFezAdubacao = false;

  AdubacaoCobertura.fromMap(Map<String, dynamic> map)
      : tipo = map['tipo'],
        adubacao =
            map['adubacao'] != null ? Adubacao.fromMap(map['adubacao']) : null,
        naoFezAdubacao = map['naoFezAdubacao'];

  Map<String, dynamic> toMap() {
    return {
      'tipo': tipo,
      'adubacaoOrganica': adubacao?.toMap(),
      'naoFezAdubacao': naoFezAdubacao,
    };
  }
}

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
  AplicacaoAgrotoxico? aplicacaoAgrotoxico;
  ControleNatural? controleNatural;

  ManejoPragas({
    required this.nomePraga,
    required this.tipo,
    this.aplicacaoAgrotoxico,
    this.controleNatural,
  });

  ManejoPragas.empty()
      : nomePraga = '',
        tipo = '',
        aplicacaoAgrotoxico = null,
        controleNatural = null;

  ManejoPragas.fromMap(Map<String, dynamic> map)
      : nomePraga = map['nomePraga'],
        tipo = map['tipo'],
        aplicacaoAgrotoxico = map['aplicacaoAgrotoxico'] != null
            ? AplicacaoAgrotoxico.fromMap(map['aplicacaoAgrotoxico'])
            : null,
        controleNatural = map['controleNatural'] != null
            ? ControleNatural.fromMap(map['controleNatural'])
            : null;

  Map<String, dynamic> toMap() {
    return {
      'nomePraga': nomePraga,
      'tipo': tipo,
      'aplicacaoAgrotoxico': aplicacaoAgrotoxico?.toMap(),
      'controleNatural': controleNatural?.toMap(),
    };
  }
}

class AplicacaoAgrotoxico {
  String nomeAgrotoxico;
  String quantidadeRecomendada;
  String quantidadeAplicada;
  String unidadeRecomendada;
  String unidadeAplicada;

  AplicacaoAgrotoxico(
      {required this.nomeAgrotoxico,
      required this.quantidadeRecomendada,
      required this.quantidadeAplicada,
      required this.unidadeRecomendada,
      required this.unidadeAplicada});

  AplicacaoAgrotoxico.empty()
      : nomeAgrotoxico = '',
        quantidadeRecomendada = '0',
        quantidadeAplicada = '0',
        unidadeRecomendada = '',
        unidadeAplicada = '';

  AplicacaoAgrotoxico.fromMap(Map<String, dynamic> map)
      : nomeAgrotoxico = map['nomeAgrotoxico'],
        quantidadeRecomendada = map['quantidadeRecomendada'],
        quantidadeAplicada = map['quantidadeAplicada'],
        unidadeRecomendada = map['unidadeRecomendada'],
        unidadeAplicada = map['unidadeAplicada'];

  Map<String, dynamic> toMap() {
    return {
      'nomeAgrotoxico': nomeAgrotoxico,
      'quantidadeRecomendada': quantidadeRecomendada,
      'quantidadeAplicada': quantidadeAplicada,
      'unidadeRecomendada': unidadeRecomendada,
      'unidadeAplicada': unidadeAplicada,
    };
  }
}

class ControleNatural {
  String tipoControle;
  DefensivoNatural? aplicacaoDefensivo;
  ColetaEliminacao? coletaEliminacao;
  UsoInimigoNatural? usoInimigoNatural;

  ControleNatural({
    required this.tipoControle,
    this.aplicacaoDefensivo,
    this.coletaEliminacao,
    this.usoInimigoNatural,
  });

  ControleNatural.empty()
      : tipoControle = '',
        aplicacaoDefensivo = null,
        coletaEliminacao = null,
        usoInimigoNatural = null;

  ControleNatural.fromMap(Map<String, dynamic> map)
      : tipoControle = map['tipoControle'],
        aplicacaoDefensivo = map['aplicacaoDefensivo'] != null
            ? DefensivoNatural.fromMap(map['aplicacaoDefensivo'])
            : null,
        coletaEliminacao = map['coletaEliminacao'] != null
            ? ColetaEliminacao.fromMap(map['coletaEliminacao'])
            : null,
        usoInimigoNatural = map['usoInimigoNatural'] != null
            ? UsoInimigoNatural.fromMap(map['usoInimigoNatural'])
            : null;

  Map<String, dynamic> toMap() {
    return {
      'tipoControle': tipoControle,
      'aplicacaoDefensivo': aplicacaoDefensivo?.toMap(),
      'coletaEliminacao': coletaEliminacao?.toMap(),
      'usoInimigoNatural': usoInimigoNatural?.toMap(),
    };
  }
}

class DefensivoNatural {
  String nomeOuTipo;
  String quantidadeRecomendada;
  String quantidadeAplicada;
  String unidadeRecomendada;
  String unidadeAplicada;

  DefensivoNatural(
      {required this.nomeOuTipo,
      required this.quantidadeRecomendada,
      required this.quantidadeAplicada,
      required this.unidadeRecomendada,
      required this.unidadeAplicada});

  DefensivoNatural.empty()
      : nomeOuTipo = '',
        quantidadeRecomendada = '0',
        quantidadeAplicada = '0',
        unidadeRecomendada = '',
        unidadeAplicada = '';

  DefensivoNatural.fromMap(Map<String, dynamic> map)
      : nomeOuTipo = map['nomeOuTipo'],
        quantidadeRecomendada = map['quantidadeRecomendada'],
        quantidadeAplicada = map['quantidadeAplicada'],
        unidadeRecomendada = map['unidadeRecomendada'],
        unidadeAplicada = map['unidadeAplicada'];

  Map<String, dynamic> toMap() {
    return {
      'nomeOuTipo': nomeOuTipo,
      'quantidadeRecomendada': quantidadeRecomendada,
      'quantidadeAplicada': quantidadeAplicada,
      'unidadeRecomendada': unidadeRecomendada,
      'unidadeAplicada': unidadeAplicada,
    };
  }
}

class ColetaEliminacao {
  String tipoColeta;

  ColetaEliminacao({required this.tipoColeta});

  ColetaEliminacao.fromMap(Map<String, dynamic> map)
      : tipoColeta = map['tipoColeta'];

  ColetaEliminacao.empty() : tipoColeta = '';

  Map<String, dynamic> toMap() {
    return {
      'tipoColeta': tipoColeta,
    };
  }
}

class UsoInimigoNatural {
  String nomeInimigoNatural;
  String formaUso;

  UsoInimigoNatural({
    required this.nomeInimigoNatural,
    required this.formaUso,
  });

  UsoInimigoNatural.empty()
      : nomeInimigoNatural = '',
        formaUso = '';

  UsoInimigoNatural.fromMap(Map<String, dynamic> map)
      : nomeInimigoNatural = map['nomeInimigoNatural'],
        formaUso = map['formaUso'];

  Map<String, dynamic> toMap() {
    return {
      'nomeInimigoNatural': nomeInimigoNatural,
      'formaUso': formaUso,
    };
  }
}

class TratosCulturais {
  String tipoControle;

  TratosCulturais({
    required this.tipoControle,
  });

  TratosCulturais.empty() : tipoControle = '';

  TratosCulturais.fromMap(Map<String, dynamic> map)
      : tipoControle = map['tipoControle'];

  Map<String, dynamic> toMap() {
    return {'tipoControle': tipoControle};
  }
}
