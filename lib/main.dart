import 'package:bike_go/global.dart';
import 'package:bike_go/qr.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(new BikeGo());
}

class BikeGo extends StatelessWidget {
  Color _primaryColor = Color.fromARGB(255, 58, 175, 185);
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Bike 2 Go",
      home: new LocatorPage(),
      routes: {
        Routes.qr: (context) => new QrScanPage(),
      },
      theme: new ThemeData(
          primaryColor: _primaryColor,
          accentColor: _primaryColor,
          buttonColor: _primaryColor),
    );
  }
}

class HomePage {}

class LocatorPage extends StatefulWidget {
  @override
  LocatorPageState createState() {
    return new LocatorPageState();
  }
}

class LocatorPageState extends State<LocatorPage> {

  bool bikeStatus = false;

  _checkAvailability(DocumentSnapshot document) {
    int bikeCount = 0;
    bikeCount = document.data['bike_count'];
    if (bikeCount > 0) {
      setState(() {
        bikeStatus = true;
      });
    } else {
      setState(() {
        print("bikeCount setsmaller");
        bikeStatus = false;
      });
    }

    if (bikeStatus) {
      showModalBottomSheet(
          context: context,
          builder: (context) => Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text('What do you want to do?',
                        style: Theme.of(context).textTheme.title),
                    SizedBox(
                      height: 16.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        OutlineButton.icon(
                          borderSide: BorderSide(
                              color: Theme.of(context).accentColor, width: 4.0),
                          shape: StadiumBorder(),
                          textColor: Theme.of(context).primaryColor,
                          icon: Icon(
                            Icons.navigation,
                            color: Theme.of(context).primaryColor,
                          ),
                          label: const Text('Navigate'),
                          onPressed: () async => await showDialog(
                                context: context,
                                builder: (context) => new AlertDialog(
                                      title:ListTile(
                                          contentPadding: EdgeInsets.all(4.0),
                                          leading: Icon(Icons.warning),
                                          title: Text('Coming soon...'),
                                          subtitle: Text(
                                              'This feature is under construction.'),
                                        ),
                                      
                                    ),
                              ),
                        ),
                        OutlineButton.icon(
                          borderSide: BorderSide(
                              color: Theme.of(context).accentColor, width: 4.0),
                          shape: StadiumBorder(),
                          textColor: Theme.of(context).primaryColor,
                          icon: Icon(
                            Icons.lock_open,
                            color: Theme.of(context).primaryColor,
                          ),
                          label: const Text('Unlock'),
                          onPressed: () =>
                              Navigator.pushNamed(context, Routes.qr),
                        ),
                      ],
                    ),
                  ],
                ),
              ));
    }
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot document, int index) {
    int bikeCount = document['bike_count'];
    Color color = bikeCount > 0 ? Colors.green : Colors.red;

    return Card(
      child: new ListTile(
        key: new ValueKey(document.documentID),
        title: new Text('Station #${document['sn']}'),
        subtitle: Text(document['address']),
        trailing: Column(
          children: <Widget>[
            Icon(
              Icons.directions_bike,
              color: color,
            ),
            new Text(
              bikeCount.toString(),
              style: TextStyle(color: color),
            ),
          ],
        ),
        onTap: ()  
        {
          stationIndex = index;
          _checkAvailability(document);
          }
      ),
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
            return new ListView.builder(
              itemCount: snapshot.data.documents.length,
              padding: const EdgeInsets.only(top: 10.0),
              itemBuilder: (context, index) =>
                  _buildListItem(context, snapshot.data.documents[index], index),
            );
          }),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Profile', style: new TextStyle(fontSize: 24.0)),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
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
