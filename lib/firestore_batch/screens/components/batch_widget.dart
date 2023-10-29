import 'package:flutter/material.dart';

class BatchWidget extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final VoidCallback? onEditPressed;
  final VoidCallback? onDeletePressed;
  final VoidCallback? onLongPress; // Novo parâmetro
  final VoidCallback? onTap; // Novo parâmetro

  BatchWidget({
    required this.title,
    this.subtitle,
    this.onEditPressed,
    this.onDeletePressed,
    this.onLongPress, // Novo parâmetro
    this.onTap, // Novo parâmetro
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onLongPress: onLongPress, // Atribui o onLongPress
      onTap: onTap, // Atribui o onTap
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: 120,
                  width: screenWidth,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 0, 90, 3),
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0.0, 4.0),
                        color: Colors.black.withOpacity(.3),
                        blurRadius: 7,
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                            left: 80, top: 2, bottom: 2, right: 2),
                        width: screenWidth,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width / 8,
                                top: 10,
                              ),
                              width: 200,
                              child: Text(
                                title ?? '',
                                style: const TextStyle(
                                  fontSize: 20,
                                  overflow: TextOverflow.fade,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width / 8,
                              ),
                              width: 200,
                              child: Text(
                                subtitle ?? '',
                                style: const TextStyle(
                                  fontSize: 16,
                                  overflow: TextOverflow.fade,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 10, left: 10),
              height: 100,
              width: 100,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0.0, 0.1),
                    color: Colors.black.withOpacity(0.4),
                    blurRadius: 7,
                  ),
                ],
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: Image.asset(
                  'lib/assets/plantararvore.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              left: MediaQuery.of(context).size.width / 3,
              bottom: 5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (onEditPressed != null)
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: onEditPressed,
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
                  if (onDeletePressed != null)
                    IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Color.fromARGB(255, 217, 0, 0),
                      ),
                      onPressed: onDeletePressed,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
