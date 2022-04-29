import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/contacts_provider.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Provider.of<ContactsProvider>(context, listen: false)
            .fetchAndSetContacts(),
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
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
                        if (contactsProvider.items[i].isFavorite == 1) {
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundImage:
                                  FileImage(contactsProvider.items[i].image),
                            ),
                            title: Text(contactsProvider.items[i].name),
                            onTap: () {
                              // .....
                            },
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
