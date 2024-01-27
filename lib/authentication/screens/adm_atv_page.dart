import 'package:flutter/material.dart';

class AdmAtvPage extends StatelessWidget {
  final Map<String, dynamic> lote;

  const AdmAtvPage({Key? key, required this.lote}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes da Atividade'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (var entry in lote.entries) 
              if (entry.value != "" && entry.value != "0" && entry.value != null)
                Text('${entry.key}: ${entry.value}'),
          ],
        ),
      ),
    );
  }
}
