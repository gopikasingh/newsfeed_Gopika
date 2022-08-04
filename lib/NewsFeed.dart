import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class newsFeed extends StatefulWidget {
  const newsFeed ({Key? key}) : super(key: key);


  @override
  _newsFeedState createState() => _newsFeedState();
}

class _newsFeedState extends State<newsFeed> {
  List<String> litems = ["Services", "Home", "Announcements", "Search", "Vision", "About Us"];
  int _selectedIndex = 0;
  static const double bottomNavHeight = 84;
  static const double appbarr = 70;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: ListView(
          children: <Widget>[

            SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Container(

                      child: Padding(
                        padding: const EdgeInsets.only(right: 12.0, top: 10),
                        child: cardView("First releases its 2020-21 annual report",litems, 1),
                      )),
                )
            ),


            SizedBox(
              height: 20,
            )

          ],
        ),

    );
  }

  ListView cardView(title, litems, num) {
    return ListView.builder(
      itemCount: litems.length,
      itemBuilder: (BuildContext contextt, int index){
        return Padding(
          padding: const EdgeInsets.only(bottom: 3.0),
          child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(15),

              ),

            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(child: Text("9:30 AM", style: TextStyle(fontWeight: FontWeight.bold),)),
                      Text("25-12-2021", style: TextStyle(color: Colors.grey)),

                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                  ),

                  Center(child: Image.asset("assets/food.jpg", scale: 30,)),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Text("Neighbourhood take",style: TextStyle(fontWeight: FontWeight.bold),),
                  ),
                  Text("Textttttttttttt"),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Divider(),
                  ),
                  Center(child:

                  Column(
                    children: <Widget>[
                      Text("More information", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      //InkWell()


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




  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}




