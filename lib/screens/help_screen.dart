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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: ListView(
            children: [
              Text(
                'To ensure security, this app stores contacts only on this device. If you uninstall this app, all contacts stored in this app will be lost.',
                style: TextStyle(
                  fontFamily: 'RobotoMono',
                  fontSize: 13,
                ),
              ),
              Divider(),
              Text(
                'This app has no impact on the data in your phone\'s default contacts app when you add, edit, or delete contacts.',
                style: TextStyle(
                  fontFamily: 'RobotoMono',
                  fontSize: 13,
                ),
              ),
              Divider(),
              Text(
                'Long-press on the contact image to make an indirect phone call.',
                style: TextStyle(
                  fontFamily: 'RobotoMono',
                  fontSize: 13,
                ),
              ),
              Divider(),
              Text(
                'Please refresh to see the updated list after deleting a contact.',
                style: TextStyle(
                  fontFamily: 'RobotoMono',
                  fontSize: 13,
                ),
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
