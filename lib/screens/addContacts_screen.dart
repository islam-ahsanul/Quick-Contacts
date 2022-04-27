// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../providers/contacts_provider.dart';
import '../widgets/imgae_input.dart';

class AddContactScreen extends StatefulWidget {
  const AddContactScreen({Key? key}) : super(key: key);

  static const routeName = '/addContact';

  @override
  State<AddContactScreen> createState() => _AddContactScreenState();
}

class _AddContactScreenState extends State<AddContactScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _notesController = TextEditingController();
  var _pickedImage = null;

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  Future<File> getImageFileFromAssets(String path) async {
    final byteData = await rootBundle.load('assets/images/$path');

    final file = File('${(await getTemporaryDirectory()).path}/$path');
    await file.writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    await file.create(recursive: true);
    return file;
  }

  void _saveContact() async {
    if (_nameController.text.isEmpty) {
      // can add showDialog
      return;
    }

    File backupImage = await getImageFileFromAssets('cont_icon.png');

    if (_pickedImage == null) {
      Provider.of<ContactsProvider>(context, listen: false).addContact(
        _nameController.text,
        backupImage,
        _emailController.text,
        _addressController.text,
        _notesController.text,
      );
      Navigator.of(context).pop();
    } else {
      Provider.of<ContactsProvider>(context, listen: false).addContact(
        _nameController.text,
        _pickedImage,
        _emailController.text,
        _addressController.text,
        _notesController.text,
      );
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Contact'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ImgaeInput(onSelectImage: _selectImage),
                    SizedBox(
                      height: 10,
                    ),
                    buildName(),
                    SizedBox(
                      height: 10,
                    ),
                    buildEmail(),
                    SizedBox(
                      height: 10,
                    ),
                    buildAddress(),
                    SizedBox(
                      height: 10,
                    ),
                    builNotes(),
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton.icon(
            onPressed: _saveContact,
            icon: Icon(Icons.add),
            label: Text('Add contact'),
          ),
        ],
      ),
    );
  }

  Widget buildName() => TextField(
        controller: _nameController,
        decoration: InputDecoration(
          labelText: 'Name',
          hintText: 'Enter Name',
          border: OutlineInputBorder(),
          prefixIcon: Icon(
            Icons.account_box_rounded,
            size: 30,
          ),
        ),
        textInputAction: TextInputAction.next,
      );
  Widget buildEmail() => TextField(
        controller: _emailController,
        decoration: InputDecoration(
          labelText: 'Email',
          hintText: 'Enter Email Address',
          border: OutlineInputBorder(),
          prefixIcon: Icon(
            Icons.mail_rounded,
            size: 30,
          ),
        ),
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
      );
  Widget buildAddress() => TextField(
        controller: _addressController,
        decoration: InputDecoration(
          labelText: 'Address',
          hintText: 'Enter Address',
          border: OutlineInputBorder(),
          prefixIcon: Icon(
            Icons.edit_location_outlined,
            size: 30,
          ),
        ),
        keyboardType: TextInputType.multiline,
        textInputAction: TextInputAction.next,
        maxLines: null,
      );
  Widget builNotes() => TextField(
        controller: _notesController,
        decoration: InputDecoration(
          labelText: 'Note',
          hintText: 'Add Note',
          border: OutlineInputBorder(),
          prefixIcon: Icon(
            Icons.note_alt_rounded,
            size: 30,
          ),
        ),
        keyboardType: TextInputType.multiline,
        textInputAction: TextInputAction.next,
        maxLines: 3,
      );
}
