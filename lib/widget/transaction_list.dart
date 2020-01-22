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
                elevation: 5,
                margin: EdgeInsets.symmetric(vertical: 8,horizontal: 5),
                  child:ListTile(
                    leading: CircleAvatar(
                        radius: 30,
                        child:Padding(
                          padding: EdgeInsets.all(6),
                          child: FittedBox(
                              child:Text('\$${userTransaction[index].amount}')),
                        )
                    ),
                    title: Text(userTransaction[index].tittle,style: Theme.of(context).textTheme.title,),
                    subtitle: Text(DateFormat.yMMMd().format(userTransaction[index].date)),
                  ),
              );
            },
            itemCount: userTransaction.length,
        )
    );
  }
}
