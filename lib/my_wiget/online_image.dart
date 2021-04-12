import 'package:flutter/cupertino.dart';

class OnlineImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.network(
        // "https://192.168.100.7:5001/file/test-folder/mobile1.png",
        "https://192.168.100.7:5001/images-api/folder/test-folder/image/mobile1.png",
        // "https://i.imgur.com/EBMc4mW.jpg",
        fit: BoxFit.fill,
        errorBuilder:
            (BuildContext context, Object exception, StackTrace stackTrace) {
          return Text('errrrrrrrrrorrrrrrrrrrrrrrr'); // TODO: show error image
        },
      ),
    );
  }
}
