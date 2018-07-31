import 'package:bike_go/global.dart';
import 'package:bike_go/ride_finished.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class InRide extends StatefulWidget {
  InRide({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<InRide> {
  Color widgetcolor = Colors.greenAccent[400];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
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
        floatingActionButton: new StreamBuilder(
            stream: Firestore.instance.collection('stations').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const Text('Loading...');
              return new FloatingActionButton.extended(
                onPressed: () {
                  DocumentSnapshot ds = snapshot
                      .data.documents[stationIndex == 3 ? 0 : stationIndex + 1];
                  if (hasUsedQr) {
                    Firestore.instance.runTransaction((transaction) async {
                      DocumentSnapshot freshSnap =
                          await transaction.get(ds.reference);
                      await transaction.update(freshSnap.reference,
                          {'bike_count': freshSnap['bike_count'] + 1});
                    });
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RideFinishedPage()),
                  );
                },
                icon: Icon(Icons.local_parking),
                label: Text('Park'),
              );
            }),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: new CustomScrollView(
          slivers: <Widget>[
            new SliverAppBar(
              title: new Text(''),
              pinned: true,
              expandedHeight: 200.0,
              flexibleSpace: new FlexibleSpaceBar(
                  background: Image.asset('assets/map.jpg')),
            ),
            new SliverPadding(
              padding: new EdgeInsets.all(16.0),
              sliver: new SliverList(
                delegate: new SliverChildListDelegate([
                  new Column(
                    children: <Widget>[
                      Text(
                        'Ride in progress',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Divider(
                          height: 2.0,
                          color: Colors.grey,
                        ),
                      ),
                      ListTile(
                          leading: Icon(
                            Icons.access_time,
                            size: 36.0,
                          ),
                          title: Text(
                            "Time elapsed",
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                          subtitle: Text(
                            "10 min",
                            style: TextStyle(
                              //fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                              // color: Colors.greenAccent
                            ),
                          ),
                          onTap: () {/* react to the tile being tapped */}),
                      ListTile(
                          leading: Icon(Icons.directions_car, size: 36.0),
                          title: Text(
                            "Distance",
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                          subtitle: Text(
                            "5 km",
                            style: TextStyle(
                              fontSize: 15.0,
                            ),
                          ),
                          onTap: () {/* react to the tile being tapped */}),
                      ListTile(
                          leading: Icon(
                            Icons.timer,
                            size: 36.0,
                          ),
                          title: Text(
                            "Caloris burned",
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                          subtitle: Text(
                            "30 kcl",
                            style: TextStyle(
                              fontSize: 15.0,
                            ),
                          ),
                          onTap: () {/* react to the tile being tapped */}),
                      SizedBox(height: 20.0),
                    ],
                  ),
                ]),
              ),
            ),
          ],
        )
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
