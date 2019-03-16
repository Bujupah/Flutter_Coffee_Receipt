import 'package:flutter/material.dart';
import 'package:app/sqflite/DatabaseHelper.dart';


class TopSales extends StatefulWidget {
  _TopSalesState createState() => _TopSalesState();
}

class _TopSalesState extends State<TopSales> {

  var db = new DatabaseHelper();
  var topSalesTable = <TableRow>[];
  var saleP = List<String>();
  var saleQ = List<int>();
  var saleS = List<int>();
  List top;

  Future getTopSales() async{
    top = await db.getAllSale();
    for(int i=0;i<top.length;i++){
      saleP.add(await top[i]['saleP']);
      saleQ.add(await top[i]['saleQ']);
      saleS.add(await top[i]['saleS']);
    }
  }

Future drawResult() async{
    await getTopSales();
    topSalesTable.add(new TableRow(
      children: [
        TableCell(child: Text("Product",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold))),
        TableCell(child: Text("Quantity sold",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold))),
        TableCell(child: Text("SUM",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold))),
      ],
    ));
    setState(() {
      for(int i=0;i<saleP.length;i++){
        topSalesTable.add(drawTableResult(saleP[i],saleQ[i],saleS[i]));
      }
         
    });
  }
TableRow drawTableResult(String p,int q,int s){
  return new TableRow(
    children: [
      TableCell(child: Text("$p",textAlign: TextAlign.center)),
      TableCell(child: Text("$q",textAlign: TextAlign.center)),
      TableCell(child: Text("$s",textAlign: TextAlign.center))
      ]
  );
}
  @override
  void initState(){
    drawResult();
    print(top);
    super.initState(); 
  }

  @override
  Widget build(BuildContext context) {
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
                      children: topSalesTable,
                      ),
                  )
                ],
              ),
            ),
          ],
        ),     
      ),
    );
  }
}