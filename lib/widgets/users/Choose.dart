import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticket_booking/widgets/adminSide/Dashboard.dart';
import 'package:ticket_booking/widgets/userSide/Home.dart';
import 'package:ticket_booking/widgets/users/Login.dart';
import 'package:ticket_booking/widgets/users/Register.dart';

class Choose extends StatefulWidget {
  const Choose({Key? key}) : super(key: key);

  @override
  _ChooseState createState() => _ChooseState();
}

class _ChooseState extends State<Choose> {
  @override
  Widget build(BuildContext context) {

    @override
    void initState() async{
      super.initState();
      SharedPreferences ref = await SharedPreferences.getInstance();
      var t = ref.getBool('login');
      var u = ref.getBool('admin');
      if(t == true){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home(),));
      }
      if(u == true){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Dashboard(),));
      }
    }

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MaterialButton(
                child: Text('Login', style: TextStyle(color: Colors.white)),
                color: Colors.blue,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Login(),
                      ));
                },
              ),
              MaterialButton(
                child: Text(
                  'Regitser',
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.blue,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Register(),
                      ));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
