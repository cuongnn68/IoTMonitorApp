import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About"),
      ),
      body: ListView(
        children: [
          Text(
            "App lam bang flutter + dart",
            style: TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
          Image.asset("images/flutter.jpeg"),
          Text(""),
          Text(""),
          Text(
            "Server lam bang dotnet 5",
            style: TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
          Image.asset("images/dotnet-5.jpg"),
        ],
      ),
    );
  }
}
