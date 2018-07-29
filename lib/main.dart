import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(new BikeGo());
}

class BikeGo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Bike 2 Go",
      home: new LocatorPage(),
    );
  }
}

class LocatorPage extends StatefulWidget {
  @override
  LocatorPageState createState() {
    return new LocatorPageState();
  }
}

class LocatorPageState extends State<LocatorPage> {
  final String title;

  bool bike_status = false;

  _checkAvailability(DocumentSnapshot document) {
    int bike_count;
    Firestore.instance.runTransaction((transaction) async {
      DocumentSnapshot freshSnap = await transaction.get(document.reference);
      bike_count = freshSnap['bike_count'];
    });
    if (bike_count > 0) {
      setState(() {
        bike_status = true;
      });
    } else {
      setState(() {
        bike_status = false;
      });
    }
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
    return new ListTile(
      key: new ValueKey(document.documentID),
      title: new Container(
        decoration: new BoxDecoration(
          border: new Border.all(color: const Color(0x80000000)),
          borderRadius: new BorderRadius.circular(5.0),
        ),
        padding: const EdgeInsets.all(10.0),
        child: new Row(
          children: <Widget>[
            new Expanded(
              child: new Text(document['sn']),
            ),
            new Text(
              document['bike_count'].toString(),
            ),
          ],
        ),
      ),
      onTap: () => _checkAvailability(document),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("Bike 2 Go")),
      body: new StreamBuilder(
          stream: Firestore.instance.collection('stations').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const Text('Loading...');
            return Column(
              children: <Widget>[
                Expanded(
                  child: new ListView.builder(
                    itemCount: snapshot.data.documents.length,
                    padding: const EdgeInsets.only(top: 10.0),
                    itemExtent: 55.0,
                    itemBuilder: (context, index) =>
                        _buildListItem(context, snapshot.data.documents[index]),
                  ),
                ),
                RaisedButton(
                  onPressed:  bike_status ? () => {} : null,
                  child: Text('Proceed to unlock'),
                )
              ],
            );
          }),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the Drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Profile', style: new TextStyle(fontSize: 24.0)),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              leading: new Icon(Icons.account_box),
              title: Text('Login'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: new Icon(Icons.settings),
              title: Text('Setting'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
