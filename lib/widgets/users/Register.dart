import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ticket_booking/widgets/users/Login.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController username= new TextEditingController();
  TextEditingController password= new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(19),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                        labelText: 'Username',
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),

                        )
                    ),
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

                        )
                    ),
                    controller: password,
                    obscureText: true,
                  ),
                ),
                MaterialButton(padding: EdgeInsets.all(15),color: Colors.blue,child: Text('Register',style: TextStyle(color: Colors.white),) ,onPressed:() async{
                  var data = await FirebaseFirestore.instance.collection('users').get();
                  for(int i=0;i<data.docs.length;i++){
                    if(data.docs[i].data()['username'] == username.text){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('User already registered with that username')));
                    }else{
                      await FirebaseFirestore.instance.collection('users').add({
                        'username':username.text,
                        'password':password.text,
                        'isAdmin':false
                      }).then((v){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('You are registered')));
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login(),));
                      });

                    }
                  }
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
