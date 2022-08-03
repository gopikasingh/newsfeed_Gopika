import 'package:flutter/material.dart';
import 'package:newsfeed/NewsFeed.dart';
import 'package:newsfeed/countries.dart';
import 'package:newsfeed/deviceInfo.dart';
void main() {
  runApp( const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;
  final pages = [
    newsFeed(), Country(), Device(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        fontFamily: 'Montserrat',
      ),
      home: Scaffold(
          body: Center(
            child: pages[_selectedIndex],
          ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.newspaper_outlined),
              label: 'News',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
          currentIndex: _selectedIndex, //New
          onTap: _onItemTapped,

        ),
      ),

    );

  }


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
