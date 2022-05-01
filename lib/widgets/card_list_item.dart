import 'dart:io';

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
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Image.file(
                    sentImage,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 20,
                  right: 10,
                  child: Container(
                    width: 300,
                    color: Colors.black54,
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    child: Text(
                      sentName,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 26,
                        color: Colors.white,
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
                    child: TextButton.icon(
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(vertical: 15.0)),
                        enableFeedback: true,
                        textStyle:
                            MaterialStateProperty.all(TextStyle(fontSize: 18)),
                      ),
                      icon: Icon(
                        Icons.info_outline_rounded,
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                            ContactDetailScreen.routeName,
                            arguments: sentId);
                      },
                      label: Text(
                        'Details',
                      ),
                    ),
                  ),
                  // SizedBox(width: 6),
                  Expanded(
                    child: TextButton.icon(
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(vertical: 15.0)),
                        enableFeedback: true,
                        textStyle:
                            MaterialStateProperty.all(TextStyle(fontSize: 18)),
                      ),
                      icon: Icon(
                        Icons.call_rounded,
                      ),
                      onPressed: () {},
                      label: Text('Call'),
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
