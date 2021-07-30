import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticket_booking/widgets/userSide/Detail.dart';
import 'package:ticket_booking/widgets/users/Choose.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  void logout() async{
    SharedPreferences ref = await SharedPreferences.getInstance();
    await ref.setBool('login',false);
    await ref.setBool('admin',false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Home'),
          actions: [
            IconButton(onPressed: () {
              logout();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Choose(),));
            }, icon: Icon(Icons.logout))
          ],
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
                          trailing: Text("Timings : "+snapshot.data!.docs[index].get('start') +
                              ' - ' +
                              snapshot.data!.docs[index].get('end')),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Detail(
                                      name:
                                          snapshot.data!.docs[index].get('name'),
                                      tickets: snapshot.data!.docs[index]
                                          .get('tickets').toString(),
                                      start:
                                          snapshot.data!.docs[index].get('start'),
                                      end: snapshot.data!.docs[index].get('end'),
                                      id: snapshot.data!.docs[index].id),
                                ));
                          },
                        ),
                      );
                    })
                : Text('No data');
          },
        ));
  }
}
