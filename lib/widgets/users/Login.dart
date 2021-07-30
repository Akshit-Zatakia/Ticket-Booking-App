import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticket_booking/widgets/adminSide/Dashboard.dart';
import 'package:ticket_booking/widgets/userSide/Home.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController username = new TextEditingController();
  TextEditingController password = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(19),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: 'Username',
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    )),
                controller: username,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                    labelText: 'Password',
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    )),
                controller: password,
                obscureText: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MaterialButton(
                  padding: EdgeInsets.all(15),
                  color: Colors.blue,
                  child: Text(
                    'login',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    QuerySnapshot data = await FirebaseFirestore.instance
                        .collection('users')
                        .get();
                    if (data.docs.length == 0) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Not registered')));
                    }
                    for (int i = 0; i < data.docs.length; i++) {
                      if (username.text == data.docs[i]['username'] &&
                          password.text == data.docs[i]['password']) {
                        SharedPreferences ref =
                            await SharedPreferences.getInstance();

                        if (data.docs[i]['isAdmin'] == true) {
                          await ref.setBool('admin', true);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Dashboard(),
                              ));
                        } else {
                          await ref.setBool('login', true);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Home(),
                              ));
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Not registered')));
                      }
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}
