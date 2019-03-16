import 'package:app/main_menu.dart';
import 'package:app/fragments/Hot.dart';
import 'package:app/fragments/Cold.dart';
import 'package:app/fragments/Food.dart';
import 'package:app/fragments/Games.dart';
import 'package:app/fragments/Formules.dart';
import 'package:app/features/data2csv.dart';
import 'package:app/features/History.dart';
import 'package:app/features/Stock.dart';
import 'package:app/features/TopSales.dart';
import 'package:flutter/material.dart';

class DrawerItem {
  String title;
  IconData icon;
  DrawerItem(this.title, this.icon);
}

class HomePage extends StatefulWidget {
  final drawerItems = [
    new DrawerItem("Main Menu", Icons.rss_feed),
    new DrawerItem("Hot Drinks", Icons.free_breakfast),
    new DrawerItem("Cold Drinks", Icons.local_drink),
    new DrawerItem("Food", Icons.fastfood),
    new DrawerItem("Games", Icons.grade),
    new DrawerItem("Formules",Icons.format_list_numbered),

    new DrawerItem("Stock",Icons.location_city),
    new DrawerItem("History",Icons.history),
    new DrawerItem("Top Sales", Icons.vertical_align_top),
    new DrawerItem("Report",Icons.file_download),
  ];

  @override
  State<StatefulWidget> createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  int _selectedDrawerIndex = 0;

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return new MainMenu();
      case 1:
        return new Hot();
      case 2:
        return new Cold();
      case 3:
        return new Food();
      case 4:
        return new Games();
      case 5:
        return new Formules();
      case 6:
        return new Stock();
      case 7:
        return new History();
      case 8:
        return new TopSales();
      case 9:
        return new Data2CSV();
      default:
        return new Text("Error");
    }
  }
  
  _onSelectItem(int index) {
    setState(() => _selectedDrawerIndex = index);
    Navigator.of(context).pop(); // close the drawer
  }

  @override
  Widget build(BuildContext context) {
    var drawerOptions = <Widget>[];
    for (var i = 0; i < widget.drawerItems.length; i++) {
      var d = widget.drawerItems[i];
      if (i == 0){
        drawerOptions.add(
          new Padding(
            padding: EdgeInsets.all(16),
          )
        );
      }
      if (i == widget.drawerItems.length-4){
        drawerOptions.add(
          new Spacer()
        );
      }

      drawerOptions.add(
        new ListTile(
          leading: new Icon(d.icon),
          title: new Text(d.title),
          selected: i == _selectedDrawerIndex,
          onTap: () => _onSelectItem(i),
        )
     
      );
      
    }

    return new Scaffold(
      appBar: new AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        // here we display the title corresponding to the fragment
        // you can instead choose to have a static title
        backgroundColor: Colors.amber[300],
        title: new Text(
          widget.drawerItems[_selectedDrawerIndex].title,
          style: TextStyle(color: Colors.white),),
      ),
      drawer: new Drawer(
        child:
            new Column(children: drawerOptions)
        ),
      
      body: _getDrawerItemWidget(_selectedDrawerIndex),
    );
  }
}
