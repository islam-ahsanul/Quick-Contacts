import 'package:flutter/foundation.dart';
import 'package:family_contact_book/models/contact.dart';

class ContactsProvider with ChangeNotifier {
  List<Contact> _items = [];

  List<Contact> get items {
    return [..._items];
  }
}
