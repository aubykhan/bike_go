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
      theme: new ThemeData(
        primaryColor: _primaryColor,
        accentColor: _primaryColor,
        buttonColor: _primaryColor
      ),
    );
  }
}

class LocatorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("Bike 2 Go")),
      drawer: Drawer(
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
