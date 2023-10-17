import 'package:flutter/material.dart';

class ProductWidget extends StatelessWidget {
  final String title;
  final String description;

  ProductWidget({
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                height: 140,
                decoration: BoxDecoration(
                  color: Colors.blue, // Cor de fundo do contêiner
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0.0, 4.0),
                      color: Colors.black.withOpacity(.80),
                      blurRadius: 7,
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 80),
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width / 8,
                            ),
                            width: 100,
                            child: Text(
                              title,
                              style: const TextStyle(
                                fontSize: 20,
                                overflow: TextOverflow.fade,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            margin: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width / 8,
                            ),
                            width: 150,
                            child: Text(
                              description,
                              style: const TextStyle(
                                fontSize: 14,
                                overflow: TextOverflow.fade,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 8, left: 10),
            height: 120,
            width: 110,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0.0, 2.0),
                  color: Colors.black.withOpacity(.80),
                  blurRadius: 7,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Icon(
                Icons.shopping_cart, // Ícone genérico
                size: 80,
                color: Colors.blue,
              ),
            ),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width / 3,
            bottom: 12.5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    // Lógica para editar o produto
                  },
                ),
                IconButton(
                  icon: Icon(Icons.check),
                  onPressed: () {
                    // Lógica para informar colheita
                  },
                ),
                IconButton(
                  icon: Icon(Icons.qr_code),
                  onPressed: () {
                    // Lógica para gerar QR code
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    // Lógica para remover o produto
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
