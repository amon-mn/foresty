import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foresty/firestore_batch/models/batch.dart';
import 'package:foresty/firestore_tags/screens/components/tag_widget.dart';
import 'package:foresty/firestore_tags/screens/tag_details.dart';

class TagScreen extends StatelessWidget {
  final List<ProductBatch> listBatchs;
  final User user;

  const TagScreen({Key? key, required this.listBatchs, required this.user})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<ProductBatch> filteredBatches =
        listBatchs.where((batch) => batch.qrCode != null).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Códigos QR'),
      ),
      body: ListView.builder(
        itemCount: filteredBatches.length,
        itemBuilder: (context, index) {
          ProductBatch batch = filteredBatches[index];
          return GestureDetector(
            onTap: () {
              _navigateToEtiquetaPage(context, batch);
            },
            child: Column(
              children: [
                TagWidget(
                  title: batch.nomeLote ?? '',
                  subtitle: batch.nomeProduto ?? '',
                  dataQrCode: user.uid,
                  batchId: batch.id,
                  onTap: () {
                    _navigateToEtiquetaPage(context, batch);
                  },
                ),
                // Adicione qualquer espaço ou divisor adicional conforme necessário
              ],
            ),
          );
        },
      ),
    );
  }

  void _navigateToEtiquetaPage(BuildContext context, ProductBatch batch) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TagDetailsScreen(
          batch: batch,
          user: user,
        ), // Use EtiquetaPage como a nova página
      ),
    );
  }
}
