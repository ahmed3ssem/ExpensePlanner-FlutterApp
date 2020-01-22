import 'package:expense_planner/model/transaction.dart';
import 'package:expense_planner/widget/new_transaction.dart';
import 'package:expense_planner/widget/transaction_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget{
  @override
  MyHomePageState createState()=> MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {

  final titleController = TextEditingController();
  final amountController = TextEditingController();

  final List<Transaction> userTransaction = [
    Transaction(id: "t1", tittle: "New Mounth", amount: 300.0, date: DateTime.now()),
    Transaction(id: "t2", tittle: "Shoes", amount: 600.0, date: DateTime.now()),
  ];

  void _addNewTransaction(String title , double amount)
  {
    final newTx = Transaction(id: DateTime.now().toString(),tittle: title,amount: amount,date: DateTime.now());

    setState(() {
      userTransaction.add(newTx);
    });
  }


  void startAddNewTransaction(BuildContext context)
  {
    showModalBottomSheet(context:context, builder: (_){
      //when click on any empty space , the add dialog will disapper
      return GestureDetector(
        onTap: (){},
        child: NewTransaction(_addNewTransaction),
        behavior: HitTestBehavior.opaque,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Expense Planner'),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.add),
                onPressed: (){})
          ],
        ),
        body: SingleChildScrollView(
          child: Column(children: <Widget>[
            Container(
              width: double.infinity,
              child: Card(
                color: Colors.blue,
                child: Text("Chart"),
                elevation: 5,
              ),
            ),
            TransactionList(userTransaction)
          ],),
        ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: ()=>startAddNewTransaction(context),
      ),
    );
  }
}
