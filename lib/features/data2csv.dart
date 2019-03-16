import 'package:flutter/material.dart';
import 'package:app/sqflite/DatabaseHelper.dart';
import 'package:csv/csv.dart';


class Data2CSV extends StatelessWidget {
  final Widget child;

  Data2CSV({Key key, this.child}) : super(key: key);
  DatabaseHelper db = new DatabaseHelper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new RaisedButton(
              splashColor: Colors.pinkAccent,
              color: Colors.amber[300],
              child: new Text(
                "Download",
                style: new TextStyle(fontSize: 50.0, color: Colors.white),
              ),
              onPressed: () async{
                List  report = await db.getAllHistory();
                print(report);
                //TO DO
                //Generating a CSV and uploading it to the phone storage
              },
            ),
          ],
        ),
      ),
    );
  }
}