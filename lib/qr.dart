import 'dart:async';

import 'package:bike_go/InRide.dart';
import 'package:bike_go/global.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
        title: new Text('Bike unlocks'),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(
              Icons.skip_next,
            ),
            onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InRide()),
                ),
          )
        ],
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
                    'Scan QR code on bike to unlock',
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
      floatingActionButton: new FloatingActionButton.extended(
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
          builder: (context) => new StreamBuilder(
              stream: Firestore.instance.collection('stations').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const Text('Loading...');
                return new AlertDialog(
                  title: Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: ListTile(
                      leading: Icon(Icons.directions_bike),
                      title: Text('Bike No.$barcode unlocked'),
                      subtitle: Text('Enjoy your ride!'),
                    ),
                  ),
                  actions: <Widget>[
                    new FlatButton(
                        onPressed: () {
                          DocumentSnapshot ds = snapshot.data.documents[stationIndex];
                          Firestore.instance
                              .runTransaction((transaction) async {
                            DocumentSnapshot freshSnap = await transaction
                                .get(ds.reference);
                            await transaction.update(freshSnap.reference,
                                {'bike_count': freshSnap['bike_count'] - 1});
                          });
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => InRide()),
                          );
                        },
                        child: const Text('OK'))
                  ],
                );
              }));
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
