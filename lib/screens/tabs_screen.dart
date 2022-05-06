// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import './contacts_list_screen.dart';
import './favories_screen.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({Key? key}) : super(key: key);

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: FlexibleSpaceBar(
            background: Image.asset(
              'assets/images/background_one.jpg',
              fit: BoxFit.cover,
            ),
          ),
          bottom: TabBar(
            // indicatorColor: Colors.red,
            labelStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'SourceSansPro',
              fontSize: 15,
            ),
            labelColor: Colors.indigo[900],

            unselectedLabelColor: Colors.black,
            unselectedLabelStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'SourceSansPro',
              fontSize: 14,
            ),
            tabs: [
              Tab(
                icon: Icon(Icons.contacts),
                text: 'All Contacts',
              ),
              Tab(
                icon: Icon(
                  Icons.stars,
                ),
                text: 'Favorites',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ContactListScreen(),
            FavoriteScreen(),
          ],
        ),
      ),
    );
  }
}
