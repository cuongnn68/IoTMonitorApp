import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iot_app/view/block_detail_page.dart';

import 'container_wrapper.dart';

class BlockInfo extends StatelessWidget {
  String id;
  String name;
  BlockInfo(this.id, this.name);
  @override
  Widget build(BuildContext context) {
    return DecoratedContainer(
      InkWell(
        onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => BlockDetailPage(id, name))),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(name), // TODO style
                InkWell(
                  onTap: () => {
                    // TODO change name
                  },
                  child: Icon(Icons.edit),
                ),
              ],
            ),
            Divider(
              thickness: 1,
            ),
            Wrap(
              alignment: WrapAlignment.spaceEvenly,
              children: [
                InsideDecoratedContainer(Text("light: ON"),),
                InsideDecoratedContainer(Text("temp 30`C"),),
                InsideDecoratedContainer(Text("hum 69"),),
                InsideDecoratedContainer(Text("ph ???"),),
              ],
            ),
            SizedBox(height: 12,)
          ],
        ),
      )
      
    );
  }
}