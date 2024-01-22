import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:foresty/firestore_activity/models/batch_activity.dart';
import 'package:foresty/firestore_batch/models/batch.dart';

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
