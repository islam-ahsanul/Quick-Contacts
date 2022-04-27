import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/contacts_list_screen.dart';
import './providers/contacts_provider.dart';
import './screens/addContacts_screen.dart';
import './screens/contacts_detail_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: ContactsProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ContactListScreen(),
        routes: {
          AddContactScreen.routeName: (ctx) => AddContactScreen(),
          ContactDetailScreen.routeName: (ctx) => ContactDetailScreen(),
        },
      ),
    );
  }
}
