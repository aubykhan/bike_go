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
        title: Text('Pay'),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            Card(
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text('Bike Locked'),
                    trailing: Icon(Icons.check_circle, color: Colors.green),
                  ),
                  ListTile(
                    title: Text('Gadgets returned!'),
                    trailing: Icon(Icons.check_circle,color: Colors.green,),
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
                    trailing: Text('Rs. 30'),
                  ),
                  ListTile(
                    leading: Icon(Icons.directions_car),
                    title: Text('Distance'),
                    trailing: Text('12 km'),
                  )
                ],
              ),
            ),
            Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, top: 8.0),
                    child: Text(
                      'Congrats!',
                      style: Theme.of(context).textTheme.title,
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.fastfood),
                    title: Text('300 calories burned!'),
                  )
                ],
              ),
            )
          ],
          itemExtent: 160.0,
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 32.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: RaisedButton(
                color: Colors.red,
                onPressed: () => {},
                child: Text('Pay'),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
