import 'package:flutter/material.dart';

import './addContacts_screen.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({Key? key}) : super(key: key);

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
    );
  }
}
