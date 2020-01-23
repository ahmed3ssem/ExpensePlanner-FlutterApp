import 'package:expense_planner/model/transaction.dart';
import 'package:expense_planner/widget/chart.dart';
import 'package:expense_planner/widget/new_transaction.dart';
import 'package:expense_planner/widget/transaction_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Planner',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
            accentColor: Colors.amber
      ),
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
    /*Transaction(id: "t1", tittle: "New Mounth", amount: 300.0, date: DateTime.now()),
    Transaction(id: "t2", tittle: "Shoes", amount: 600.0, date: DateTime.now()),*/
  ];

  List<Transaction> get recentTransaction{
    return userTransaction.where((tx){
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewTransaction(String title , double amount,DateTime choosenDate)
  {
    final newTx = Transaction(id: DateTime.now().toString(),tittle: title,amount: amount,date: choosenDate);

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

  void deleteTransaction(String id)
  {
    setState(() {
      userTransaction.removeWhere((tx) => tx.id == id);
    });
  }
  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text('Expense Planner'),
      centerTitle: true,
    );
    return Scaffold(
        appBar: appBar,
        body: SingleChildScrollView(
          child: Column(children: <Widget>[
            Container(
              height: (MediaQuery.of(context).size.height - appBar.preferredSize.height - MediaQuery.of(context).padding.top) * 0.4,
              child:Chart(recentTransaction),
            ),
            Container(
              height: (MediaQuery.of(context).size.height - appBar.preferredSize.height - MediaQuery.of(context).padding.top) * 0.6,
              child:TransactionList(userTransaction,deleteTransaction) ,
            ),
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
