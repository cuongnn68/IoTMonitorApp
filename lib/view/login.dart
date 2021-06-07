import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../home.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        // padding: EdgeInsets.all(60),
        child: Container(
          constraints: BoxConstraints(
            maxWidth: 300,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Big text hear"),
              TextField(
                // obscureText: false,
                decoration: InputDecoration(
                  labelText: "Username",
                ),
              ),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                ),
              ),
              Divider(height: 20,),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      child: Text("Login"),
                      onPressed: () { // TODO this and routing
                        // Navigator.of(context).pushReplacement(Home());
                        // Navigator.of(context).push();
                      }
                    ),
                  ),
                ],
              )
            ],
          ),
        )
        
        
        
      ),
    );
  }
}
