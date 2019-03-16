import 'package:app/products/sale.dart';
import 'package:flutter/material.dart';
import 'package:app/sqflite/DatabaseHelper.dart';
import 'package:app/sqflite/StockSQL.dart';

class detail extends StatefulWidget {
  sale p;

  detail(this.p);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return detailState();
  }
}

class detailState extends State<detail> {
  bool _isFav = false;
  List notes;
  var db = new DatabaseHelper();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    Column buildButtonColumn(IconData icon, String label,Color colorB,int x) {
      Color color = Theme.of(context).primaryColor;

      return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          OutlineButton(
            child: Icon(icon, color: colorB),
            onPressed: () async {
              await db.saveStock(new StockSQL(productName: "${widget.p.name}",productQuantity: x));
            },
          ),
          Text(label),
        ],
      );
    }

    Widget buttonSection = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildButtonColumn(Icons.add_circle,'ADD x1',Colors.green,1),
          buildButtonColumn(Icons.add_circle, 'ADD x10',Colors.green,10),
        ],
      ),
    );
    Widget buttonSection2 = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildButtonColumn(Icons.remove_circle, 'REMOVE x1',Colors.red,-1),
        ],
      ),
    );
    //...

    return Scaffold(
      appBar: AppBar(
        title: Text("Set ${widget.p.name}"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            new Center(
              child: Hero(
                tag: widget.p.name,
                child: Image(
                  height: 200.0,
                  image: new AssetImage(widget.p.image_url),
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  "${widget.p.price}",style: TextStyle(fontSize: 30.0,fontWeight: FontWeight.bold)
                )),
            buttonSection,
            buttonSection2
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green[100],
          child: _isFav
              ? Icon(
                  Icons.favorite,
                )
              : Icon(
                  Icons.favorite_border,
                ),
          onPressed: () => setState(() {
                _isFav = !_isFav;
              })),
    );
  }
}
