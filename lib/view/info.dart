import 'package:flutter/cupertino.dart';

class Info extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "App lam bang flutter + dart",
          style: TextStyle(fontSize: 20),
        ),
        Image.asset("images/flutter.jpeg"),
        Text(""),
        Text(""),
        Text(
          "Server lam bang dotnet 5",
          style: TextStyle(fontSize: 20),
        ),
        Image.asset("images/dotnet-5.jpg"),
      ],
    );
  }
}
