import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:iot_app/globals.dart' as global;
import 'package:signalr_core/signalr_core.dart';

class FolderDetail extends StatefulWidget {
  final String folderName;
  final urls = [
    "https://i.picsum.photos/id/846/1920/1080.jpg?hmac=rx55XDjKPLjmW5WdHBRqOphU4wZkLT5W3TC_WBdvyVY",
    "https://i.picsum.photos/id/1032/1920/1080.jpg?hmac=7wpVjpyV-lhmJZlnDWBHdkZpi6cZe52ixlp93aeB-Zo",
    "https://i.picsum.photos/id/671/1920/1080.jpg?hmac=CxdJymHXpEZxgxKDkJdt4ytqN-sa7xQL2j0ApTRzMo0",
    "https://i.picsum.photos/id/1011/1920/1080.jpg?hmac=b2iizlTf2rgEJwS1gra9dXuAbBbP8hb-Ss3WiGSKffE",
    "https://i.picsum.photos/id/90/1920/1080.jpg?hmac=ByhHZw9aMsbOV_LhjHJseKM1qlEZRn1yuwBq_-obtWo",
    "https://i.picsum.photos/id/413/1920/1080.jpg?hmac=DTdv_AxnEpp5KQFgpzmi1Ayxj6VLuwonto7bsjVDx9U",
    "https://i.picsum.photos/id/757/1920/1080.jpg?hmac=2lExxUlIL9Sr4cR2hPzdBO2zFrCErrqss_XsJHgp5YQ",
  ];

  // TODO: get info of folder from server
  // TODO: get image from server

  FolderDetail({Key key, this.folderName}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FolderDetailState();
}

class _FolderDetailState extends State<FolderDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(this.widget.folderName),
      ),
      body: FutureBuilder(
        future: _getImageList(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<String> listImage = snapshot.data;
            var listImageUrl = (snapshot.data as List<String>)
                .map((e) => Uri.https(global.url,
                        "/images-api/folder/${this.widget.folderName}/image/$e")
                    .toString())
                .toList();
            return GridView.builder(
                  itemCount: listImageUrl.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 0.3,
                    crossAxisSpacing: 0.3, //TODO test this image view
                  ),
                  itemBuilder: (context, i) => GestureDetector(
                        child: Hero(
                          child: Image.network(listImageUrl[i]),
                          tag: listImage[i],
                        ),
                        onTap: () =>
                            Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Scaffold(
                            appBar: AppBar(
                              centerTitle: true,
                              title: Text(listImage[i]),
                              // backgroundColor: Colors.transparent,
                            ),
                            body: Center(
                              child: Hero(
                                child: Image.network(listImageUrl[i]),
                                tag: listImage[i],
                              ),
                            ),
                            backgroundColor: Colors.white,
                          ),
                        )),
                      ),
            );
          }
          return Center(child: CircularProgressIndicator());
        }),
    );
    
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text(this.widget.folderName),
    //   ),
    //   body: GridView.builder(
    //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //       crossAxisCount: 3,
    //       mainAxisSpacing: 1,
    //       crossAxisSpacing: 1,
    //     ),
    //     itemBuilder: (context, i) => InkResponse(
    //       child: Image.network(this.widget.urls[i]),

    //       onTap: () => Navigator.of(context)
    //                           .push(MaterialPageRoute(builder: (_) => Scaffold(
    //                             appBar: AppBar(backgroundColor: Colors.transparent,),
    //                             body: Center(child: Image.network(this.widget.urls[i])),
    //                             backgroundColor: Colors.black,
    //                           ))),
    //     ),
    //     itemCount: this.widget.urls.length,

    //   )
    // );
  }

  Future<List<String>> _getImageList() async {
    var url = Uri.https(
        global.url, "/images-api/folder/${this.widget.folderName}/image");
    var res = await get(url);
    if (res.statusCode >= 200 && res.statusCode < 400) {
      var jsonResult = jsonDecode(res.body);
      return List<String>.from(jsonResult["files"]);
    } else {
      return List<String>.empty();
    }
  }
}
