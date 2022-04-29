import 'dart:io';
import 'package:flutter/foundation.dart';
import '../models/contact.dart';
import '../helpers/db_helper.dart';

class ContactsProvider with ChangeNotifier {
  List<Contact> _items = [];

  List<Contact> get items {
    return [..._items];
  }

  Contact findById(String id) {
    return _items.firstWhere((contact) => contact.id == id);
  }

  void addContact(
    String pickedName,
    File pickedImage,
    String pickedPhone,
    String pickedEmail,
    String pickedAddress,
    String pickedBirthday,
    String pickedNote,
    int pickedFavorite,
  ) {
    final newContact = Contact(
      id: pickedPhone,
      image: pickedImage,
      name: pickedName,
      phone: pickedPhone,
      email: pickedEmail,
      address: pickedAddress,
      birthday: pickedBirthday,
      note: pickedNote,
      isFavorite: pickedFavorite,
    );
    notifyListeners();
    _items.add(newContact);
    DBHelper.insert(
      'user_contacts',
      {
        'id': newContact.id,
        'name': newContact.name,
        'image': newContact.image.path,
        'phone': newContact.phone,
        'email': newContact.email,
        'address': newContact.address,
        'birthday': newContact.birthday,
        'note': newContact.note,
        'isFavorite': newContact.isFavorite,
      },
    );
    notifyListeners();
  }

  Future<void> fetchAndSetContacts() async {
    final dataList = await DBHelper.getData('user_contacts');
    _items = dataList
        .map(
          (item) => Contact(
            id: item['id'],
            name: item['name'],
            image: File(item['image']),
            phone: item['phone'],
            email: item['email'],
            address: item['address'],
            birthday: item['birthday'],
            note: item['note'],
            isFavorite: item['isFavorite'],
          ),
        )
        .toList();
    notifyListeners();
  }
}
