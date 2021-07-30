import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticket_booking/widgets/adminSide/AddEvent.dart';
import 'package:ticket_booking/widgets/users/Choose.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  void logout() async{
    SharedPreferences ref = await SharedPreferences.getInstance();
    await ref.setBool('login',false);
    await ref.setBool('admin',false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Container(),
          title: Text('Dashboard'),
          centerTitle: true,
          actions: [
            IconButton(onPressed: () {
              logout();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Choose(),));
            }, icon: Icon(Icons.logout))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddEvent(),
              )),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('events').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return snapshot.data!.docs.length > 0
                ? ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          title:
                              Text(snapshot.data!.docs[index].get('name') ?? ''),
                          tileColor: Colors.black12,
                          subtitle: Text(
                              snapshot.data!.docs[index].get('tickets').toString() ?? ''),
                          trailing: Text("Timings : "+snapshot.data!.docs[index].get('start')+' - '+snapshot.data!.docs[index].get('end'))
                        ),
                      );
                    })
                : Text('No data');
          },
        ));
  }
}
