import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FolderDetail extends StatefulWidget {
  final String folderName;

  const FolderDetail({Key key, this.folderName}) : super(key: key);

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
      body: Center(
        child: Text(this.widget.folderName),
      ),
    );
    
  }
}
