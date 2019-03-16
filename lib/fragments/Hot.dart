import 'package:flutter/material.dart';
import 'package:app/products/sale.dart';
import 'package:app/products/detail.dart';
import 'package:app/sqflite/HistorySQL.dart';
import 'package:app/sqflite/StockSQL.dart';
import 'package:app/sqflite/DatabaseHelper.dart';

class Hot extends StatelessWidget {
  List<sale> hot = [
    new sale(
        "Express",
        1000,
        "assets/express.png"),  
    new sale(
        "Cappucin",
        1000,
        "assets/express.png"),  
    new sale(
        "Direct",
        1000,
        "assets/express.png"),  
    new sale(
        "American",
        1000,
        "assets/express.png"),  
    new sale(
        "Chocolat au lait",
        1200,
        "assets/express.png"), 
    new sale(
        "Chocolat chaud",
        1000,
        "assets/express.png"), 
    new sale(
        "Thé normal",
        1000,
        "assets/express.png"),
    new sale(
        "Thé amonde",
        1000,
        "assets/express.png"),
    new sale(
        "Thé menthe",
        1000,
        "assets/express.png"),
    
    ];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
  var db = new DatabaseHelper();
  var now = new DateTime.now();
  sale p;
  int position;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      child: Card(
        child: InkWell(
          highlightColor: Colors.blueAccent[100],
          splashColor: Colors.blue[900],
          onTap: () async {
            await db.saveStock(new StockSQL(productName: "${p.name}",productQuantity: -1));
            await db.saveHistory(new HistorySQL(saleDay: now.day,saleMonth: now.month ,saleYear: now.year ,sumSales: p.price));
          }, // Add to base;
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
                    image: new AssetImage(p.image_url),
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
