import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:family_contact_book/models/contact.dart';

class ContactsProvider with ChangeNotifier {
  List<Contact> _items = [];

  List<Contact> get items {
    return [..._items];
  }

  void addContact(String pickedName, File pickedImage) {
    final newContact = Contact(
      id: DateTime.now().toString(),
      name: pickedName,
      phone: 017,
      email: 'null',
      address: 'null',
      image: pickedImage,
    );
    _items.add(newContact);
    notifyListeners();
  }
}
