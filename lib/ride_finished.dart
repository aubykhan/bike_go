import 'package:bike_go/global.dart';
import 'package:flutter/material.dart';

class RideFinishedPage extends StatefulWidget {
  @override
  _RideFinishedPageState createState() => new _RideFinishedPageState();
}

class _RideFinishedPageState extends State<RideFinishedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Card(
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text(
                      'Bike Locked',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    trailing: Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 36.0,
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Gadgets returned!',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    trailing: Icon(
                      Icons.check_circle,
                      color: Colors.grey,
                      size: 36.0,
                    ),
                  )
                ],
              ),
            ),
            Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, top: 8.0),
                    child: Text(
                      'Payment summary',
                      style: Theme.of(context).textTheme.title,
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.attach_money),
                    title: Text('Fare'),
                    trailing: Text('PKR 30'),
                  ),
                  ListTile(
                    leading: Icon(Icons.directions_car),
                    title: Text('Time'),
                    trailing: Text('10 min'),
                  )
                ],
              ),
            ),
          ],
        ),
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async => await showDialog(
              context: context,
              builder: (context) => new AlertDialog(
                content: ListTile(
                      contentPadding: EdgeInsets.all(4.0),
                      leading: Icon(Icons.sentiment_satisfied),
                      title: Text('Thankyou!'),
                    ),
                actions: <Widget>[
                new FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.of(context).pushReplacementNamed(Routes.root);
                    },
                    child: const Text('OK'))
              ],
                  ),
            ),
        icon: Icon(Icons.monetization_on),
        label: Text('Pay'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
