import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({Key? key}) : super(key: key);
  static const routeName = '/help';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        title: Text(
          'Help',
          style: TextStyle(
            fontFamily: 'MPLUSRounded',
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        child: Text('''
          - This app stores contacts only on this device to ensure security. 
           If you uninstall this app all contacts saved in this app will be deleted as well. 
          - Adding, Editing, Deleting contacts does not effect your phone's default contacts app data.  
          second line, 
          third line'''),
      ),
    );
  }
}
