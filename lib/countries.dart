import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer';

class Country extends StatefulWidget {
  const Country({Key? key}) : super(key: key);

  @override
  _CountryState createState() => _CountryState();
}

class _CountryState extends State<Country> {
  final double coverHeight = 220;
  final double profileHeight = 110;
  late String data="";
  var listlen;
  //List<String> litems = ["India", "India", "India", "India", "India", "India", "India", "India", "India", "India", "India", "India", "India", "India"];
  static const double bottomNavHeight = 50;

  @override
  void initState() {
    super.initState();
    getCountryData();
  }

  void getCountryData() async {
    http.Response res = await http.get("https://restcountries.com/v3.1/all", headers: {
      "Accept": "application/json",
      "Access-Control_Allow_Origin": "*",
      "Access-Control-Allow-Headers": "Access-Control-Allow-Origin, Accept"
    });

    // log('data: $res.body');
    if (res.statusCode == 200) {
      data = res.body;
      print(jsonDecode(data)[0]['name']['common']);
      print(jsonDecode(data)[0]['flags']["png"]);

      setState(() {
        listlen = jsonDecode(data);
        log("lenfth = $listlen.length");
      });
    } else {
      log("$res.statusCode");
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[

            Padding(
              padding: const EdgeInsets.fromLTRB(24.0,4.0,10.0,0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: profileInfo(data),

              ),
            ),
          ],
        ),
        //bottomNavigationBar:

    );
  }

  // ListView profile() {
  //   return ListView.builder(
  //       itemCount: litems.length,
  //       itemBuilder: (BuildContext contextt, int index){
  //         return FutureBuilder<String>(
  //             future: data,
  //             builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
  //               if(!snapshot.hasData) return Text('getting profile url');
  //               return Image.network(snapshot.data!);
  //             });
  //       }
  //       )
  // }



      ListView profileInfo(data) {
    return ListView.builder(
      itemCount: listlen == null ? 0 : listlen.length,
      itemBuilder: (BuildContext contextt, int index){
        return Padding(
          padding: const EdgeInsets.only(top:12.0, bottom: 12, right: 8),
          child: Container(
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: Colors.black26, width: 0.5)
                )
            ),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 18.0),
              child: Row(
                children: [
                  //Text(listlen.toString()),
                  Padding(
                    padding: const EdgeInsets.only(right: 12.0, left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(jsonDecode(data)[index]['flags']["png"], scale: 10,)
                        // Image.asset("assets/india.jpg", scale: 40,)
                      ],
                    ),
                  ),

                  Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(jsonDecode(data)[index]['name']['common'], style: TextStyle( fontSize: 16)),
                        ],
                      )
                  ),

                ],
              ),
            ),
          ),
        );
        //new Text(litems[index] + ":" +litems[index] );
      },
    );
  }
}