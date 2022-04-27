import 'dart:io';
import 'package:flutter/foundation.dart';
import '../models/contact.dart';
import '../helpers/db_helper.dart';

class ContactsProvider with ChangeNotifier {
  List<Contact> _items = [];

  List<Contact> get items {
    return [..._items];
  }

  void addContact(
    String pickedName,
    File pickedImage,
    String pickedEmail,
    String pickedAddress,
    String pickedNote,
  ) {
    final newContact = Contact(
      id: DateTime.now().toString(),
      image: pickedImage,
      name: pickedName,
      // phone: 017,
      email: pickedEmail,
      address: pickedAddress,
      note: pickedNote,
      // birthday:
    );
    _items.add(newContact);
    notifyListeners();
    DBHelper.insert('user_contacts', {
      'id': newContact.id,
      'name': newContact.name,
      'image': newContact.image.path,
      'email': newContact.email,
      'address': newContact.address,
      'note': newContact.note,
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
            email: item['email'],
            address: item['address'],
            note: item['note'],
          ),
        )
        .toList();
    notifyListeners();
  }
}
