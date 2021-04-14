import 'dart:convert';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:iot_app/globals.dart' as globals;
import 'package:iot_app/my_wiget/folder_detail.dart';

class ImageView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  final _url = globals.url;

  // Future<List<dynamic>> _jsonRes;

  List<String> _folderNames;
  // List<Widget> _folderWiget;

  // List<String> folderUrls;

  @override
  void initState() {
    super.initState();
    getFolders();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getFolders(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          _folderNames = List<String>.from(snapshot.data);
          return ListView.separated(
              itemBuilder: (context, i) => ListTile(
                title: Text(_folderNames[i]),
                onTap: () => {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) =>  FolderDetail(folderName: _folderNames[i],)))
                },
              ),
              separatorBuilder: (context, int) => Divider(),
              itemCount: _folderNames.length);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        // By default, show a loading spinner.
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Future<dynamic> getFolders() async {
    var uri = Uri.https(this._url, "/images-api/folder");
    var res = await http.get(uri);
    if (res.statusCode >= 200 && res.statusCode < 400) {
      final jsonResult = jsonDecode(res.body);
      return jsonResult["folders"];
    } else {
      throw Exception("cant get data from server");
    }
  }
}
