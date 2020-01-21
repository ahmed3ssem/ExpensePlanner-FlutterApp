import 'package:expense_planner/model/transaction.dart';
import 'package:expense_planner/widget/new_transaction.dart';
import 'package:expense_planner/widget/transaction_list.dart';
import 'package:flutter/material.dart';

class UserTransaction extends StatefulWidget {
  @override
  _UserTransactionState createState() => _UserTransactionState();
}

class _UserTransactionState extends State<UserTransaction> {

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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        NewTransaction(_addNewTransaction),
        TransactionList(userTransaction)
      ],
    );
  }
}
