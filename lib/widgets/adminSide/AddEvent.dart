import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddEvent extends StatefulWidget {
  const AddEvent({Key? key}) : super(key: key);

  @override
  _AddEventState createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  TextEditingController name = new TextEditingController();
  TextEditingController tickets = new TextEditingController();
  TextEditingController start = new TextEditingController();
  TextEditingController end = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add event'),
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                      labelText: 'Name',
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),

                      )
                  ),
                  controller: name,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                      labelText: 'Available Tickets',
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),

                      )
                  ),
                  controller: tickets,
                  keyboardType: TextInputType.number,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                      labelText: 'Start time',
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),

                      )
                  ),
                  controller: start,
                  keyboardType: TextInputType.datetime,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                      labelText: 'End time',
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),

                      )
                  ),
                  controller: end,
                  keyboardType: TextInputType.datetime,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MaterialButton(padding: EdgeInsets.all(15),child: Text('Add',style:TextStyle(color: Colors.white)),color: Colors.blue,onPressed: () {
                    FirebaseFirestore.instance.collection('events').add({
                      'name':name.text,
                      'tickets':tickets.text,
                      'start':start.text,
                      'end':end.text
                    }).then((value) {
                      Navigator.pop(context);
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
