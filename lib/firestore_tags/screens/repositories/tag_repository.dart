import 'package:flutter/material.dart';
import 'package:foresty/firestore_tags/screens/components/tag_widget.dart';

class TagsRepository extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Minhas Etiquetas'),
      ),
      body: ListView(
        children: [
          TagWidget(
            dataQrCode: 'RASTECH',
            title: 'Lote 1',
            subtitle: 'Descrição do Lote 1',
            batchId: '1',
            onTap: () {
              // Implemente o que deseja fazer ao tocar neste widget
            },
            onLongPress: () {
              // Implemente o que deseja fazer ao pressionar este widget por um longo tempo
            },
          ),
          TagWidget(
            dataQrCode: 'RASTECH',
            title: 'Lote 2',
            subtitle: 'Descrição do Lote 2',
            batchId: '2',
            onTap: () {
              // Implemente o que deseja fazer ao tocar neste widget
            },
            onLongPress: () {
              // Implemente o que deseja fazer ao pressionar este widget por um longo tempo
            },
          ),
          TagWidget(
            dataQrCode: 'RASTECH',
            title: 'Lote 3',
            subtitle: 'Descrição do Lote 3',
            batchId: '3',
            onTap: () {
              // Implemente o que deseja fazer ao tocar neste widget
            },
            onLongPress: () {
              // Implemente o que deseja fazer ao pressionar este widget por um longo tempo
            },
          ),
        ],
      ),
    );
  }
}
