class Harvest {
  String id;
  String quantidadeProduzida;
  String dataDaColheita;
  String unidade;

  Harvest({
    required this.id,
    required this.quantidadeProduzida,
    required this.unidade,
    required this.dataDaColheita,
  });

  Harvest.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        quantidadeProduzida = map['quantidadeProduzida'],
        unidade = map['unidade'],
        dataDaColheita = map['dataDaColheita'];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'quantidadeProduzida': quantidadeProduzida,
      'unidade': unidade,
      'dataDaColheita': dataDaColheita,
    };
  }
}
