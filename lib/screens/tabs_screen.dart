// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';

import './contacts_list_screen.dart';
import './favories_screen.dart';
import './small_tile_screen.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({Key? key}) : super(key: key);

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  Random random = Random();
  bool isSmallTile = false;
  late SharedPreferences myPreferences;
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  Future loadData() async {
    myPreferences = await SharedPreferences.getInstance();
    bool? temp = myPreferences.getBool('SmallTile');
    if (temp == null) return;

    setState(() {
      isSmallTile = temp;
    });
  }

  void _saveSmallTilePref() async {
    myPreferences.setBool('SmallTile', isSmallTile);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: Drawer(
          child: Container(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  padding: EdgeInsets.fromLTRB(0, 100, 0, 10),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 5, 20, 106),
                    // borderRadius: BorderRadius.only(
                    //   // bottomLeft: Radius.circular(40),
                    //   bottomRight: Radius.circular(40),
                    // ),
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.topRight,
                      colors: [
                        Color.fromARGB(255, 7, 31, 165),
                        Color.fromARGB(255, 2, 13, 74),
                      ],
                    ),
                  ),
                  child: Text(
                    'Settings',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontFamily: 'MPLUSRounded',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: ListTile(
                    title: Text(
                      'Small Tiles',
                      style: TextStyle(
                        fontFamily: 'MPLUSRounded',
                        fontSize: 20,
                      ),
                    ),
                    trailing: Switch(
                      activeColor: Color.fromARGB(255, 6, 18, 82),
                      value: isSmallTile,
                      onChanged: (val) {
                        setState(() {
                          isSmallTile = val;
                          _saveSmallTilePref();
                        });
                      },
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: ListTile(
                    title: Text(
                      'Help',
                      style: TextStyle(
                        fontFamily: 'MPLUSRounded',
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: ListTile(
                    title: Text(
                      'About',
                      style: TextStyle(
                        fontFamily: 'MPLUSRounded',
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
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
            labelColor: Color.fromARGB(255, 13, 21, 113),

            unselectedLabelColor: Colors.black,
            unselectedLabelStyle: TextStyle(
              fontWeight: FontWeight.normal,
              fontFamily: 'SourceSansPro',
            ),
            tabs: [
              Tab(
                icon: Icon(Icons.contacts),
                text: 'All Contacts',
              ),
              Tab(
                icon: Icon(
                  Icons.favorite,
                ),
                text: 'Favorites',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            isSmallTile == true ? SmallTileScreen() : ContactListScreen(),
            FavoriteScreen(),
          ],
        ),
      ),
    );
  }
}
