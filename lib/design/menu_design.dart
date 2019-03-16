import 'package:flutter/material.dart';
import '../main_menu.dart';


class ProductRow extends StatelessWidget {

  final DrawerItems product;

  ProductRow(this.product);

  @override
  Widget build(BuildContext context) {
    final productThumbnail = new Container(
                              margin: new EdgeInsets.symmetric(
                                vertical: 16.0
                              ),
                              alignment: FractionalOffset.centerLeft,
                            );

    final baseTextStyle = const TextStyle(
    );

    final regularTextStyle = baseTextStyle.copyWith(
      color: Colors.amber[300],
      fontSize: 14.0,
      fontWeight: FontWeight.w400
    );
    final timeTextStyle = baseTextStyle.copyWith(

      color: Colors.amber[300],
      fontSize: 20.0,
      fontWeight: FontWeight.w400
    );


    final headerTextStyle = baseTextStyle.copyWith(
      color: Colors.amber,
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
    );

    Widget _productValue({String key,String value}) {
      return new Row(
        children: <Widget>[
          new Container(width: 2.0),
          new Text(key, style: regularTextStyle),
          
          new Text(value, style:regularTextStyle,textAlign: TextAlign.center,),
        ]
      );
    }


    final productCardContent = new Container(
      margin: new EdgeInsets.fromLTRB(32.0, 16.0, 16.0, 16.0),
      constraints: new BoxConstraints.expand(),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          new Container(height: 5.0),
          new Text(product.title, style: headerTextStyle,textAlign: TextAlign.center,),
          new Container(height: 5.0),
          new Row(
            children: <Widget>[          
              new Text("Time:",style:timeTextStyle),
              new Spacer(),
              new Icon(product.ico.icon,size: 60,),
            ],
          ),
        ],
      ),
    );


    final productCard = new Container(
      child: productCardContent,
      height: 124.0,
      decoration: new BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: new BorderRadius.circular(8.0),
        boxShadow: <BoxShadow>[
          new BoxShadow(
            color: Colors.white,
            blurRadius: 5.0,
            offset: new Offset(0.0, 10.0),
          ),
        ],
      ),
    );


    return new Container(
      height: 128.0,
      margin: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 24.0,
      ),
      child: new Stack(
        children: <Widget>[
          productCard,
          productThumbnail,
        ],
      )
    );
  }
}