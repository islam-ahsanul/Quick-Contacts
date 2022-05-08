import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:provider/provider.dart';
import 'package:flutter_scrolling_fab_animated/flutter_scrolling_fab_animated.dart';

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
        icon: Icon(
          Icons.add,
          color: Color.fromARGB(255, 6, 18, 82),
        ),
        text: Text(
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
        duration: Duration(milliseconds: 200),
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
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Consumer<ContactsProvider>(
                  child: Center(
                    child: Text('No contacts yet'),
                  ),
                  builder: (ctx, contactsProvider, ch) =>
                      contactsProvider.items.length <= 0
                          ? Center(
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
                                leading: Image.file(
                                  contactsProvider.items[i].image,
                                ),
                                title: Text(
                                  contactsProvider.items[i].name,
                                  softWrap: true,
                                  style: TextStyle(
                                    fontFamily: 'SourceSansPro',
                                    // fontWeight: FontWeight.bold,
                                    fontSize: 19,
                                  ),
                                ),
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                      ContactDetailScreen.routeName,
                                      arguments: contactsProvider.items[i].id);
                                },
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.sms_rounded,
                                        color: Color.fromARGB(255, 8, 25, 120),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.call,
                                        color: Color.fromARGB(255, 14, 154, 19),
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
