import 'dart:io';

class Contact {
  final String id;
  final File image;
  final String name;
  // final int phone;
  final String email;
  final String address;
  final String note;

  Contact({
    required this.id,
    required this.image,
    required this.name,
    // required this.phone,
    required this.email,
    required this.address,
    required this.note,
  });
}
