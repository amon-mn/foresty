import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class TagWidget extends StatelessWidget {
  final String? title;
  final String? subtitle;
  static const String urlQrCode =
      'https://forest-traceability.web.app/?userId=';
  static const String urlBatchId = '&batchId=';
  final String dataQrCode;

  final VoidCallback? onLongPress;
  final VoidCallback? onTap;
  final String? batchId;

  TagWidget({
    required this.title,
    this.subtitle,
    this.onLongPress,
    this.onTap,
    required this.batchId,
    required this.dataQrCode,
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
                          mainAxisAlignment: MainAxisAlignment
                              .center, // Alterado para centralizar verticalmente
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                left: screenWidth / 8,
                              ),
                              width: screenWidth * 0.7 - screenWidth * 0.04,
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
                color: Colors.white,
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
                child: QrImageView(
                  data: '$urlQrCode$dataQrCode$urlBatchId$batchId',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
