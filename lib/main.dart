import 'package:expense_planner/model/transaction.dart';
import 'package:expense_planner/widget/chart.dart';
import 'package:expense_planner/widget/new_transaction.dart';
import 'package:expense_planner/widget/transaction_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

void main(){
  //SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

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

  bool showChart = false;
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Show Chart"),
                Switch(
                    value: showChart,
                    onChanged: (val){
                      showChart = val;
                    }
                ),
              ],
            ),
            showChart ? Container(
              height: (MediaQuery.of(context).size.height - appBar.preferredSize.height - MediaQuery.of(context).padding.top) * 0.7,
              child:Chart(recentTransaction),
            )
            : Container(
              height: (MediaQuery.of(context).size.height - appBar.preferredSize.height - MediaQuery.of(context).padding.top) * 0.7,
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
/*

Working with the "textScaleFactor"
In this course, I mostly focus on the device sizes (height and width) when it comes to working with the MediaQuery class.

As mentioned, it offers way more than that of course. On particularly interesting property is the textScaleFactor property:

final curScaleFactor = MediaQuery.of(context).textScaleFactor;
textScaleFactor tells you by how much text output in the app should be scaled. Users can change this in their mobile phone / device settings.

Depending on your app, you might want to consider using this piece of information when setting font sizes.

Consider this example:

Text('Always the same size!', style: TextStyle(fontSize: 20));
This text ALWAYS has a size of 20 device pixels, no matter what the user changed in his / her device settings.

Text('This changes!', style: TextStyle(fontSize: 20 * curScaleFactor));
This text on the other hand also has a size of 20 if the user didn't change anything in the settings (because textScaleFactor by default is 1). But if changes were made, the font size of this text respects the user settings.*/
