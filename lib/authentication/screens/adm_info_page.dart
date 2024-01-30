import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foresty/authentication/screens/adm_atv_page.dart';

class AdmInfoPage extends StatelessWidget {
  final String userId;

  const AdmInfoPage({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance.collection('users').doc(userId).get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text('Lotes - Carregando...');
            }

            if (snapshot.hasError) {
              return Text('Lotes - Erro: ${snapshot.error}');
            }

            // Processar dados do usuário
            Map<String, dynamic> userData = snapshot.data!.data() as Map<String, dynamic>;
            String name = userData['name'];

            return Text('Lotes - $name', style: TextStyle(color: Colors.white));
          },
        ),
        backgroundColor: Color.fromARGB(255, 0, 90, 3),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('users').doc(userId).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          }

          // Processar dados do usuário
          Map<String, dynamic> userData = snapshot.data!.data() as Map<String, dynamic>;
          String name = userData['name'];
          String cpf = userData['cpf'];

          // Obtendo o ID do usuário
          String userId = snapshot.data!.id;

          // Acessar a coleção 'lotes' dentro do usuário usando o ID do usuário
          CollectionReference lotesCollection = FirebaseFirestore.instance.collection('users').doc(userId).collection('lotes');

          return StreamBuilder<QuerySnapshot>(
            stream: lotesCollection.snapshots(),
            builder: (context, lotesSnapshot) {
              if (lotesSnapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              if (lotesSnapshot.hasError) {
                return Center(child: Text('Erro ao carregar lotes: ${lotesSnapshot.error}'));
              }

              List<Widget> widgets = [
                SizedBox(height: 20),
                Text('Nome: $name', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey[900])),
                Text('CPF: $cpf', style: TextStyle(fontSize: 16, color: Colors.grey[900])),
                SizedBox(height: 20),
              ];

              // Exibir informações da coleção 'lotes'
              if (lotesSnapshot.data!.docs.isNotEmpty) {
                for (var loteDoc in lotesSnapshot.data!.docs) {
                  Map<String, dynamic> lote = loteDoc.data() as Map<String, dynamic>;
                  String idLote = lote['id'];
                  widgets.addAll([
                    InkWell(
                      onTap: () {
                        // Navegar para AdmAtvPage ao clicar no lote
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AdmAtvPage(lote: lote),
                          ),
                        );
                      },
                      child: Card(
                        elevation: 2,
                        color: Colors.grey[200],
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('ID do Lote: $idLote', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey[900])),
                              Text('Finalidade: ${lote['finalidade'] == "Outro (Especificar)" ? lote['outraFinalidade'] : lote['finalidade']}', style: TextStyle(fontSize: 16, color: Colors.grey[900])),
                              Text('Nome do Lote: ${lote['nomeLote']}', style: TextStyle(fontSize: 16, color: Colors.grey[900])),
                              Text('Nome do Produto: ${lote['nomeProduto']}', style: TextStyle(fontSize: 16, color: Colors.grey[900])),
                              Text('Tipo de Cultivo: ${lote['tipoCultivo'] == "Outro (Especificar)" ? lote['outroTipoCultivo'] : lote['tipoCultivo']}', style: TextStyle(fontSize: 16, color: Colors.grey[900])),
                              Text('Ambiente: ${lote['ambiente'] == "Outro (Especificar)" ? lote['outroAmbiente'] : lote['ambiente']}', style: TextStyle(fontSize: 16, color: Colors.grey[900])),
                              Text('Área: ${lote['area']}', style: TextStyle(fontSize: 16, color: Colors.grey[900])),
                              Text('Comprimento: ${lote['comprimento']}', style: TextStyle(fontSize: 16, color: Colors.grey[900])),
                              Text('Largura: ${lote['largura']}', style: TextStyle(fontSize: 16, color: Colors.grey[900])),
                              Text('Latitude: ${lote['latitude']}', style: TextStyle(fontSize: 16, color: Colors.grey[900])),
                              Text('Longitude: ${lote['longitude']}', style: TextStyle(fontSize: 16, color: Colors.grey[900])),
                              _buildAtividadesWidgets(lote['atividades']),
                              // Add other fields as needed
                            ],
                          ),
                        ),
                      ),
                    ),
                  ]);
                }
              } else {
                widgets.add(Text('Sem lotes cadastrados', style: TextStyle(fontSize: 16, color: Colors.grey[900])));
              }

              return SingleChildScrollView(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: widgets,
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildAtividadesWidgets(List<dynamic> atividades) {
    List<Widget> widgets = [];

    if (atividades != null && atividades.isNotEmpty) {
      // Obter o último item da lista de atividades
      var ultimaAtividade = atividades.last;

      // Extrair as informações da última atividade
      String tipoAtividade = ultimaAtividade['tipoAtividade'] as String? ?? 'Tipo de Atividade Indisponível';

      widgets.add(
        Text('Última Atividade: $tipoAtividade', style: TextStyle(fontSize: 16, color: Colors.grey[900])),
      );
    } else {
      widgets.add(Text('Sem atividades cadastradas', style: TextStyle(fontSize: 16, color: Colors.grey[900])));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }
}
