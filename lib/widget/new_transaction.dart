import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget{
  final Function addTx;

  NewTransaction(this.addTx);
  @override
  NewTransactionState createState()=> NewTransactionState();
}

class NewTransactionState extends State<NewTransaction> {


  final titleController = TextEditingController();
  final amountController = TextEditingController();

  void submitData()
  {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text) ;
    if(enteredTitle.isEmpty||enteredAmount<=0)
      {
        return;
      }
    widget.addTx(enteredTitle,enteredAmount);
    
    Navigator.of(context).pop();
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(decoration: InputDecoration(labelText: "Title"),controller: titleController,onSubmitted:(_)=>submitData() ,),
            TextField(decoration: InputDecoration(labelText: "Amount"),keyboardType: TextInputType.number,controller: amountController,onSubmitted:(_)=>submitData()),
            Container(
              height: 70,
              child:Row(
                children: <Widget>[
                  Text('No Date Choosen'),
                  FlatButton(
                      textColor: Theme.of(context).primaryColor,
                      onPressed: (){},
                      child: Text('Choose Date',style: TextStyle(fontWeight: FontWeight.bold),)
                  ),
                ],
              ),
            ),
            RaisedButton(
              color: Theme.of(context).primaryColor,
              child: Text('Save'),textColor: Colors.white,onPressed:submitData,)
          ],
        ),
      ),
    );
  }
}
