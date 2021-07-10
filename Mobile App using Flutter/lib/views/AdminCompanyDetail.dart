import 'package:flutter/material.dart';


class AdminCompanyDetail extends StatelessWidget {
  static const companyDetailRoute = "/companyDetail";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrange,
          title: Text(
            "Company",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.account_circle),
//              onPressed: () {
//                Navigator.push(context,
//                    new MaterialPageRoute(builder: (context) => new Profile()));
//              },
            )
          ],
        ),
        body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.deepOrange, Colors.grey])),
            child: Stack(children: [
              Container(
                height: 150,
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Image.network(
                    'https://png.pngtree.com/png-clipart/20190515/original/pngtree-abstract-digital-technology-background-futuristic-structure-elements-concept-background-design-png-image_3527873.jpg'),
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 175),
                child: Column(
                  children: [
                    Text(
                      'ANc',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                    Text('LOgo'),
                  ],
                ),
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(150, 220, 0, 0),
                  child: Row(
                    children: <Widget>[
                      Text('adresse'),
                      SizedBox(
                        width: 15,
                      ),
                     // Ratting()
                    ],
                  )),
              Container(
                margin: EdgeInsets.only(top: 250, left: 15, right: 15),
                child: ListView.builder(
                    itemBuilder: (_, index) => serviceBox(services[index])),
              )
            ])));
  }

  Widget serviceBox(String service) {
    return Card(
        child: Row(children: [
      Container(
        padding: EdgeInsets.all(5),
        child: Text("$service"),
      ),
          IconButton(icon: Icon(Icons.delete),
              //TODO: bloc call onPressed:
     )
    ]));
  }

  List<String> services;
  List<String> getServices() {
    services.add("restorant");
    services.add("restorant_");
    services.add("health care");
    services.add("Cenima");
    return services;
  }
}
