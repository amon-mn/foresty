import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foresty/firestore_batch/models/batch.dart';
import 'package:foresty/firestore_tags/tag.dart';

class TagDetailsScreen extends StatelessWidget {
  final ProductBatch batch;
  final User user;

  const TagDetailsScreen({Key? key, required this.batch, required this.user})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Etiqueta do Produto'),
      ),
      body: Tag(
        peso: batch.qrCode?.etiqueta?.peso ?? '',
        unidade: batch.qrCode?.etiqueta?.unidade ?? '',
        lote: batch.nomeLote ?? '',
        dataExpedicao: batch.qrCode?.etiqueta?.dataExpedicao ?? '',
        endereco: batch.qrCode?.etiqueta?.endereco ?? '',
        cpfCnpj: batch.qrCode?.etiqueta?.cpfCnpj ?? '',
        userIdQrCode: user.uid,
        batchId: batch.id,
        valor: batch.qrCode?.etiqueta?.valor ?? '',
        nomeDoProduto: batch.nomeProduto ?? '',
        showImage: batch.qrCode?.isOrganico ?? false,
      ),
    );
  }
}
