import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/contacts_provider.dart';

class ContactDetailScreen extends StatelessWidget {
  const ContactDetailScreen({Key? key}) : super(key: key);

  static const routeName = '/contact-detail';

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)?.settings.arguments.toString();
    final selectedContact =
        Provider.of<ContactsProvider>(context, listen: false).findById(id!);
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedContact.name),
      ),
    );
  }
}
