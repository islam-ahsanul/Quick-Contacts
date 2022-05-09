import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_scrolling_fab_animated/flutter_scrolling_fab_animated.dart';

import './addContacts_screen.dart';
import '../providers/contacts_provider.dart';
import '../widgets/card_list_item.dart';

class ContactListScreen extends StatefulWidget {
  const ContactListScreen({Key? key}) : super(key: key);

  @override
  State<ContactListScreen> createState() => _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListScreen> {
  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton.extended(
      //   elevation: 5,
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.circular(10),
      //   ),
      //   onPressed: () {
      //     Navigator.of(context).pushNamed(AddContactScreen.routeName);
      //   },
      //   icon: Icon(Icons.add),
      //   label: const Text('Add Contact'),
      // ),
// -------------------------------------
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
        duration: Duration(milliseconds: 200),
        width: 150,
      ),

      // appBar: AppBar(
      //   title: Text('Contacts Screen'),
      //   actions: [
      //     IconButton(
      //       onPressed: () {
      //         Navigator.of(context).pushNamed(AddContactScreen.routeName);
      //       },
      //       icon: Icon(Icons.add),
      //     ),
      //   ],
      // ),
      body: RefreshIndicator(
        onRefresh: () {
          return Navigator.of(context).pushReplacementNamed('/');
        },
        child: FutureBuilder(
          future: Provider.of<ContactsProvider>(context, listen: false)
              .fetchAndSetContacts(),
          builder: (ctx, snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Consumer<ContactsProvider>(
                      child: const Center(
                        child: Text('No contacts yet'),
                      ),
                      builder: (ctx, contactsProvider, ch) =>
                          contactsProvider.items.length <= 0
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
                                  itemBuilder: (ctx, i) => CardListItem(
                                    sentId: contactsProvider.items[i].id,
                                    sentImage: contactsProvider.items[i].image,
                                    sentName: contactsProvider.items[i].name,
                                    sentPhone: contactsProvider.items[i].phone,
                                  ),
                                  // ListTile(
                                  //   leading: CircleAvatar(
                                  //     backgroundImage:
                                  //         FileImage(contactsProvider.items[i].image),
                                  //   ),
                                  //   title: Text(contactsProvider.items[i].name),
                                  //   onTap: () {
                                  //     // go to detail screen
                                  //     Navigator.of(context).pushNamed(
                                  //         ContactDetailScreen.routeName,
                                  //         arguments: contactsProvider.items[i].id);
                                  //   },
                                  // ),
                                ),
                    ),
        ),
      ),
    );
  }
}
