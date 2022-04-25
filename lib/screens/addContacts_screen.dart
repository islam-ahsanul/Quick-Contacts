import 'package:flutter/material.dart';

import '../widgets/imgae_input.dart';

class AddContactScreen extends StatefulWidget {
  const AddContactScreen({Key? key}) : super(key: key);

  static const routeName = '/addContact';

  @override
  State<AddContactScreen> createState() => _AddContactScreenState();
}

class _AddContactScreenState extends State<AddContactScreen> {
  final _nameController = TextEditingController();
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
                    ImgaeInput(),
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {},
            icon: Icon(Icons.add),
            label: Text('Add contact'),
          ),
        ],
      ),
    );
  }
}
