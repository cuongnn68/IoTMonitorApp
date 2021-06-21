import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iot_app/view/block_detail_page.dart';

import 'container_wrapper.dart';

class BlockInfo extends StatelessWidget {
  int id;
  String name;
  bool hasLight = false;
  bool hasTemp = false;
  bool hasHumi = false;
  bool lightState = false;
  int temp = 0;
  int humi = 0;
  BlockInfo(this.id, this.name, {this.hasLight, this.hasTemp, this.hasHumi, this.lightState, this.temp, this.humi});
  @override
  Widget build(BuildContext context) {
    return DecoratedContainer(InkWell(
      onTap: () => Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => BlockDetailPage(id, name, hasLight, hasTemp, hasHumi))),
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
              if(this.hasLight) InsideDecoratedContainer(
                Text("light: " + (this.lightState ? "ON" : "OFF")),
              ),
              if(this.hasTemp) InsideDecoratedContainer(
                Text("temp: ${this.temp} ℃"),
              ),
              if(this.hasHumi) InsideDecoratedContainer(
                Text("hum ${this.humi} %"),
              ),
              // InsideDecoratedContainer(
              //   Text("ph ???"),
              // ),
            ],
          ),
          SizedBox(
            height: 12,
          )
        ],
      ),
    ));
  }
}
