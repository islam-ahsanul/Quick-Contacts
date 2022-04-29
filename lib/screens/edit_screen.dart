// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../providers/contacts_provider.dart';
import '../widgets/imgae_input.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({Key? key}) : super(key: key);
  static const routeName = '/edit-screen';

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  var _pickedImage = null; // ... need to edit

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  // void _saveContact() async {
  //   if (_nameController.text.isEmpty || _phoneController.text.isEmpty) {
  //     // can add showDialog
  //     return;
  //   }

  //   if (_pickedImage == null) {
  //     Provider.of<ContactsProvider>(context, listen: false).addContact(
  //       _nameController.text,
  //       backupImage, // .....need to edit
  //       _phoneController.text,
  //       _emailController.text,
  //       _addressController.text,
  //       _birthdayController.text,
  //       _notesController.text,
  //       0,
  //     );
  //     Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
  //   } else {
  //     Provider.of<ContactsProvider>(context, listen: false).addContact(
  //       _nameController.text,
  //       _pickedImage,
  //       _phoneController.text,
  //       _emailController.text,
  //       _addressController.text,
  //       _birthdayController.text,
  //       _notesController.text,
  //       0,
  //     );
  //     Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)?.settings.arguments.toString();
    final selectedContact =
        Provider.of<ContactsProvider>(context).findById(id!);
    _pickedImage = selectedContact.image;
    final _nameController = TextEditingController(text: selectedContact.name);
    final _emailController = TextEditingController(text: selectedContact.email);
    final _addressController =
        TextEditingController(text: selectedContact.address);
    final _notesController = TextEditingController(text: selectedContact.note);
    final _phoneController = TextEditingController(text: selectedContact.phone);
    final _birthdayController =
        TextEditingController(text: selectedContact.birthday);
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Contact'),
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
                    ImgaeInput(
                        onSelectImage: _selectImage,
                        fromEdit: selectedContact.image),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
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
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _phoneController,
                      decoration: InputDecoration(
                        labelText: 'Phone',
                        hintText: 'Enter 11 digit phone number',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(
                          Icons.phone_android_rounded,
                          size: 30,
                        ),
                      ),
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.next,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
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
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
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
                      textInputAction: TextInputAction.done,
                      maxLines: null,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _birthdayController,
                      decoration: InputDecoration(
                        labelText: 'BD',
                        hintText: 'Enter BD',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(
                          Icons.calendar_month_rounded,
                          size: 30,
                        ),
                      ),
                      // keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
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
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {
              Provider.of<ContactsProvider>(context, listen: false)
                  .updateContact(
                selectedContact.id,
                _nameController.text,
                _pickedImage,
                _phoneController.text,
                _emailController.text,
                _addressController.text,
                _birthdayController.text,
                _notesController.text,
                selectedContact.isFavorite,
              );
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/', (route) => false);
            },
            icon: Icon(Icons.add),
            label: Text('Save contact'),
          ),
        ],
      ),
    );
  }
}
