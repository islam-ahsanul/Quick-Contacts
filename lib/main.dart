import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/contacts_screen.dart';
import './providers/contacts_provider.dart';
import './screens/addContacts_screen.dart';

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
        home: ContactScreen(),
        routes: {
          AddContactScreen.routeName: (ctx) => AddContactScreen(),
        },
      ),
    );
  }
}
