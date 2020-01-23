import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget{
  final Function addTx;

  NewTransaction(this.addTx);
  @override
  NewTransactionState createState()=> NewTransactionState();
}

class NewTransactionState extends State<NewTransaction> {

  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime selectedDate;

  void submitData()
  {
    if(amountController.text.isEmpty){
      return;
    }
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text) ;
    if(enteredTitle.isEmpty||enteredAmount<=0||selectedDate==null)
      {
        return;
      }
    widget.addTx(enteredTitle,enteredAmount,selectedDate);
    
    Navigator.of(context).pop();
  }

  void _presentDatePicker()
  {
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime.now()
    ).then((pickedDate){
      if(pickedDate == null){
        return;
      }
      setState(() {
        selectedDate=pickedDate;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(top:10,
            left:10,
            right:10,
            bottom:MediaQuery.of(context).viewInsets.bottom+ 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(decoration: InputDecoration(labelText: "Title"),controller: titleController,onSubmitted:(_)=>submitData() ,),
              TextField(decoration: InputDecoration(labelText: "Amount"),keyboardType: TextInputType.number,controller: amountController,onSubmitted:(_)=>submitData()),
              Container(
                height: 70,
                child:Row(
                  children: <Widget>[
                    Expanded(
                      child:Text(selectedDate==null ? 'No Date Choosen' :'Picked Date: ${DateFormat.yMd().format(selectedDate)}'),
                    ),
                    FlatButton(
                        textColor: Theme.of(context).primaryColor,
                        onPressed: _presentDatePicker,
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
      ),
    );
  }
}
