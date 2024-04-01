import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/rendering.dart';
import 'package:foresty/firestore_batch/models/batch.dart';
import 'package:foresty/firestore_tags/tag.dart';
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;

class TagDetailsScreen extends StatelessWidget {
  final ProductBatch batch;
  final User user;
  // Criar uma GlobalKey para o RepaintBoundary
  final GlobalKey boundaryKey = GlobalKey();

  TagDetailsScreen({Key? key, required this.batch, required this.user})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Etiqueta do Produto'),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text('Exportar como PDF'),
                value: 'export_pdf',
              ),
            ],
            onSelected: (value) {
              if (value == 'export_pdf') {
                _exportToPdf(context);
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: RepaintBoundary(
          key: boundaryKey,
          child: Container(
            padding: EdgeInsets.all(16.0), // Adicione o padding desejado aqui
            child: Tag(
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
          ),
        ),
      ),
    );
  }

  Future<void> _exportToPdf(BuildContext context) async {
    final pdf = pw.Document();

    // Aguardar um frame para garantir que o widget esteja pronto antes de capturar a tela
    await Future.delayed(Duration(milliseconds: 100));

    // Capturar a tela como uma imagem
    final RenderRepaintBoundary boundary =
        boundaryKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    final ui.Image image = await boundary.toImage(pixelRatio: 3.0);
    final ByteData? byteData =
        await image.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List pngBytes = byteData!.buffer.asUint8List();

    // Obter o tamanho do widget
    final RenderBox box =
        boundaryKey.currentContext!.findRenderObject() as RenderBox;
    final imageSize = box.size;

    // Adicionar a imagem ao PDF
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Image(
              pw.MemoryImage(pngBytes), // Adicionando imagem como MemoryImage
              width: imageSize.width,
              height: imageSize.height,
            ),
          );
        },
      ),
    );

    // Salvar o PDF ou fazer qualquer outra coisa com ele
    final String dir = (await getApplicationDocumentsDirectory()).path;
    final String path = '$dir/etiqueta_produto.pdf';
    final File file = File(path);
    await file.writeAsBytes(await pdf.save());
    // Compartilhar o PDF usando o Printing
    await Printing.sharePdf(
        bytes: await pdf.save(), filename: 'etiqueta_produto.pdf');

    print('pdf salvo em: $path');
  }
}
