import 'package:flutter/material.dart';
import 'package:foresty/firestore_activity/screens/activity_form_page.dart';
import 'package:foresty/firestore_batch/services/batch_service.dart';

class BatchWidget extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final String? activity;
  final VoidCallback? onEditPressed;
  final VoidCallback? onCreateActivityPressed;
  final VoidCallback? onHarvestPressed;
  final VoidCallback? onDeletePressed;
  final VoidCallback? onLongPress;
  final VoidCallback? onTap;
  final String? batchId;

  BatchWidget({
    required this.title,
    this.subtitle,
    this.activity,
    this.onEditPressed,
    this.onCreateActivityPressed,
    this.onDeletePressed,
    this.onHarvestPressed,
    this.onLongPress,
    this.onTap,
    this.batchId,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onLongPress: onLongPress,
      onTap: onTap,
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
                          left: 80,
                          top: 2,
                          bottom: 2,
                          right: 2,
                        ),
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
                                left: screenWidth / 8,
                                top: 10,
                              ),
                              width: screenWidth * 0.7 - screenWidth * 0.04,
                              child: Row(
                                children: [
                                  Flexible(
                                    child: Text(
                                      title ?? '',
                                      style: const TextStyle(
                                        fontSize: 20,
                                        overflow: TextOverflow.fade,
                                      ),
                                    ),
                                  ),
                                  const Text(
                                    ' - ',
                                    style: TextStyle(
                                      fontSize:
                                          16, // Pode ajustar o tamanho conforme necessário
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      activity ?? '',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        overflow: TextOverflow
                                            .ellipsis, // Adiciona '...' se o texto for muito longo
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                left: screenWidth / 8,
                              ),
                              width: screenWidth * 0.5,
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
              left: screenWidth / 3,
              bottom: 5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: onEditPressed,
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: onCreateActivityPressed,
                  ),
                  IconButton(
                    icon: Icon(Icons.check),
                    onPressed: onHarvestPressed,
                  ),
                  IconButton(
                    icon: Icon(Icons.qr_code),
                    onPressed: () {
                      // Lógica para gerar QR code
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Color.fromARGB(255, 217, 0, 0),
                    ),
                    onPressed: () async {
                      if (batchId != null) {
                        await BatchService().removeBatch(batchId: batchId!);
                      }
                    },
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
