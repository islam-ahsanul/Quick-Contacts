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
    // if (_nameController.text.isEmpty || _pickedImage == null) {
    //   // can add showDialog
    //   return;
    // }

    File backupImage = await getImageFileFromAssets('cont_icon.png');

    if (_pickedImage == null) {
      Provider.of<ContactsProvider>(context, listen: false)
          .addContact(_nameController.text, backupImage);
      Navigator.of(context).pop();
    } else {
      Provider.of<ContactsProvider>(context, listen: false)
          .addContact(_nameController.text, _pickedImage);
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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(labelText: 'Name'),
                      controller: _nameController,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ImgaeInput(onSelectImage: _selectImage),
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
}
