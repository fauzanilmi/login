import 'package:flutter/material.dart';
import 'package:login/barcode_page.dart';
import 'package:login/deviceinfo_page.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
// import 'package:login/login_page.dart';

class HomePage extends StatefulWidget{
  static String tag = 'home=page';  
_HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _ipAddress = '0.0.0.0';
  final httpClient = new Client();
  final url = 'https://httpbin.org/ip';
  
   String barcode = "";
  @override
    void initState() {
      super.initState();
      _getIPAddressUsingFuture();
    }
  
  _getIPAddressUsingFuture() {
    Future<Response> response = httpClient.get(url);
    response.then((value) {
      setState(() {
        _ipAddress = JSON.decode(value.body)['origin'];
      });
    }).catchError((error) => print(error));
  }
  
  _getIPAdressUsingAwait() async{
    var response = await httpClient.read(url);
    var ip = JSON.decode(response)['origin'];
    setState((){
      _ipAddress =ip;
    });
  }

  @override
  Widget build(BuildContext context){
    


    final welcome = Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Welcome User',
            style: TextStyle(fontSize: 28.0, color: Colors.white),
          ),
        );


    final scanButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        shadowColor: Colors.lightBlueAccent.shade100,
        elevation: 5.0,
        child: MaterialButton(
          minWidth: 200.0,
          height: 42.0,
          onPressed: (){
              Navigator.of(context).pushNamed(BarcodePage.tag);
              
          },
          color: Colors.lightBlueAccent,
          child: Text('Scan Barcode', style: TextStyle(color: Colors.white)),
        ),
      ),
    );



    final deviceinfoButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        shadowColor: Colors.lightBlueAccent.shade100,
        elevation: 5.0,
        child: MaterialButton(
          minWidth: 200.0,
          height: 42.0,
          onPressed: (){
            Navigator.of(context).pushNamed(DeviceInfo.tag);
        },
          color: Colors.lightBlueAccent,
          child: Text('Device Info', style: TextStyle(color: Colors.white)),
        ),
      ),
    );

  
    final checkip = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        shadowColor: Colors.lightBlueAccent.shade100,
        elevation: 5.0,
        child: MaterialButton(
          
          minWidth: 200.0,
          height: 42.0,
          onPressed: _getIPAddressUsingFuture,
          color: Colors.lightBlueAccent,
          child: Text('Check My Ip', style: TextStyle(color: Colors.white)),
        ),
      ),
     
    );

    final ip = Padding(
      padding: EdgeInsets.all(8.0),
        child: Text('IP anda saat ini adalah : $_ipAddress',
        style: TextStyle(fontSize: 16.0, color: Colors.white),
      ),
    );


    final body = Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(28.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Colors.blue,
          Colors.lightBlueAccent,
        ])
      ),
      child: Column(
        children: <Widget>[welcome, scanButton, deviceinfoButton, checkip, ip],
      ),
    );

    return Scaffold(
      body: body,
    );
  }
}