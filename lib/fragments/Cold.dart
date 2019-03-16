import 'package:flutter/material.dart';
import 'package:app/products/sale.dart';
import 'package:app/products/detail.dart';
import 'package:app/sqflite/DatabaseHelper.dart';
import 'package:app/sqflite/StockSQL.dart';
import 'package:app/sqflite/HistorySQL.dart';
import 'package:app/sqflite/SalesSQL.dart';

class Cold extends StatelessWidget {

  List<sale> hot = [
    new sale(
        "Soda",
        1600,
        "assets/soda.png"),  
    new sale(
        "Soda plus",
        2300,
        "assets/soda+.png"),  
    new sale(
        "Kiwi",
        2000,
        "assets/kiwi.png"),  
    new sale(
        "Orange",
        1200,
        "assets/orange.png"),  
    new sale(
        "Fraise",
        2000,
        "assets/fraise.png"), 
    new sale(
        "Citron",
        1200,
        "assets/citron.png"), 
    new sale(
        "Mojito",
        1000,
        "assets/mojito.png"),
    new sale(
        "Lait de poule",
        2300,
        "assets/lait.jpg"),
    new sale(
        "Eau 0.5L",
        1000,
        "assets/05l.png"),
    new sale(
        "Eau 1L",
        1000,
        "assets/1l.png"),
    new sale(
        "Eau 1.5L",
        1000,
        "assets/15l.png"),
    
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
  List notes;
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
            await db.saveStock(new StockSQL(productName: "${p.name}",productQuantity: -1));
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new Hero(
                  child: new Image(
                    image: new AssetImage(p.image_url),
                    alignment: Alignment.centerLeft,
                  ),
                  tag: p.name,
                ),
                Center(
                  child: Text(
                    p.name,
                    textAlign: TextAlign.end,
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
