import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

import '../providers/contacts_provider.dart';

import './edit_screen.dart';

class ContactDetailScreen extends StatefulWidget {
  const ContactDetailScreen({Key? key}) : super(key: key);

  static const routeName = '/contact-detail';

  @override
  State<ContactDetailScreen> createState() => _ContactDetailScreenState();
}

class _ContactDetailScreenState extends State<ContactDetailScreen> {
  void _deleteContact(String id) async {
    Provider.of<ContactsProvider>(context, listen: false).deleteContact(id);
    Navigator.of(context).pop();
  }

  void _updateContact(
    String id,
    String name,
    File img,
    String phone,
    String email,
    String address,
    String bd,
    String note,
    int isFav,
  ) async {
    Provider.of<ContactsProvider>(context, listen: false).updateContact(
      id,
      name,
      img,
      phone,
      email,
      address,
      bd,
      note,
      isFav,
    );
    Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)?.settings.arguments.toString();
    final selectedContact =
        Provider.of<ContactsProvider>(context).findById(id!);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            // forceElevated: true,
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            // shape: RoundedRectangleBorder(
            //   borderRadius: BorderRadius.vertical(
            //     bottom: Radius.circular(20),
            //   ),
            // ),

            elevation: 0,
            // shadowColor: Colors.white,
            collapsedHeight: 130,
            actions: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.white30,
                  child: IconButton(
                    enableFeedback: true,
                    splashColor: Colors.red,
                    color: Colors.black,
                    onPressed: () {
                      Navigator.of(context).pushNamed(EditScreen.routeName,
                          arguments: selectedContact.id);
                    },
                    icon: Icon(Icons.edit),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.white30,
                  child: IconButton(
                    enableFeedback: true,
                    splashColor: Colors.red,
                    color: Colors.black,
                    onPressed: () {
                      if (selectedContact.isFavorite == 0) {
                        _updateContact(
                            selectedContact.id,
                            selectedContact.name,
                            selectedContact.image,
                            selectedContact.phone,
                            selectedContact.email,
                            selectedContact.address,
                            selectedContact.birthday,
                            selectedContact.note,
                            1);
                      } else {
                        _updateContact(
                            selectedContact.id,
                            selectedContact.name,
                            selectedContact.image,
                            selectedContact.phone,
                            selectedContact.email,
                            selectedContact.address,
                            selectedContact.birthday,
                            selectedContact.note,
                            0);
                      }
                    },
                    icon: selectedContact.isFavorite == 0
                        ? Icon(Icons.star_border_outlined)
                        : Icon(Icons.star),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.white30,
                  child: IconButton(
                    enableFeedback: true,
                    splashColor: Colors.red,
                    color: Colors.black,
                    onPressed: () {
                      _deleteContact(selectedContact.id);
                    },
                    icon: Icon(Icons.delete),
                  ),
                ),
              ),
            ],
            expandedHeight: 350,
            pinned: true,
            // floating: true,
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: [
                StretchMode.zoomBackground,
                StretchMode.blurBackground,
              ],
              centerTitle: true,
              title: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white30,
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 3.5, 8.0, 3.5),
                  child: Text(
                    selectedContact.name,
                    textAlign: TextAlign.center,
                    softWrap: true,
                    style: TextStyle(
                      // backgroundColor: Colors.white30,
                      fontFamily: 'Comfortaa',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              background: Image.file(
                selectedContact.image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          // SliverList(
          //   delegate: SliverChildListDelegate(
          //     [
          //       SizedBox(
          //         height: 500,
          //       ),
          //       Text('Hello'),
          //       SizedBox(
          //         height: 500,
          //       ),
          //     ],
          //   ),
          // ),
          SliverStickyHeader(
            header: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Card(
                elevation: 15,
                shadowColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(child: callButton()),
                    Expanded(child: smsButton()),
                    Expanded(child: emailButton()),
                  ],
                ),
              ),
            ),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  // SizedBox(
                  //   height: 100,
                  // ),
                  detailsColumn(
                    selectedContact.phone,
                    selectedContact.email,
                    selectedContact.address,
                    selectedContact.birthday,
                    selectedContact.note,
                    selectedContact.isFavorite,
                  ),
                  SizedBox(
                    height: 600,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      'Swipe down to see details!',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget callButton() {
    return InkWell(
      overlayColor: MaterialStateProperty.all(Color.fromARGB(255, 39, 190, 44)),
      borderRadius: BorderRadius.circular(10),
      enableFeedback: true,
      onTap: () {},
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 12, 0, 4),
            child: Icon(
              Icons.phone_rounded,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 4, 0, 12),
            child: Text(
              'Call',
              style: TextStyle(
                fontSize: 15,
                fontFamily: 'MPLUSRounded',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget smsButton() {
    return InkWell(
      overlayColor: MaterialStateProperty.all(Color.fromARGB(255, 18, 41, 221)),
      borderRadius: BorderRadius.circular(10),
      enableFeedback: true,
      onTap: () {},
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 12, 0, 4),
            child: Icon(
              Icons.sms_rounded,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 4, 0, 12),
            child: Text(
              'Text',
              style: TextStyle(
                fontSize: 15,
                fontFamily: 'MPLUSRounded',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget emailButton() {
    return InkWell(
      overlayColor: MaterialStateProperty.all(Colors.yellow),
      borderRadius: BorderRadius.circular(10),
      // enableFeedback: true,
      onTap: () {},
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 12, 0, 4),
            child: Icon(
              Icons.email_rounded,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 4, 0, 12),
            child: Text(
              'Email',
              style: TextStyle(
                fontSize: 15,
                fontFamily: 'MPLUSRounded',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget detailsColumn(String phone, String email, String address, String bd,
      String note, int isFav) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.red, width: 1),
              borderRadius: BorderRadius.circular(40),
            ),
            leading: Icon(
              Icons.phone_android_rounded,
              size: 30,
            ),
            title: Text(
              phone,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.red, width: 1),
              borderRadius: BorderRadius.circular(40),
            ),
            leading: Icon(
              Icons.mail_outline_rounded,
              size: 30,
            ),
            title: Text(
              email,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.red, width: 1),
              borderRadius: BorderRadius.circular(40),
            ),
            leading: Icon(
              Icons.location_on,
              size: 30,
            ),
            title: Text(
              address,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.red, width: 1),
              borderRadius: BorderRadius.circular(40),
            ),
            leading: Icon(
              Icons.cake_rounded,
              size: 30,
            ),
            title: Text(
              bd,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ),
        Container(
          child: note.length < 2
              ? SizedBox(
                  height: 100,
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 15, 8, 8),
                      child: Text(
                        'Note:',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        height: 170,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.red, width: 1),
                        ),
                        child: Text(
                          note,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ],
    );
  }
}
