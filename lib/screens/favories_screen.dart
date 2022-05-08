import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:ui' as ui;
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

import './contacts_detail_screen.dart';
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
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 3.0),
                        child: Card(
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                onLongPress: () {
                                  launch(
                                      'tel:${contactsProvider.items[i].phone}');
                                },
                                child: ClipRRect(
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
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.of(context).pushNamed(
                                            ContactDetailScreen.routeName,
                                            arguments:
                                                contactsProvider.items[i].id);
                                      },
                                      borderRadius: BorderRadius.circular(20),
                                      child: Container(
                                        height: 65,
                                        alignment: Alignment.center,
                                        width: double.infinity,
                                        child: SingleChildScrollView(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              contactsProvider.items[i].name,
                                              // softWrap: true,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 19,
                                                // fontFamily: 'Roboto',
                                                // fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    IntrinsicHeight(
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 0, 0, 5),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: ShaderMask(
                                                blendMode: BlendMode.srcIn,
                                                shaderCallback: (Rect bounds) {
                                                  return ui.Gradient.linear(
                                                    Offset(18.0, 24.0),
                                                    Offset(24.0, 4.0),
                                                    [
                                                      Colors.greenAccent,
                                                      Color.fromARGB(
                                                          255, 35, 204, 41),
                                                    ],
                                                  );
                                                },
                                                child: TextButton.icon(
                                                  onPressed: () async {
                                                    await FlutterPhoneDirectCaller
                                                        .callNumber(
                                                            contactsProvider
                                                                .items[i]
                                                                .phone);
                                                  },
                                                  icon: Icon(
                                                    Icons.call_rounded,
                                                    size: 23,
                                                  ),
                                                  label: Text(
                                                    'Call',
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                      // fontWeight: FontWeight.bold,
                                                      fontFamily:
                                                          'MPLUSRounded',
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            VerticalDivider(
                                              thickness: 1,
                                            ),
                                            Expanded(
                                              child: ShaderMask(
                                                blendMode: BlendMode.srcIn,
                                                shaderCallback: (Rect bounds) {
                                                  return ui.Gradient.linear(
                                                    // Offset(24.0, 4.0),
                                                    // Offset(18.0, 24.0),
                                                    // [
                                                    //   Color.fromARGB(
                                                    //       255, 5, 26, 130),
                                                    //   Color.fromARGB(
                                                    //       255, 71, 150, 215),
                                                    // ],
                                                    Offset(24.0, 4.0),
                                                    Offset(18.0, 24.0),
                                                    [
                                                      Color.fromARGB(
                                                          255, 65, 182, 255),
                                                      Color.fromARGB(
                                                          255, 28, 140, 231),
                                                    ],
                                                  );
                                                },
                                                child: TextButton.icon(
                                                  onPressed: () {
                                                    launch(
                                                        'sms:${contactsProvider.items[i].phone}');
                                                  },
                                                  icon: Icon(
                                                    Icons.sms_rounded,
                                                    size: 23,
                                                  ),
                                                  label: Text(
                                                    'Text',
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                      // fontWeight: FontWeight.bold,
                                                      fontFamily:
                                                          'MPLUSRounded',
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
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
