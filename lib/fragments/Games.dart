import 'package:flutter/material.dart';
import 'package:app/products/sale.dart';
import 'package:app/products/detail.dart';
import 'package:app/sqflite/DatabaseHelper.dart';
import 'package:app/sqflite/HistorySQL.dart';
import 'package:app/sqflite/SalesSQL.dart';

class Games extends StatelessWidget {
  List<sale> hot = [
    new sale(
        "PlayStation+2",
        1600,
        "assets/ps.png"),  
    new sale(
        "PlayStation+4",
        2300,
        "assets/ps.png"),  
    new sale(
        "Rami",
        1600,
        "assets/rami.png"),  
    new sale(
        "Chkobba",
        1200,
        "assets/Chkobba.png"),  
    new sale(
        "UNO",
        1000,
        "assets/uno.png"), 
    new sale(
        "Belotte",
        2000,
        "assets/4imgs.jpg"), 
    new sale(
        "Speed CUPS",
        2000,
        "assets/speedcups.jpg"),
    
    ];
  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      body:ListView.builder(
        itemCount: hot.length,
        itemBuilder: (context, position) {
          return new SaleItem(hot[position], position);
        },
      ),
    );
  }
}
class SaleItem extends StatelessWidget {
  SaleItem(this.p, this.position);

  sale p;
  int position;

  var now = new DateTime.now();
  var db = new DatabaseHelper();
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      child: Card(
        child: InkWell(
          highlightColor: Colors.blueAccent[100],
          splashColor: Colors.blue[900],
          onTap: () async {
            await db.saveHistory(new HistorySQL(saleDay: now.day,saleMonth: now.month ,saleYear: now.year ,sumSales: p.price));
            await db.saveSales(new SalesSQL(saleProduct: p.name,saleQuantity: 1,saleSum: p.price));
          },

          onLongPress : ()=> Navigator.push(context,
                                MaterialPageRoute(
                                  builder: (context) => new detail(p)
                                )
                              ),
            //Scaffold.of(context).showSnackBar(SnackBar(
            //content: Text('Tap'),
            //));

          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                new Hero(
                  child: new Image(
                    image: new AssetImage("${p.image_url}"),
                  ),
                  tag: p.name,
                ),
                Center(
                  child: Text(
                    p.name,
                    textAlign: TextAlign.right,
                  //style: Theme.of(context).textTheme.headline,
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  )
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}
