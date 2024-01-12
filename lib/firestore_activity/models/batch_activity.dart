class BatchActivity {
  String id;
  String tipoAtividade;
  String dataDaAtividade;

  // Preparo de Solo
  PreparoSolo? preparoSolo;

  // Plantio
  Plantio? plantio;

  // Manejo de Doenças
  ManejoDoencas? manejoDoencas;

  // Adubação de Cobertura
  AdubacaoCobertura? adubacaoCobertura;

  // Capina
  Capina? capina;

  // Manejo de Pragas
  ManejoPragas? manejoPragas;

  // Tratos Culturais
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
  double tamanho;
  bool? usouCalcario;
  double? quantidadeCalcario;
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

  PreparoSolo.fromMap(Map<String, dynamic> map)
      : tipo = map['tipo'],
        tamanho = map['tamanho'],
        usouCalcario = map['usouCalcário'],
        quantidadeCalcario = map['quantidadeCalcário'],
        adubacao =
            map['adubacao'] != null ? Adubacao.fromMap(map['adubacao']) : null,
        naoFezAdubacao = map['naoFezAdubacao'];

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

  ManejoDoencas({
    required this.nomeDoenca,
    required this.tipoControle,
    this.tipoVetor,
  });

  ManejoDoencas.fromMap(Map<String, dynamic> map)
      : nomeDoenca = map['nomeDoenca'],
        tipoControle = map['tipoControle'],
        tipoVetor = map['tipoVetor'];

  Map<String, dynamic> toMap() {
    return {
      'nomeDoenca': nomeDoenca,
      'tipoControle': tipoControle,
      'tipoVetor': tipoVetor,
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
  String? quantidade;
  String? unidade;

  Adubacao({
    required this.tipoAdubo,
    this.quantidade,
    this.unidade,
  });

  Adubacao.fromMap(Map<String, dynamic> map)
      : tipoAdubo = map['tipoAdubo'],
        quantidade = map['quantidade'],
        unidade = map['unidade'];

  Map<String, dynamic> toMap() {
    return {
      'tipoAdubo': tipoAdubo,
      'quantidade': quantidade,
      'unidade': unidade,
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
  double quantidadeRecomendada;
  double quantidadeAplicada;
  String unidade;

  AplicacaoAgrotoxico({
    required this.nomeAgrotoxico,
    required this.quantidadeRecomendada,
    required this.quantidadeAplicada,
    required this.unidade,
  });

  AplicacaoAgrotoxico.fromMap(Map<String, dynamic> map)
      : nomeAgrotoxico = map['nomeAgrotoxico'],
        quantidadeRecomendada = map['quantidadeRecomendada'],
        quantidadeAplicada = map['quantidadeAplicada'],
        unidade = map['unidade'];

  Map<String, dynamic> toMap() {
    return {
      'nomeAgrotoxico': nomeAgrotoxico,
      'quantidadeRecomendada': quantidadeRecomendada,
      'quantidadeAplicada': quantidadeAplicada,
      'unidade': unidade,
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
  double quantidadeRecomendada;
  double quantidadeAplicada;
  String unidade;

  DefensivoNatural(
      {required this.nomeOuTipo,
      required this.quantidadeRecomendada,
      required this.quantidadeAplicada,
      required this.unidade});

  DefensivoNatural.fromMap(Map<String, dynamic> map)
      : nomeOuTipo = map['nomeOuTipo'],
        quantidadeRecomendada = map['quantidadeRecomendada'],
        quantidadeAplicada = map['quantidadeAplicada'],
        unidade = map['unidade'];

  Map<String, dynamic> toMap() {
    return {
      'nomeOuTipo': nomeOuTipo,
      'quantidadeRecomendada': quantidadeRecomendada,
      'quantidadeAplicada': quantidadeAplicada,
      'unidade': unidade,
    };
  }
}

class ColetaEliminacao {
  String tipoColeta;

  ColetaEliminacao({required this.tipoColeta});

  ColetaEliminacao.fromMap(Map<String, dynamic> map)
      : tipoColeta = map['tipoColeta'];

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

  TratosCulturais.fromMap(Map<String, dynamic> map)
      : tipoControle = map['tipoControle'];

  Map<String, dynamic> toMap() {
    return {'tipoControle': tipoControle};
  }
}
