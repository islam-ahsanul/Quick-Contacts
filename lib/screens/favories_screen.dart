import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:ui' as ui;

import '../providers/contacts_provider.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Provider.of<ContactsProvider>(context, listen: false)
            .fetchAndSetContacts(),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<ContactsProvider>(
                child: const Center(
                  child: Text('No contacts yet'),
                ),
                builder: (ctx, contactsProvider, ch) => ListView.builder(
                  itemCount: contactsProvider.items.length,
                  itemBuilder: (ctx, i) {
                    // if (contactsProvider.items[i].isFavorite == 1) {
                    //   return ListTile(
                    //     leading: CircleAvatar(
                    //       backgroundImage:
                    //           FileImage(contactsProvider.items[i].image),
                    //     ),
                    //     title: Text(contactsProvider.items[i].name),
                    //     onTap: () {
                    //       // .....
                    //     },
                    //   );
                    // }
                    // return Container();
                    if (contactsProvider.items[i].isFavorite == 1) {
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                bottomLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              ),
                              child: Image.file(
                                contactsProvider.items[i].image,
                                fit: BoxFit.cover,
                                height: 120,
                                width: 110,
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    contactsProvider.items[i].name,
                                    softWrap: true,
                                    style: TextStyle(
                                      fontSize: 25,
                                    ),
                                  ),
                                  IntrinsicHeight(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: ShaderMask(
                                            blendMode: BlendMode.srcIn,
                                            shaderCallback: (Rect bounds) {
                                              return ui.Gradient.linear(
                                                Offset(24.0, 24.0),
                                                Offset(15.0, 24.0),
                                                [
                                                  Colors.greenAccent,
                                                  Colors.green,
                                                ],
                                              );
                                            },
                                            child: TextButton.icon(
                                              onPressed: () {},
                                              icon: Icon(Icons.call),
                                              label: Text('Call'),
                                            ),
                                          ),
                                        ),
                                        VerticalDivider(
                                          thickness: 5,
                                        ),
                                        Expanded(
                                          child: ShaderMask(
                                            blendMode: BlendMode.srcIn,
                                            shaderCallback: (Rect bounds) {
                                              return ui.Gradient.linear(
                                                Offset(24.0, 4.0),
                                                Offset(18.0, 24.0),
                                                [
                                                  Color.fromARGB(
                                                      255, 5, 26, 130),
                                                  Colors.cyan,
                                                ],
                                              );
                                            },
                                            child: TextButton.icon(
                                              onPressed: () {},
                                              icon: Icon(Icons.sms_rounded),
                                              label: Text('Text'),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    return Container();
                  },
                ),
              ),
      ),
    );
  }
}
