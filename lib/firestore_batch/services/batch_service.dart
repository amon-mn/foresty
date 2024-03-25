import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:foresty/firestore_activity/models/batch_activity.dart';
import 'package:foresty/firestore_batch/models/batch.dart';
import 'package:foresty/firestore_harvest/models/harvest.dart';
import 'package:foresty/firestore_qr_codes/models/qrCode.dart';

class BatchService {
  String user_id = FirebaseAuth.instance.currentUser!.uid;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addBatch({required ProductBatch batch}) async {
    return firestore
        .collection('users')
        .doc(user_id)
        .collection('lotes')
        .doc(batch.id)
        .set(batch.toMap());
  }

  Future<ProductBatch> addBatchActivity(
      {required ProductBatch batch,
      required BatchActivity batchActivity}) async {
    // Adicione a atividade à lista de atividades no lote
    batch.addActivity(batchActivity);

    // Atualize o lote no banco de dados
    await firestore
        .collection('users')
        .doc(user_id)
        .collection('lotes')
        .doc(batch.id)
        .set(batch.toMap());

    // Retorne o lote atualizado
    return batch;
  }

  Future<ProductBatch> addHarvest(
      {required ProductBatch batch, required Harvest harvest}) async {
    // Adiciona as informações de colheita ao lote
    batch.addHarvest(harvest);
    // Atualiza o lote no banco de dados
    await firestore
        .collection('users')
        .doc(user_id)
        .collection('lotes')
        .doc(batch.id)
        .set(batch.toMap());

    // Retorna o lote atualizado
    return batch;
  }

  Future<ProductBatch> addQrCode(
      {required ProductBatch batch, required BatchQrCode batchQrCode}) async {
    // Adiciona as informações de colheita ao lote
    batch.addQrCode(batchQrCode);
    // Atualiza o lote no banco de dados
    await firestore
        .collection('users')
        .doc(user_id)
        .collection('lotes')
        .doc(batch.id)
        .set(batch.toMap());

    // Retorna o lote atualizado
    return batch;
  }

  Future<List<ProductBatch>> readBatchs() async {
    List<ProductBatch> temp = [];

    QuerySnapshot<Map<String, dynamic>> snapshot = await firestore
        .collection('users')
        .doc(user_id)
        .collection('lotes')
        .get();

    for (var doc in snapshot.docs) {
      temp.add(ProductBatch.fromMap(doc.data()));
    }

    return temp;
  }

  Future<void> removeBatch({required String batchId}) async {
    return firestore
        .collection('users')
        .doc(user_id)
        .collection('lotes')
        .doc(batchId)
        .delete();
  }
}
