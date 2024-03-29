import 'package:flutter/material.dart';
import 'package:foresty/firestore_batch/models/batch.dart';
import 'package:foresty/firestore_tags/screens/components/tag_widget.dart';

class TagScreen extends StatelessWidget {
  final List<ProductBatch> listBatchs;

  const TagScreen({Key? key, required this.listBatchs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Códigos QR'),
      ),
      body: ListView.builder(
        itemCount: listBatchs.length,
        itemBuilder: (context, index) {
          ProductBatch batch = listBatchs[index];
          return Column(
            children: [
              ListTile(
                title: Text(batch.nomeLote ?? ''),
                subtitle: Text(batch.qrCode?.id ?? ''),
                onTap: () {
                  // Implemente ação ao tocar no lote se necessário
                },
              ),
              TagWidget(
                title: batch.qrCode?.id,
                subtitle: batch.qrCode?.tipoDeVenda,
                onTap: () {
                  // Implemente ação ao tocar no TagWidget se necessário
                },
              ),
              // Adicione qualquer espaço ou divisor adicional conforme necessário
              Divider(),
            ],
          );
        },
      ),
    );
  }
}
