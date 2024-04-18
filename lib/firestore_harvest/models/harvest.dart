class Harvest {
  String id;
  String custo;
  String quantidadeProduzida;
  String dataDaColheita;
  String unidade;

  Harvest({
    required this.id,
    required this.custo,
    required this.quantidadeProduzida,
    required this.unidade,
    required this.dataDaColheita,
  });

  Harvest.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        custo = map['custo'],
        quantidadeProduzida = map['quantidadeProduzida'],
        unidade = map['unidade'],
        dataDaColheita = map['dataDaColheita'];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'custo': custo,
      'quantidadeProduzida': quantidadeProduzida,
      'unidade': unidade,
      'dataDaColheita': dataDaColheita,
    };
  }
}
