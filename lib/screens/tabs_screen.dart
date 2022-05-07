// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'dart:math';

import './contacts_list_screen.dart';
import './favories_screen.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({Key? key}) : super(key: key);

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  final List<String> _backgroundImages = [
    'assets/images/bg1.jpg',
    'assets/images/bg2.jpg',
    'assets/images/bg3.jpg',
    'assets/images/bg4.jpg',
    'assets/images/bg5.jpg',
    'assets/images/bg6.jpg',
    'assets/images/bg7.jpg',
    'assets/images/bg8.jpg',
    'assets/images/bg9.jpg',
    'assets/images/bg10.jpg',
    'assets/images/bg11.jpg',
    'assets/images/bg12.jpg',
    'assets/images/bg13.jpg',
    'assets/images/bg14.jpg',
    'assets/images/bg15.jpg',
    'assets/images/bg16.jpg',
    'assets/images/bg17.jpg',
    'assets/images/bg18.jpg',
    'assets/images/bg19.jpg',
    'assets/images/bg20.jpg',
    'assets/images/bg21.jpg',
    'assets/images/bg22.jpg',
    'assets/images/bg23.jpg',
    'assets/images/bg24.jpg',
    'assets/images/bg25.jpg',
    'assets/images/bg26.jpg',
  ];
  Random random = Random();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: MyDrawer(),
        appBar: AppBar(
          foregroundColor: Colors.black,
          flexibleSpace: FlexibleSpaceBar(
            background: Image.asset(
              // 'assets/images/background_one.jpg',
              _backgroundImages[random.nextInt(26)],
              fit: BoxFit.cover,
            ),
          ),
          actions: [
            PopupMenuButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    padding: EdgeInsets.all(0),
                    value: 0,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 9),
                          child: Icon(
                            Icons.refresh_rounded,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Refresh',
                          style: TextStyle(
                            fontSize: 18,
                            // fontFamily: 'SourceSansPro',
                          ),
                        ),
                      ],
                    ),
                  ),
                ];
              },
              onSelected: (value) {
                if (value == 0) {
                  Navigator.of(context).pushReplacementNamed('/');
                }
              },
            ),
          ],
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

// ------------------------Drawer------------------------------------------

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: RoundedRectangleBorder(
          // borderRadius: BorderRadius.only(topRight: 30.0, ),
          ),
      child: Container(
        child: Center(
          child: Text('This is drawer'),
        ),
      ),
    );
  }
}
