import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './addContacts_screen.dart';
import '../providers/contacts_provider.dart';

class ContactListScreen extends StatelessWidget {
  const ContactListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts Screen'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AddContactScreen.routeName);
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
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
                builder: (ctx, contactsProvider, ch) =>
                    contactsProvider.items.length <= 0
                        ? Text('No contacts yet')
                        : ListView.builder(
                            itemCount: contactsProvider.items.length,
                            itemBuilder: (ctx, i) => ListTile(
                              leading: CircleAvatar(
                                backgroundImage:
                                    FileImage(contactsProvider.items[i].image),
                              ),
                              title: Text(contactsProvider.items[i].name),
                              onTap: () {
                                // go to detail screen
                              },
                            ),
                          ),
              ),
      ),
    );
  }
}
