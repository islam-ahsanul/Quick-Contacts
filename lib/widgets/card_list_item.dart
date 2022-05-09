import 'dart:io';
import 'dart:ui' as ui;
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

import 'package:flutter/material.dart';
import '../screens/contacts_detail_screen.dart';

class CardListItem extends StatelessWidget {
  const CardListItem({
    Key? key,
    required this.sentId,
    required this.sentImage,
    required this.sentName,
    required this.sentPhone,
  }) : super(key: key);
  final String sentId;
  final File sentImage;
  final String sentName;
  final String sentPhone;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {
        // add phone call on long press
        launch('tel:$sentPhone');
      },
      onTap: () {
        Navigator.of(context)
            .pushNamed(ContactDetailScreen.routeName, arguments: sentId);
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 4,
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Image.file(
                    sentImage,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    alignment: const Alignment(0.0, -0.2),
                    // alignment: Alignment.center,
                  ),
                ),
                Positioned(
                  bottom: 20,
                  right: 10,
                  child: Container(
                    width: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.black54,
                    ),
                    // color: Colors.black54,
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    child: Text(
                      sentName,
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        fontSize: 26,
                        color: Colors.white,
                        fontFamily: 'Comfortaa',
                        fontWeight: FontWeight.bold,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: ShaderMask(
                      blendMode: BlendMode.srcIn,
                      shaderCallback: (Rect bounds) {
                        return ui.Gradient.linear(
                          const Offset(24.0, 8.0),
                          const Offset(18.0, 24.0),
                          [
                            Colors.amber,
                            ui.Color.fromARGB(255, 238, 143, 0),
                          ],
                        );
                      },
                      child: TextButton.icon(
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.symmetric(vertical: 15.0)),
                          enableFeedback: true,
                          textStyle: MaterialStateProperty.all(
                              const TextStyle(fontSize: 18)),
                        ),
                        icon: const Icon(
                          Icons.info,
                        ),
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                              ContactDetailScreen.routeName,
                              arguments: sentId);
                        },
                        label: const Text(
                          'Details',
                          style: TextStyle(
                            fontFamily: 'SourceSansPro',
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ShaderMask(
                      blendMode: BlendMode.srcIn,
                      shaderCallback: (Rect bounds) {
                        return ui.Gradient.linear(
                          // Offset(24.0, 8.0),
                          // Offset(18.0, 24.0),
                          // [
                          //   Color.fromARGB(255, 5, 26, 130),
                          //   ui.Color.fromARGB(255, 26, 130, 216),
                          // ],
                          const Offset(24.0, 4.0),
                          const Offset(18.0, 24.0),
                          [
                            Color.fromARGB(255, 28, 140, 231),
                            ui.Color.fromARGB(255, 101, 196, 255),
                          ],
                        );
                      },
                      child: TextButton.icon(
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.symmetric(vertical: 15.0)),
                          enableFeedback: true,
                          textStyle: MaterialStateProperty.all(
                              const TextStyle(fontSize: 18)),
                        ),
                        icon: const Icon(
                          Icons.sms_rounded,
                        ),
                        onPressed: () {
                          launch('sms:$sentPhone');
                        },
                        label: const Text(
                          'Text',
                          style: TextStyle(
                            fontFamily: 'SourceSansPro',
                          ),
                        ),
                      ),
                    ),
                  ),
                  // SizedBox(width: 6),
                  Expanded(
                    child: ShaderMask(
                      blendMode: BlendMode.srcIn,
                      shaderCallback: (Rect bounds) {
                        return ui.Gradient.linear(
                          const Offset(18.0, 24.0),
                          const Offset(24.0, 4.0),
                          [
                            Colors.greenAccent,
                            Colors.green,
                          ],
                        );
                      },
                      child: TextButton.icon(
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.symmetric(vertical: 15.0)),
                          enableFeedback: true,
                          textStyle: MaterialStateProperty.all(
                              TextStyle(fontSize: 18)),
                        ),
                        icon: const Icon(
                          Icons.call_rounded,
                        ),
                        onPressed: () async {
                          await FlutterPhoneDirectCaller.callNumber(sentPhone);
                        },
                        label: const Text(
                          'Call',
                          style: TextStyle(
                            fontFamily: 'SourceSansPro',
                          ),
                        ),
                      ),
                    ),
                  ),
                  // SizedBox(width: 6),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
