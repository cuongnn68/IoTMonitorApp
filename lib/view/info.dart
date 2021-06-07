import 'package:flutter/cupertino.dart';

// TODO user info

class Info extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      
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
    );
  }
}
