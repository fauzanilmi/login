import 'dart:async';
import 'barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BarcodePage extends StatefulWidget {
  static String tag = 'barcode-page';
  @override
  _BarcodePageState createState() => new _BarcodePageState();
}

class _BarcodePageState extends State<BarcodePage> {
  
  String barcode = "";
  @override
    void initState() {
      super.initState();
      scan();
    }

  @override
  Widget build(BuildContext context) {
    return new  Scaffold(
        appBar: new AppBar(
          title: new Text(
              'Barcode'),
        ),
              backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
          new Text(barcode),
          ],
        ),
      ),
    );
  }

  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      setState(() => this.barcode = barcode);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.barcode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => this.barcode = 'Unknown error: $e');
      }
    } on FormatException{
      setState(() => this.barcode = 'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
  }

}

