import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer';

class empty extends StatefulWidget {
  const empty({Key? key}) : super(key: key);



  @override
  _emptyState createState() => _emptyState();
}

class _emptyState extends State<empty> {
  final double coverHeight = 220;
  final double profileHeight = 110;
  static const double bottomNavHeight = 50;


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Text("hie"),



        ],
      ),
      //bottomNavigationBar:

    );
  }

}