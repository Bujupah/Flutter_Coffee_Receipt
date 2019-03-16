import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:app/home.dart';

void main(){
  runApp(new MaterialApp(
    home: new MyApp(),
    theme: ThemeData(
      primaryColor: Colors.amber[300],
      iconTheme: IconThemeData(color: Colors.amber[300]),
      
    ),
    
  ));
}


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      seconds: 5,
      navigateAfterSeconds: new AfterSplash(),
      title: new Text('WIGO',
        style: new TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 40.0
          
        ),
      ),
      image: new Image.asset("assets/logo.png",repeat: ImageRepeat.noRepeat,fit: BoxFit.fill),
      backgroundColor: Colors.white,
      styleTextUnderTheLoader: new TextStyle(),
      photoSize: 150.0,
      onClick: ()=>print("Created by Khalil"),
      loaderColor: Colors.amber[300]
    );
  }
}

class AfterSplash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return HomePage();
  }
}
