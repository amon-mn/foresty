import 'package:flutter/material.dart';
import 'package:foresty/firestore_batch/models/batch.dart';

class BatchDetailsPage extends StatelessWidget {
  final ProductBatch batch;

  BatchDetailsPage({required this.batch});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detalhes do Lote',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 0, 90, 3),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        color: Color.fromRGBO(238, 238, 238, 1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow('ID do Lote', batch.id),
            _buildDetailRow('Nome do Lote', batch.nomeLote ?? 'N/A'),
            _buildDetailRow('Largura', batch.largura.toString()),
            _buildDetailRow('Comprimento', batch.comprimento.toString()),
            _buildDetailRow('Área', batch.area?.toString() ?? 'N/A'),
            _buildDetailRow('Latitude', batch.latitude.toString()),
            _buildDetailRow('Longitude', batch.longitude.toString()),
            _buildDetailRow('Finalidade', batch.finalidade),
            _buildDetailRow('Ambiente', batch.ambiente),
            _buildDetailRow('Tipo de Cultivo', batch.tipoCultivo),
            _buildDetailRow('Nome do Produto', batch.nomeProduto ?? 'N/A'),
          ],
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
              value,
              style: TextStyle(
                color: Colors.grey[900],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
