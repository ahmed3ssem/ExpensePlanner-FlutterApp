import 'package:expense_planner/transaction.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {

  final List<Transaction> transaction = [
    Transaction(id: "t1",tittle: "New Mounth",amount: 3000.0,date: DateTime.now()),
    Transaction(id: "t2",tittle: "Shoes",amount: 600.0,date: DateTime.now()),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Flutter App'),
        ),
        body: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
            child:Card(
              color: Colors.blue,
              child: Text("Chart"),
              elevation: 5,
            ),
            ),
            Card(
              child: Text("List Of TX"),
            )
          ],
        ));
  }
}
