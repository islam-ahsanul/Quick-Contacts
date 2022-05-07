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
    'assets/images/background_one.jpg',
    'assets/images/background_two.jpg',
  ];
  Random random = Random();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.black,
          flexibleSpace: FlexibleSpaceBar(
            background: Image.asset(
              // 'assets/images/background_one.jpg',
              _backgroundImages[random.nextInt(2)],
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
