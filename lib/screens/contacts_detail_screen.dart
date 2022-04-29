import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

import '../providers/contacts_provider.dart';

class ContactDetailScreen extends StatefulWidget {
  const ContactDetailScreen({Key? key}) : super(key: key);

  static const routeName = '/contact-detail';

  @override
  State<ContactDetailScreen> createState() => _ContactDetailScreenState();
}

class _ContactDetailScreenState extends State<ContactDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)?.settings.arguments.toString();
    final selectedContact =
        Provider.of<ContactsProvider>(context, listen: true).findById(id!);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            // forceElevated: true,
            elevation: 40,
            collapsedHeight: 130,
            actions: [
              IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
              IconButton(
                onPressed: () {},
                icon: selectedContact.isFavorite == 0
                    ? Icon(Icons.star_border_outlined)
                    : Icon(Icons.star),
              ),
            ],
            expandedHeight: 350,
            pinned: true,
            // floating: true,
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: [
                StretchMode.zoomBackground,
                StretchMode.blurBackground,
              ],
              centerTitle: true,
              title: Text(selectedContact.name),
              background: Image.file(
                selectedContact.image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          // SliverList(
          //   delegate: SliverChildListDelegate(
          //     [
          //       SizedBox(
          //         height: 500,
          //       ),
          //       Text('Hello'),
          //       SizedBox(
          //         height: 500,
          //       ),
          //     ],
          //   ),
          // ),
          SliverStickyHeader(
            header: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(child: callButton()),
                    Expanded(child: smsButton()),
                    Expanded(child: emailButton()),
                  ],
                ),
              ),
            ),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  SizedBox(
                    height: 100,
                  ),
                  detailsColumn(
                    selectedContact.phone,
                    selectedContact.email,
                    selectedContact.address,
                    selectedContact.birthday,
                    selectedContact.note,
                    selectedContact.isFavorite,
                  ),
                  SizedBox(
                    height: 200,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget callButton() {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      enableFeedback: true,
      onTap: () {},
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 12, 0, 4),
            child: Icon(Icons.phone_rounded),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 4, 0, 12),
            child: Text('Call'),
          ),
        ],
      ),
    );
  }

  Widget smsButton() {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      enableFeedback: true,
      onTap: () {},
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 12, 0, 4),
            child: Icon(Icons.message_rounded),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 4, 0, 12),
            child: Text('Text'),
          ),
        ],
      ),
    );
  }

  Widget emailButton() {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      enableFeedback: true,
      onTap: () {},
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 12, 0, 4),
            child: Icon(Icons.email_rounded),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 4, 0, 12),
            child: Text('Email'),
          ),
        ],
      ),
    );
  }

  Widget detailsColumn(String phone, String email, String address, String bd,
      String note, int isFav) {
    return Column(
      children: [
        Divider(
          thickness: 5.0,
        ),
        Container(
          height: 50,
          width: double.infinity,
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(Icons.phone_android_rounded),
              Text(phone),
            ],
          ),
        ),
        Divider(
          thickness: 5.0,
        ),
        Container(
          height: 50,
          width: double.infinity,
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(Icons.mail_outline_rounded),
              Text(email),
            ],
          ),
        ),
        Divider(
          thickness: 5.0,
        ),
        Container(
          height: 50,
          width: double.infinity,
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(Icons.location_on),
              Text(address),
            ],
          ),
        ),
        Divider(
          thickness: 5.0,
        ),
        Container(
          height: 50,
          width: double.infinity,
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(Icons.cake_rounded),
              Text(bd),
            ],
          ),
        ),
        Divider(
          thickness: 5.0,
        ),
        Container(
          height: 50,
          width: double.infinity,
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(Icons.cake_rounded),
              Text('$isFav'),
            ],
          ),
        ),
        Divider(
          thickness: 5.0,
        ),
      ],
    );
  }
}
