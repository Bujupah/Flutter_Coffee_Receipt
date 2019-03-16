import 'package:app/sqflite/DatabaseHelper.dart';
import 'package:app/sqflite/StockSQL.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class Stock extends StatefulWidget {
  @override
  createState() => _StockState();
}

class _StockState extends State<Stock> {
  var db = new DatabaseHelper();  
  var widgetsList = <TableRow> [];
  var nameList = List<String>();
  var quantityList = List<int>();
  
  List stocks;
  String item;

  List<String> products = [
                "Soda","Soda plus","Kiwi","Orange","Fraise","Citron","Lait de poule","Eau 0.5L","Eau 1L","Eau 1.5L",
                "Express","Cappucin","Direct","American","Chocolat au lait","Chocolat chaud","Thé normal","Thé amonde","Thé menthe",
                "Venoisserie","Cake","Cookies","Muffin","Jmabon","Thon","Fromage","Escalope","Suppliment ++","Chicha"];
  List<DropdownMenuItem<String>> items = [];

  void  fillItems(){
    for(int i=0;i<products.length;i++){
      items.add(DropdownMenuItem<String>(
                value: products[i],
                child: new Text(
                  products[i],
                  style: new TextStyle(color: Colors.black),
                ),
    ));
    }
  }
  Future drawAll() async{
    stocks = await db.getAllStock();
    for(int i=0;i<stocks.length;i++){
      nameList.add(await stocks[i]['name']);
      quantityList.add(await stocks[i]['quantity']);
    }
    widgetsList.clear();
    widgetsList.add(
        TableRow(
          children: [
            TableCell(
              child: Text("Product",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold), ),
            ),
            TableCell(
              child: Text("Quantity",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold),),
            )
          ]
        )
      );
  }
  
  Future drawWidget() async{
    await drawAll();
    
    setState(() {
      
    for(int i=0;i<nameList.length;i++){
      widgetsList.add(buildTableRow(nameList[i],quantityList[i]));
    }
      nameList.clear();
      quantityList.clear(); 
    });
  }


  TableRow buildTableRow(String name,int quantity){
    return new TableRow(
      children: <Widget>[
        TableCell(
          child : new Text("$name",textAlign: TextAlign.center)
        ),
        TableCell(
          child: new Text("$quantity",textAlign: TextAlign.center)
        )
      ],
    );
  }
  
 
  @override
  void initState(){
    super.initState();
    drawWidget();
    fillItems();
    item = products[0];
  }

  @override
  build(context) {
    return Scaffold(
      body: Container(
        child : new Column(
          children: <Widget>[
            new Container(
              child: new Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Table(
                      border: TableBorder.all(width: 1.0,color: Colors.blue,style: BorderStyle.solid),
                      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                      children: widgetsList
                      ),
                  )
                ],
              ),
            ),
          ],
        ),     
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showDialog (
                  context: context,
                  child: new AlertDialog(
                    title: new Text("Add Stock"),
                    content: new DropdownButton(
                      hint: new Text("Select a product to refill"),
                      onChanged: (String s) {
                        setState((){
                          item=s;
                        });
                      },
                      items: items,
                      value: item,

                      
                    ),
                    actions: <Widget>[
                      new FlatButton(
                        child: new Text("Exit"),
                        onPressed: () {
                          drawWidget();
                          Navigator.pop(context);
                        }
                        
                      ),
                      new FlatButton(
                        child: new Text("x1"),
                        onPressed: () async {
                          await db.saveStock(new StockSQL(productName: item,productQuantity: 1));
                        }
                      ),
                      new FlatButton(
                        child: new Text("x5"),
                        onPressed: () async {
                          await db.saveStock(new StockSQL(productName: item,productQuantity: 5));
                        }
                      ),                      
                    ],
                  ),
                );
        },
        child: Icon(Icons.add_circle),
        tooltip: 'Refresh',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
