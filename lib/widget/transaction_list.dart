import 'package:expense_planner/model/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> userTransaction;

  TransactionList(this.userTransaction);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
        child:userTransaction.isEmpty?
            Column(
              children: <Widget>[
                Text("No transactions added yet",style: Theme.of(context).textTheme.title,),
                SizedBox(height: 10,),
                Container(
                  height: 200,
                 child:Image.asset("assets/images/waiting.png",fit: BoxFit.cover,),
                )
              ],
            )
        :ListView.builder(
            itemBuilder: (context,index){
               return Card(
                child: Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Theme.of(context).primaryColor, width: 2)),
                      padding: EdgeInsets.all(10),
                      child: Text(
                        '\$${userTransaction[index].amount.toStringAsFixed(2)}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Theme.of(context).primaryColor),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          userTransaction[index].tittle,
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          DateFormat.yMMMd().format(userTransaction[index].date),
                          //DateFormat('yyyy-MM-dd').format(tx.date)
                          style: TextStyle(color: Colors.grey),
                        )
                      ],
                    )
                  ],
                ),
              );
            },
            itemCount: userTransaction.length,
        )
    );
  }
}
