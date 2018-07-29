import 'dart:async';

import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';

class QrScanPage extends StatefulWidget {
  @override
  _QrScanPageState createState() => new _QrScanPageState();
}

class _QrScanPageState extends State<QrScanPage> {
  String barcode = "";

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Bike unlock'),
      ),
      body: new Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 64.0),
            child: Icon(
              Icons.directions_bike,
              size: 200.0,
              color: Colors.grey,
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: Column(
                children: <Widget>[
                  Text(
                    'Scan a QR code to unlock a bike',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        hasNotch: false,
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new IconButton(
              icon: new Icon(
                Icons.menu,
                color: Colors.transparent,
              ),
              onPressed: () => {},
            ),
            new IconButton(
              icon: new Icon(
                Icons.apps,
                color: Colors.transparent,
              ),
              onPressed: () => {},
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: scan,
        icon: Icon(Icons.center_focus_strong),
        label: Text('Scan'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      setState(() => this.barcode = barcode);
      await showDialog(
        context: context,
        builder: (context) => new AlertDialog(
              title: ListTile(
                leading: Icon(Icons.directions_bike),
                title: Text('Bike $barcode unlocked!'),
                subtitle: Text('Enjoy your ride!'),
              ),
              actions: <Widget>[
                new FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('OK'))
              ],
            ),
      );
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.barcode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => this.barcode = 'Unknown error: $e');
      }
    } on FormatException {
      setState(() => this.barcode =
          'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
  }
}
