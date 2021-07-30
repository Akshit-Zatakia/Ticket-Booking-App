import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Buy extends StatefulWidget {
  final String id;
  final String start;
  final String end;
  final String tickets;
  Buy({Key? key,required this.id,required this.start, required this.end,required this.tickets}) : super(key: key);

  @override
  _BuyState createState() => _BuyState();
}

class _BuyState extends State<Buy> {

  TextEditingController name = new TextEditingController();
  TextEditingController phone = new TextEditingController();

  String payment = 'card';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buy ticket'),
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all( 10),
          child: ListView(
            children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                        labelText: 'Name',
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        )),
                    controller: name,
                  ),
                ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                      labelText: 'Phone No',
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      )),
                  controller: phone,
                  keyboardType: TextInputType.number,
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Payment'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton(
                  value: payment,
                  icon:Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  onChanged: (String? value) {
                    setState(() {
                      payment = value!;
                    });
                  },
                  items: <String>['card','cash'].map<DropdownMenuItem<String>>((String val){
                    return DropdownMenuItem<String>(value: val,child: Text(val),);
                  }).toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MaterialButton(padding: EdgeInsets.all(15),child: Text('Buy',style: TextStyle(color: Colors.white),),color: Colors.blue ,onPressed: () {
                  FirebaseFirestore.instance.collection('events').doc(widget.id).collection('buyers').add({
                    'name':name.text,
                    'phone':phone.text,
                    'payment':payment
                  }).then((value) {
                    FirebaseFirestore.instance.collection('events').doc(widget.id).update({
                      'tickets': (int.parse(widget.tickets) - 1),
                    }).then((value){
                      Navigator.pop(context);
                      Navigator.pop(context);
                    });
                  });
                },),
              )
            ],
          ),
        ),
      ),
    );
  }
}
