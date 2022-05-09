import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

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
                    // splashColor: Colors.red,
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
                    // splashColor: Colors.red,
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
                      // ---------- snackbar
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                          behavior: SnackBarBehavior.floating,
                          duration: Duration(seconds: 2),
                          backgroundColor: Colors.black,
                          content: const Text(
                            'Favorites updated',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'SourceSansPro',
                              // color: Colors.black,
                            ),
                          ),
                        ),
                      );
                    },
                    icon: selectedContact.isFavorite == 0
                        ? Icon(Icons.favorite_border_rounded)
                        : Icon(Icons.favorite_rounded),
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
                    // splashColor: Colors.red,
                    color: Colors.black,
                    // _deleteContact(selectedContact.id);
                    onPressed: () => showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        title: const Text(
                          'Do you want to delete this contact?',
                          // textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'MPLUSRounded',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              'Cancel',
                              style: TextStyle(
                                fontFamily: 'MPLUSRounded',
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              _deleteContact(selectedContact.id);
                              Navigator.of(context).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  behavior: SnackBarBehavior.floating,
                                  duration: Duration(seconds: 3),
                                  backgroundColor: Colors.black,
                                  content: const Text(
                                    'Contact has been deleted.\nPlease refresh the page to see the result.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'SourceSansPro',
                                      // color: Colors.black,
                                    ),
                                  ),
                                ),
                              );
                            },
                            child: const Text(
                              'Delete',
                              style: TextStyle(
                                fontFamily: 'MPLUSRounded',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    icon: Icon(Icons.delete),
                  ),
                ),
              ),
            ],
            expandedHeight: 350,
            pinned: true,
            // floating: true,
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: const [
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
                    style: const TextStyle(
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
                    Expanded(
                      child: callButton(
                        selectedContact.phone,
                      ),
                    ),
                    Expanded(
                      child: smsButton(
                        selectedContact.phone,
                      ),
                    ),
                    selectedContact.email.isEmpty
                        ? Container()
                        : Expanded(
                            child: emailButton(
                              selectedContact.email,
                            ),
                          ),
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
                  const SizedBox(
                    height: 600,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(12.0),
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

  Widget callButton(String phone) {
    return InkWell(
      overlayColor: MaterialStateProperty.all(Color.fromARGB(255, 39, 190, 44)),
      borderRadius: BorderRadius.circular(10),
      enableFeedback: true,
      onTap: () async {
        await FlutterPhoneDirectCaller.callNumber(phone);
      },
      child: Column(
        children: const [
          Padding(
            padding: EdgeInsets.fromLTRB(0, 12, 0, 4),
            child: Icon(
              Icons.phone_rounded,
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 4, 0, 12),
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

  Widget smsButton(String phone) {
    return InkWell(
      overlayColor: MaterialStateProperty.all(Color.fromARGB(255, 18, 41, 221)),
      borderRadius: BorderRadius.circular(10),
      enableFeedback: true,
      onTap: () {
        launch('sms:$phone');
      },
      child: Column(
        children: const [
          Padding(
            padding: EdgeInsets.fromLTRB(0, 12, 0, 4),
            child: Icon(
              Icons.sms_rounded,
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 4, 0, 12),
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

  Widget emailButton(String email) {
    return InkWell(
      overlayColor: MaterialStateProperty.all(Colors.orange),
      borderRadius: BorderRadius.circular(10),
      // enableFeedback: true,
      onTap: () {
        launch('mailto:$email');
      },
      child: Column(
        children: const [
          Padding(
            padding: EdgeInsets.fromLTRB(0, 12, 0, 4),
            child: Icon(
              Icons.email_rounded,
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 4, 0, 12),
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
            onLongPress: () {
              Clipboard.setData(
                ClipboardData(text: phone),
              );
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                  // margin:
                  //     EdgeInsets.symmetric(vertical: 100.0, horizontal: 10.0),
                  behavior: SnackBarBehavior.floating,
                  duration: Duration(seconds: 1),
                  backgroundColor: Colors.black,
                  content: const Text(
                    'Copied phone number to clipboard',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'SourceSansPro',
                      // color: Colors.black,
                    ),
                  ),
                ),
              );
            },
            visualDensity: VisualDensity(vertical: -1),
            shape: RoundedRectangleBorder(
              side: const BorderSide(
                  color: ui.Color.fromARGB(255, 179, 255, 93), width: 1),
              borderRadius: BorderRadius.circular(30),
            ),
            leading: ShaderMask(
              blendMode: BlendMode.srcIn,
              shaderCallback: (Rect bounds) {
                return ui.Gradient.linear(
                  Offset(24.0, 4.0),
                  Offset(10.0, 24.0),
                  [
                    ui.Color.fromARGB(255, 179, 255, 93),
                    ui.Color.fromARGB(255, 43, 179, 47),
                  ],
                );
              },
              child: const Icon(
                Icons.phone_android_rounded,
                size: 30,
              ),
            ),
            title: Text(
              phone,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          ),
        ),
        email.length < 2
            ? Container()
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  onLongPress: () {
                    Clipboard.setData(
                      ClipboardData(text: email),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                        // margin:
                        //     EdgeInsets.symmetric(vertical: 100.0, horizontal: 10.0),
                        behavior: SnackBarBehavior.floating,
                        duration: Duration(seconds: 1),
                        backgroundColor: Colors.black,
                        content: const Text(
                          'Copied email address to clipboard',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'SourceSansPro',
                            // color: Colors.black,
                          ),
                        ),
                      ),
                    );
                  },
                  visualDensity: VisualDensity(vertical: -1),
                  enabled: true,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                        color: ui.Color.fromARGB(255, 253, 220, 102), width: 1),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  leading: ShaderMask(
                    blendMode: BlendMode.srcIn,
                    shaderCallback: (Rect bounds) {
                      return ui.Gradient.linear(
                        Offset(24.0, 4.0),
                        Offset(4.0, 24.0),
                        [
                          Colors.amberAccent,
                          Colors.deepOrange,
                        ],
                      );
                    },
                    child: const Icon(
                      Icons.mail_outline_rounded,
                      size: 30,
                    ),
                  ),
                  title: Text(
                    email,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
        address.length < 2
            ? Container()
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  onLongPress: () {
                    Clipboard.setData(
                      ClipboardData(text: address),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                        // margin:
                        //     EdgeInsets.symmetric(vertical: 100.0, horizontal: 10.0),
                        behavior: SnackBarBehavior.floating,
                        duration: Duration(seconds: 1),
                        backgroundColor: Colors.black,
                        content: const Text(
                          'Copied address to clipboard',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'SourceSansPro',
                            // color: Colors.black,
                          ),
                        ),
                      ),
                    );
                  },
                  visualDensity: VisualDensity(vertical: -1),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.cyanAccent, width: 1),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  leading: ShaderMask(
                    blendMode: BlendMode.srcIn,
                    shaderCallback: (Rect bounds) {
                      return ui.Gradient.linear(
                        Offset(24.0, 4.0),
                        Offset(10.0, 24.0),
                        [
                          Colors.cyanAccent,
                          ui.Color.fromARGB(251, 11, 7, 92),
                        ],
                      );
                    },
                    child: const Icon(
                      Icons.location_on,
                      size: 30,
                    ),
                  ),
                  title: Text(
                    address,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
        bd.length < 2
            ? Container()
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  onLongPress: () {
                    Clipboard.setData(
                      ClipboardData(text: bd),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                        // margin:
                        //     EdgeInsets.symmetric(vertical: 100.0, horizontal: 10.0),
                        behavior: SnackBarBehavior.floating,
                        duration: Duration(seconds: 1),
                        backgroundColor: Colors.black,
                        content: const Text(
                          'Copied birth date to clipboard',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'SourceSansPro',
                            // color: Colors.black,
                          ),
                        ),
                      ),
                    );
                  },
                  visualDensity: VisualDensity(vertical: -1),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                        color: ui.Color.fromARGB(255, 254, 156, 189), width: 1),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  leading: ShaderMask(
                    blendMode: BlendMode.srcIn,
                    shaderCallback: (Rect bounds) {
                      return ui.Gradient.linear(
                        Offset(24.0, 4.0),
                        Offset(10.0, 24.0),
                        [
                          Colors.white,
                          Colors.pink,
                        ],
                      );
                    },
                    child: const Icon(
                      Icons.cake_rounded,
                      size: 30,
                    ),
                  ),
                  title: Text(
                    bd.split(',')[0],
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
        Container(
          child: note.length < 2
              ? const SizedBox(
                  height: 100,
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(8, 15, 8, 8),
                      child: Text(
                        'Note:',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onLongPress: () {
                          Clipboard.setData(
                            ClipboardData(text: note),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40),
                              ),
                              // margin:
                              //     EdgeInsets.symmetric(vertical: 100.0, horizontal: 10.0),
                              behavior: SnackBarBehavior.floating,
                              duration: Duration(seconds: 1),
                              backgroundColor: Colors.black,
                              content: const Text(
                                'Copied notes to clipboard',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'SourceSansPro',
                                  // color: Colors.black,
                                ),
                              ),
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          // height: 170,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                                color: ui.Color.fromARGB(31, 112, 112, 112),
                                width: 1),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              note,
                              textAlign: TextAlign.center,
                              // softWrap: true,
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
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
