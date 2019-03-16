import 'package:flutter/material.dart';
import 'package:app/design/menu_design.dart';
class MainMenu extends StatefulWidget {
  final Widget child;
  MainMenu({Key key, this.child}) : super(key: key);

  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: new Column(
         children: <Widget>[
           buildExpanded()
         ],
       )
    );
  }
  Expanded buildExpanded() {
    return new Expanded(
      child: new Container(
        color: new Color(0xFFFFD100),
        child: new CustomScrollView(
          scrollDirection: Axis.vertical,
          slivers: <Widget>[
            new SliverPadding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              sliver: new SliverFixedExtentList(
                itemExtent: 152.0,
                delegate: new SliverChildBuilderDelegate(
                  (context, index) => new ProductRow(drawerItems[drawerItems.length-index-1]),
                  childCount: drawerItems.length,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
class DrawerItems{
  Icon ico;
  String title;
  DrawerItems({this.title,this.ico});
}
final drawerItems = [
    new DrawerItems(ico: Icon(Icons.access_time),title: "POST 1"),
    new DrawerItems(ico: Icon(Icons.access_time),title: "POST 2"),
    new DrawerItems(ico: Icon(Icons.access_time),title: "POST 3"),
];