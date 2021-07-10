import 'package:flutter/material.dart';

class DeleteDialoge extends StatelessWidget {
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Confirm Delete'),
      content: Text('Are you sure you want to delete this?'),
      actions: <Widget>[
        FlatButton(
          child: Text("Yes"),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
        FlatButton(
            child: Text("No"),
            onPressed: () {
              Navigator.of(context).pop(false);
            })
      ],
    );
  }
}
