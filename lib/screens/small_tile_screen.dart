import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:provider/provider.dart';
import 'package:flutter_scrolling_fab_animated/flutter_scrolling_fab_animated.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

import './addContacts_screen.dart';
import '../providers/contacts_provider.dart';
import './contacts_detail_screen.dart';

class SmallTileScreen extends StatefulWidget {
  const SmallTileScreen({Key? key}) : super(key: key);

  @override
  State<SmallTileScreen> createState() => _SmallTileScreenState();
}

class _SmallTileScreenState extends State<SmallTileScreen> {
  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ScrollingFabAnimated(
        elevation: 25,
        color: Colors.white,
        icon: const Icon(
          Icons.add,
          color: Color.fromARGB(255, 6, 18, 82),
        ),
        text: const Text(
          'Add Contact',
          style:
              TextStyle(color: Color.fromARGB(255, 6, 18, 82), fontSize: 15.0),
        ),
        onPress: () {
          Navigator.of(context).pushNamed(AddContactScreen.routeName);
        },
        scrollController: _scrollController,
        animateIcon: true,
        curve: Curves.easeOut,
        radius: 15,
        // inverted: true,
        duration: const Duration(milliseconds: 200),
        width: 150,
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return Navigator.of(context).pushReplacementNamed('/');
        },
        child: FutureBuilder(
          future: Provider.of<ContactsProvider>(context, listen: false)
              .fetchAndSetContacts(),
          builder: (ctx, snapshot) => snapshot.connectionState ==
                  ConnectionState.waiting
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Consumer<ContactsProvider>(
                  child: const Center(
                    child: Text('No contacts yet'),
                  ),
                  builder: (ctx, contactsProvider, ch) => contactsProvider
                              .items.length <=
                          0
                      ? const Center(
                          child: Text(
                            'No contacts yet',
                            style: TextStyle(
                              fontSize: 25,
                            ),
                          ),
                        )
                      : ListView.builder(
                          controller: _scrollController,
                          itemCount: contactsProvider.items.length,
                          itemBuilder: (ctx, i) => ListTile(
                            shape: const BorderDirectional(
                              bottom: BorderSide(
                                  color: Color.fromARGB(31, 189, 188, 188),
                                  width: 0.5),
                            ),
                            leading: CircleAvatar(
                              backgroundImage: FileImage(
                                contactsProvider.items[i].image,
                              ),
                              backgroundColor:
                                  // Color.fromARGB(255, 255, 217, 219),
                                  Color.fromARGB(31, 189, 188, 188),
                            ),
                            title: Text(
                              contactsProvider.items[i].name,
                              softWrap: true,
                              style: const TextStyle(
                                fontFamily: 'SourceSansPro',
                                // fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                  ContactDetailScreen.routeName,
                                  arguments: contactsProvider.items[i].id);
                            },
                            onLongPress: () {
                              launch('tel:${contactsProvider.items[i].phone}');
                            },
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ShaderMask(
                                  blendMode: BlendMode.srcIn,
                                  shaderCallback: (Rect bounds) {
                                    return ui.Gradient.linear(
                                      Offset(24.0, 4.0),
                                      Offset(18.0, 24.0),
                                      [
                                        Color.fromARGB(255, 28, 140, 231),
                                        ui.Color.fromARGB(255, 101, 196, 255),
                                      ],
                                    );
                                  },
                                  child: IconButton(
                                    onPressed: () {
                                      launch(
                                          'sms:${contactsProvider.items[i].phone}');
                                    },
                                    icon: Icon(
                                      Icons.sms_rounded,
                                      color: Color.fromARGB(255, 8, 25, 120),
                                    ),
                                  ),
                                ),
                                ShaderMask(
                                  blendMode: BlendMode.srcIn,
                                  shaderCallback: (Rect bounds) {
                                    return ui.Gradient.linear(
                                      Offset(24.0, 4.0),
                                      Offset(10.0, 24.0),
                                      [
                                        ui.Color.fromARGB(255, 179, 255, 93),
                                        ui.Color.fromARGB(255, 43, 179, 47),
                                      ],
                                    );
                                  },
                                  child: IconButton(
                                    onPressed: () async {
                                      await FlutterPhoneDirectCaller.callNumber(
                                          contactsProvider.items[i].phone);
                                    },
                                    icon: Icon(
                                      Icons.call_rounded,
                                      color: Color.fromARGB(255, 14, 154, 19),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                ),
        ),
      ),
    );
  }
}
