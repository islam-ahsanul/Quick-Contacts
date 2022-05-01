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
                                  Text(contactsProvider.items[i].name),
                                  IntrinsicHeight(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: TextButton.icon(
                                            onPressed: () {},
                                            icon: Icon(Icons.call),
                                            label: Text('Call'),
                                          ),
                                        ),
                                        VerticalDivider(
                                          thickness: 5,
                                        ),
                                        Expanded(
                                          child: TextButton.icon(
                                            onPressed: () {},
                                            icon: Icon(Icons.sms_rounded),
                                            label: Text('Text'),
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
