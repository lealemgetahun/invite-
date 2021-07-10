import 'package:flutter/material.dart';

class Profile extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Stack(
      children: <Widget>[
        Image.network(
          "",
          height: 150,
        ),
        Container(
          height: 50,
          width: 50,
          margin: EdgeInsets.fromLTRB(50, 100, 0, 0),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              image:
                  DecorationImage(image: NetworkImage(""), fit: BoxFit.fill)),
        ),
        Container(
          //USER_NAME
          child: Text(''),
        ),
        Container(
          //NAME
          child: Text(''),
        ),
        Container(
          //Email 
          child: Text(''),
        ),
        Container(
          //PHONE
          child: Text(''),
        )
      ],
    )
    );
  }
}
