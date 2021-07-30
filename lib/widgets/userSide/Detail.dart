import 'package:flutter/material.dart';
import 'package:ticket_booking/widgets/userSide/Buy.dart';

class Detail extends StatefulWidget {
  final String name;
  final String tickets;
  final String start;
  final String end;
  final String id;

  Detail(
      {Key? key,
      required this.name,
      required this.tickets,
      required this.start,
      required this.end,
      required this.id})
      : super(key: key);

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(15),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(widget.name,style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold
                ),),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Available Ticket : ' + widget.tickets),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Start Time : ' + widget.start),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('End Time : ' + widget.end),
              ),
              MaterialButton(
                child: Text('Buy Ticket',style: TextStyle(color: Colors.white),),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Buy(
                          id: widget.id,
                          start: widget.start,
                          end: widget.end,
                          tickets: widget.tickets,
                        ),
                      ));
                },
                color: Colors.blue,
              )
            ],
          ),
        ),
      ),
    );
  }
}
