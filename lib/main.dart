import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/contacts_list_screen.dart';
import './providers/contacts_provider.dart';
import './screens/addContacts_screen.dart';
import './screens/contacts_detail_screen.dart';
import './screens/tabs_screen.dart';
import './screens/edit_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: ContactsProvider(),
      child: MaterialApp(
        title: 'Family Contact Book',
        theme: ThemeData(
          fontFamily: 'SourceSansPro',
          primarySwatch: Colors.indigo,
          primaryColor: Colors.white,
          // accentColor: Colors.amber,
          canvasColor: Colors.white,
          // floatingActionButtonTheme: FloatingActionButtonThemeData(
          //   foregroundColor: Color.fromARGB(255, 6, 18, 82),
          //   backgroundColor: Colors.white,
          // ),
        ),
        // home: TabScreen(),
        routes: {
          '/': (ctx) => TabScreen(),
          AddContactScreen.routeName: (ctx) => AddContactScreen(),
          ContactDetailScreen.routeName: (ctx) => ContactDetailScreen(),
          EditScreen.routeName: (ctx) => EditScreen(),
        },
      ),
    );
  }
}
