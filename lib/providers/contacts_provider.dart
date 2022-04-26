import 'dart:io';
import 'package:flutter/foundation.dart';
import '../models/contact.dart';
import '../helpers/db_helper.dart';

class ContactsProvider with ChangeNotifier {
  List<Contact> _items = [];

  List<Contact> get items {
    return [..._items];
  }

  void addContact(String pickedName, File pickedImage) {
    final newContact = Contact(
      id: DateTime.now().toString(),
      name: pickedName,
      // phone: 017,
      // email: 'null',
      // address: 'null',
      image: pickedImage,
    );
    _items.add(newContact);
    notifyListeners();
    DBHelper.insert('user_contacts', {
      'id': newContact.id,
      'name': newContact.name,
      'image': newContact.image.path,
    });
  }

  Future<void> fetchAndSetContacts() async {
    final dataList = await DBHelper.getData('user_contacts');
    _items = dataList
        .map(
          (item) => Contact(
            id: item['id'],
            name: item['name'],
            image: File(
              item['image'],
            ),
          ),
        )
        .toList();
    notifyListeners();
  }
}
