import 'package:flutter/material.dart';
import 'login_page.dart';
import 'home_page.dart';
import 'barcode_page.dart';
import 'deviceinfo_page.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  final routes = <String, WidgetBuilder>{
    
    LoginPage.tag: (context) => LoginPage(),
    HomePage.tag: (context) => HomePage(),
    BarcodePage.tag: (context) => BarcodePage(),
    DeviceInfo.tag: (context) => DeviceInfo()
  };

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'login',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        fontFamily: 'Nunito',
      ),
      home: LoginPage(),
      routes: routes,
    );
  }
}
