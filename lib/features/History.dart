import 'package:app/sqflite/DatabaseHelper.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class History extends StatefulWidget {
  @override
  createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  var db = new DatabaseHelper();
  var widgetsListH = <TableRow> [];
 
  var dayList = List<int>();
  var monthList = List<int>();
  var yearList = List<int>();
  var sumList = List<int>();

  List history;

  Future getInfo() async{
    history = await db.getAllHistory();
    for(int i=0;i<history.length;i++){
      dayList.add(await history[i]['day']);
      monthList.add(await history[i]['month']);
      yearList.add(await history[i]['year']);
      sumList.add(await history[i]['sum']);
    }
  }
  void drawAll() async{
    await getInfo();
    widgetsListH.clear();
    widgetsListH.add(
        TableRow(
          children: [
            TableCell(
              child: Text("SUM",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold), ),
            ),
            TableCell(
              child: Text("DATE (dd/mm/yyyy)",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold),),
            )
          ]
        )
      );
  }
  
  Future drawWidget() async{
    print(dayList);
    drawAll();
    setState(() {
      for(int i=0;i<sumList.length;i++){
        widgetsListH.add(buildTableRowH(sumList[i],dayList[i],monthList[i],yearList[i]));
      }
         
    });
  }


  TableRow buildTableRowH(int sum,int day,int month,int year){
    return new TableRow(
      children: <Widget>[
        TableCell(
          child : new Text("$sum",textAlign: TextAlign.center)
        ),
        TableCell(
          child: new Text("$day - $month - $year",textAlign: TextAlign.center)
        )
      ],
    );
  }

  
  @override
  void initState(){
    drawWidget();
    super.initState();
    //drawWidget();
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
                      children: widgetsListH,
                      ),
                  )
                ],
              ),
            ),
          ],
        ),     
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()=>print(sumList),
        child: Icon(Icons.refresh),
        tooltip: 'Refresh',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

