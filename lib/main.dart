import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import './providers/contacts_provider.dart';
import './screens/addContacts_screen.dart';
import './screens/contacts_detail_screen.dart';
import './screens/tabs_screen.dart';
import './screens/edit_screen.dart';
import './screens/help_screen.dart';
import './screens/about_screen.dart';
import './helpers/custom_route.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.removeAfter(initialization);

  runApp(const MyApp());
}

Future initialization(BuildContext? context) async {
  await Future.delayed(const Duration(seconds: 1));
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
          pageTransitionsTheme: PageTransitionsTheme(builders: {
            TargetPlatform.android: CustomPageTransitionBuilder(),
            TargetPlatform.iOS: CustomPageTransitionBuilder(),
          }),
        ),
        // home: TabScreen(),
        routes: {
          '/': (ctx) => const TabScreen(),
          AddContactScreen.routeName: (ctx) => const AddContactScreen(),
          ContactDetailScreen.routeName: (ctx) => const ContactDetailScreen(),
          EditScreen.routeName: (ctx) => const EditScreen(),
          HelpScreen.routeName: (ctx) => const HelpScreen(),
          AboutScreen.routeName: (ctx) => const AboutScreen(),
        },
      ),
    );
  }
}
