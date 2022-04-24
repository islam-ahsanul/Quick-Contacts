import 'dart:io';

class Contact {
  final String id;
  final String name;
  final int phone;
  final String email;
  final String address;
  final File image;

  Contact({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.address,
    required this.image,
  });
}
