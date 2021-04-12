import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
    "https://192.168.100.7:5001/images-api/folder/folder-1/image/test.png"
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
        title: Text(this.widget.folderName),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 1,
          crossAxisSpacing: 1,
        ), 
        itemBuilder: (context, i) => InkResponse(
          child: Image.network(this.widget.urls[i]),
          autofocus: true,
          onTap: () => Navigator.of(context)
                              .push(MaterialPageRoute(builder: (_) => Scaffold(
                                appBar: AppBar(backgroundColor: Colors.transparent,),
                                body: Center(child: Image.network(this.widget.urls[i])),
                                backgroundColor: Colors.black,
                              ))),
        ),
        itemCount: this.widget.urls.length,
        
      )
    );
    
  }
}
