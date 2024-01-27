import 'package:flutter/material.dart';
import 'package:foresty/firestore_activity/models/batch_activity.dart';
import 'package:foresty/firestore_batch/models/batch.dart';

class BatchDetailsPage extends StatelessWidget {
  final ProductBatch batch;

  BatchDetailsPage({required this.batch});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(238, 238, 238, 1),
      appBar: AppBar(
        title: Text(
          'Detalhes do Lote',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 0, 90, 3),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDetailRow('ID do Lote', batch.id),
              _buildDetailRow(
                  'Nome do Lote', batch.nomeLote ?? 'Não disponível'),
              _buildDetailRow('Largura', batch.largura.toString()),
              _buildDetailRow('Comprimento', batch.comprimento.toString()),
              _buildDetailRow(
                  'Área', batch.area?.toString() ?? 'Não disponível'),
              _buildDetailRow('Latitude', batch.latitude.toString()),
              _buildDetailRow('Longitude', batch.longitude.toString()),
              _buildDetailRow(
                  'Finalidade',
                  batch.finalidade == 'Outro (Especificar)'
                      ? batch.outraFinalidade!
                      : batch.finalidade),
              _buildDetailRow(
                  'Ambiente',
                  batch.ambiente == 'Outro (Especificar)'
                      ? batch.outroAmbiente!
                      : batch.ambiente),
              _buildDetailRow(
                  'Tipo de Cultivo',
                  batch.tipoCultivo == 'Outro (Especificar)'
                      ? batch.outroTipoCultivo!
                      : batch.tipoCultivo),
              _buildDetailRow(
                  'Nome do Produto', batch.nomeProduto ?? 'Não disponível'),
              const SizedBox(height: 16),
              _buildActivitySection(batch.atividades),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 150,
            child: Text(
              '$label:',
              style: TextStyle(
                color: Colors.grey[900],
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              value.isNotEmpty ? value : 'Não disponível',
              style: TextStyle(
                color: Colors.grey[900],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRowListWidgets(String label, List<Widget> details) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 8.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: details,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivitySection(List<BatchActivity>? activities) {
    if (activities == null || activities.isEmpty) {
      return Container(
        child: Text(
          'Nenhuma atividade cadastrada para este lote.',
          style: TextStyle(fontSize: 16),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Atividades do Lote:',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.grey[900],
          ),
        ),
        SizedBox(height: 8),
        Column(
          children: activities.map((activity) {
            return _buildActivityRow(activity);
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildActivityRow(BatchActivity activity) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tipo de Atividade: ${activity.tipoAtividade}',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            'Data da Atividade: ${activity.dataDaAtividade}',
            style: TextStyle(fontSize: 14),
          ),
          SizedBox(height: 8),
          _buildSpecificActivityDetails(activity),
        ],
      ),
    );
  }

  Widget _buildSpecificActivityDetails(BatchActivity activity) {
    switch (activity.tipoAtividade) {
      case 'Preparo do solo':
        return _buildPreparoSoloDetails(activity.preparoSolo);
      case 'Plantio':
        return _buildPlantioDetails(activity.plantio);
      case 'Manejo de doenças':
        return _buildManejoDoencasDetails(activity.manejoDoencas);
      case 'Adubação de cobertura':
        return _buildAdubacaoCoberturaDetails(activity.adubacaoCobertura);
      case 'Capina':
        return _buildCapinaDetails(activity.capina);
      case 'Manejo de pragas':
        return _buildManejoPragasDetails(activity.manejoPragas);
      case 'Tratos culturais':
        return _buildTratosCulturaisDetails(activity.tratosCulturais);
      default:
        return const Text('Detalhes não disponíveis para esta atividade');
    }
  }

  Widget _buildPreparoSoloDetails(PreparoSolo? preparoSolo) {
    if (preparoSolo == null) {
      return Container(); // Não há detalhes de Preparo de Solo para mostrar
    }

    List<Widget> widgets = [
      Text(
        'Detalhes do Preparo de Solo:',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.grey[900],
        ),
      ),
      _buildDetailRow('Tipo de Solo', preparoSolo.tipo),
      _buildDetailRow('Tamanho', preparoSolo.tamanho),
    ];

    if (preparoSolo.usouCalcario != null) {
      widgets.add(
        _buildDetailRow(
            'Usou Calcário', preparoSolo.usouCalcario! ? 'Sim' : 'Não'),
      );
      if (preparoSolo.usouCalcario!) {
        widgets.add(_buildDetailRow(
          'Quantidade de Calcário',
          preparoSolo.quantidadeCalcario ?? 'Não disponível',
        ));
      }
    }

    if (!preparoSolo.naoFezAdubacao) {
      widgets.addAll([
        _buildDetailRow('Tipo de Adubo', preparoSolo.tipoAdubo),
        _buildDetailRow(
            'Tipo de Adubação', preparoSolo.tipoAdubacao ?? 'Não disponível'),
        _buildDetailRow(
            'Quantidade', preparoSolo.quantidade ?? 'Não disponível'),
        _buildDetailRow('Unidade', preparoSolo.unidade ?? 'Não disponível'),
        _buildDetailRow('Produto Utilizado',
            preparoSolo.produtoUtilizado ?? 'Não disponível'),
        _buildDetailRow(
            'Dose Aplicada', preparoSolo.doseAplicada ?? 'Não disponível'),
      ]);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }

  Widget _buildPlantioDetails(Plantio? plantio) {
    if (plantio == null) {
      return Container(); // Não há detalhes de Plantio para mostrar
    }

    List<Widget> widgets = [
      Text(
        'Detalhes do Plantio:',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.grey[900],
        ),
      ),
      _buildDetailRow('Tipo de Plantação', plantio.tipo),
      _buildDetailRow('Quantidade', plantio.quantidade.toString()),
    ];

    if (plantio.tipo == 'Semeadura direta') {
      widgets.add(_buildDetailRow('Largura', plantio.largura.toString()));
      widgets
          .add(_buildDetailRow('Comprimento', plantio.comprimento.toString()));
    }

    // Adicione mais detalhes conforme necessário

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }

// Métodos para mostrar detalhes específicos de cada tipo de atividade
  Widget _buildManejoDoencasDetails(ManejoDoencas? manejoDoencas) {
    if (manejoDoencas == null) {
      return Container(); // Não há detalhes de Manejo de Doenças para mostrar
    }

    List<Widget> widgets = [
      Text(
        'Detalhes do Manejo de Doenças:',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.grey[900],
        ),
      ),
      _buildDetailRow('Nome da Doença', manejoDoencas.nomeDoenca),
      _buildDetailRow('Tipo de Controle', manejoDoencas.tipoControle),
    ];

    if (manejoDoencas.tipoVetor == 'Químico') {
      widgets.add(_buildDetailRow('Tipo de Vetor', 'Químico'));
      widgets.add(_buildDetailRow(
          'Produto Utilizado', manejoDoencas.produtoUtilizado ?? 'N/A'));
      widgets.add(_buildDetailRow(
          'Dose Aplicada', manejoDoencas.doseAplicada?.toString() ?? 'N/A'));
    } else if (manejoDoencas.tipoVetor == 'Natural') {
      widgets.add(_buildDetailRow('Tipo de Vetor', 'Natural'));
    }

    // Adicione mais detalhes conforme necessário

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }

  Widget _buildAdubacaoCoberturaDetails(AdubacaoCobertura? adubacaoCobertura) {
    if (adubacaoCobertura == null) {
      return Container(); // Não há detalhes de Adubação de Cobertura para mostrar
    }

    List<Widget> widgets = [
      Text(
        'Detalhes da Adubação de Cobertura:',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.grey[900],
        ),
      ),
      _buildDetailRow('Tipo de Adubação', adubacaoCobertura.tipo),
    ];

    if (adubacaoCobertura.tipoAdubacao != null) {
      widgets.addAll([
        _buildDetailRow('Tipo de Adubo', adubacaoCobertura.tipoAdubo),
        _buildDetailRow('Tipo de Adubação',
            adubacaoCobertura.tipoAdubacao ?? 'Não disponível'),
        _buildDetailRow(
            'Quantidade', adubacaoCobertura.quantidade ?? 'Não disponível'),
        _buildDetailRow(
            'Unidade', adubacaoCobertura.unidade ?? 'Não disponível'),
        _buildDetailRow('Produto Utilizado',
            adubacaoCobertura.produtoUtilizado ?? 'Não disponível'),
        _buildDetailRow('Dose Aplicada',
            adubacaoCobertura.doseAplicada ?? 'Não disponível'),
      ]);
    }

    widgets.add(_buildDetailRow(
        'Não Fez Adubação', adubacaoCobertura.naoFezAdubacao ? 'Sim' : 'Não'));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }

  Widget _buildCapinaDetails(Capina? capina) {
    if (capina == null) {
      return Container(); // Não há detalhes de Capina para mostrar
    }

    List<Widget> widgets = [
      Text(
        'Detalhes da Capina:',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.grey[900],
        ),
      ),
      _buildDetailRow('Tipo de Capina', capina.tipo),
    ];

    if (capina.tipo == 'Química') {
      widgets
          .add(_buildDetailRow('Nome do Produto', capina.nomeProduto ?? 'N/A'));
      widgets.add(_buildDetailRow('Quantidade Aplicada',
          capina.quantidadeAplicada?.toString() ?? 'N/A'));
    }

    widgets.add(_buildDetailRow('Dimensão', capina.dimensao));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }

  Widget _buildManejoPragasDetails(ManejoPragas? manejoPragas) {
    if (manejoPragas == null) {
      return Container(); // Não há detalhes de Manejo de Pragas para mostrar
    }

    List<Widget> widgets = [
      Text(
        'Detalhes do Manejo de Pragas:',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.grey[900],
        ),
      ),
      _buildDetailRow('Nome da Praga', manejoPragas.nomePraga),
      _buildDetailRow('Tipo', manejoPragas.tipo),
    ];

    if (manejoPragas.tipo == 'Aplicação de agrotóxico') {
      widgets.addAll([
        _buildDetailRow('Nome do Agrotóxico',
            manejoPragas.nomeAgrotoxico ?? 'Não disponível'),
        _buildDetailRow('Quantidade Recomendada',
            manejoPragas.quantidadeRecomendadaAgrotoxico ?? 'Não disponível'),
        _buildDetailRow('Quantidade Aplicada',
            manejoPragas.quantidadeAplicadaAgrotoxico ?? 'Não disponível'),
        _buildDetailRow('Unidade Recomendada',
            manejoPragas.unidadeRecomendadaAgrotoxico ?? 'Não disponível'),
        _buildDetailRow('Unidade Aplicada',
            manejoPragas.unidadeAplicadaAgrotoxico ?? 'Não disponível'),
      ]);
    } else if (manejoPragas.tipo == 'Controle natural') {
      widgets.addAll([
        _buildDetailRow(
            'Tipo de Controle', manejoPragas.tipoControle ?? 'Não disponível'),
        _buildDetailRow('Nome do Defensivo Natural',
            manejoPragas.nomeDefensivoNatural ?? 'Não disponível'),
        _buildDetailRow(
            'Quantidade Recomendada',
            manejoPragas.quantidadeRecomendadaDefensivoNatural ??
                'Não disponível'),
        _buildDetailRow(
            'Quantidade Aplicada',
            manejoPragas.quantidadeAplicadaDefensivoNatural ??
                'Não disponível'),
        _buildDetailRow(
            'Unidade Recomendada',
            manejoPragas.unidadeRecomendadaDefensivoNatural ??
                'Não disponível'),
        _buildDetailRow('Unidade Aplicada',
            manejoPragas.unidadeAplicadaDefensivoNatural ?? 'Não disponível'),
        _buildDetailRow(
            'Tipo de Coleta', manejoPragas.tipoColeta ?? 'Não disponível'),
        _buildDetailRow('Nome do Inimigo Natural',
            manejoPragas.nomeInimigoNatural ?? 'Não disponível'),
        _buildDetailRow('Forma de Uso do Inimigo Natural',
            manejoPragas.formaUsoInimigoNatural ?? 'Não disponível'),
      ]);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }

  Widget _buildTratosCulturaisDetails(TratosCulturais? tratosCulturais) {
    if (tratosCulturais == null) {
      return Container(); // Não há detalhes de Tratos Culturais para mostrar
    }

    List<Widget> widgets = [
      Text(
        'Detalhes dos Tratos Culturais:',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.grey[900],
        ),
      ),
      _buildDetailRow('Tipo de Controle', tratosCulturais.tipoControle),
    ];

    if (tratosCulturais.tipoControle == 'Outro') {
      widgets.add(
        _buildDetailRow(
            'Tipo Especificado', tratosCulturais.outroTipo ?? 'Não disponível'),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }
}
