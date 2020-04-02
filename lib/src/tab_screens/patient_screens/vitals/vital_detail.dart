import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phcapp/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class VitalDetail extends StatefulWidget {
  VitalDetail({Key key}) : super(key: key);

  @override
  _VitalDetailState createState() => _VitalDetailState();
}

class _VitalDetailState extends State<VitalDetail> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return ChangeNotifierProvider(
        builder: (_) => ThemeProvider(isLightTheme: true),
        child: Scaffold(
          // backgroundColor: Colors.grey[900],
          appBar: AppBar(
              title: Text(
                'Vital signs',
              ),
              backgroundColor: Colors.purple),
          body: SingleChildScrollView(
              child: Center(
                  child: Wrap(
            children: <Widget>[
              _buildItem("BP Systolic"),
              _buildItem("BP Diastolic"),
              _buildItem("MAP"),
              _buildItem("PR"),
              _buildItem("Pulse Pressure"),
              _buildItem("Pulse Volume"),
              _buildItem("CRT"),
              _buildItem("Shock Index"),
              _buildItem("RR"),
              _buildItem("Sp02"),
              _buildItem("temp"),
              _buildItem("EVM"),
              _buildItem("Pain Score"),
              _buildItem("Blood Glucose"),
              _buildItemPupil("Left Pupil"),
              _buildItemPupil("Right Pupil"),
              _buildItemGCS("GCS"),
            ],
          ))),
        ));
  }
}

Widget _buildItem(title) {
  return Card(
    color: Colors.white10,
    elevation: 2.4,
    child: Container(
        padding: EdgeInsets.only(left: 8, top: 8),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        width: 170,
        height: 100,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  title,
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "141.2",
                    style: TextStyle(fontSize: 40, color: Colors.purple[200]),
                  ),
                  IconButton(
                    icon: Icon(Icons.edit),
                    color: Colors.grey,
                    iconSize: 25,
                    onPressed: () {},
                  )
                ])
          ],
        )),
  );
}

Widget _buildItemPupil(title) {
  return Card(
    color: Colors.white10,
    elevation: 2.4,
    child: Container(
        padding: EdgeInsets.only(left: 8, top: 8),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        width: 170,
        height: 200,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  title,
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "8",
                    style: TextStyle(fontSize: 40, color: Colors.purple[200]),
                  ),
                  IconButton(
                    icon: Icon(Icons.edit),
                    color: Colors.grey,
                    iconSize: 25,
                    onPressed: () {},
                  )
                ]),
            Padding(
                padding: EdgeInsets.only(top: 10),
                child: Row(
                  children: <Widget>[
                    Text(
                      "Response to light",
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                )),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Sluggish",
                    style: TextStyle(fontSize: 25, color: Colors.purple[200]),
                  ),
                  IconButton(
                    icon: Icon(Icons.edit),
                    color: Colors.grey,
                    iconSize: 25,
                    onPressed: () {},
                  )
                ])
          ],
        )),
  );
}

Widget _buildItemGCS(title) {
  return Card(
    color: Colors.white10,
    elevation: 2.4,
    child: Container(
        padding: EdgeInsets.only(left: 8, top: 8),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        width: 170,
        height: 230,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  title,
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "E",
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    "4",
                    style: TextStyle(fontSize: 30, color: Colors.purple[200]),
                  ),
                  IconButton(
                    icon: Icon(Icons.edit),
                    color: Colors.grey,
                    iconSize: 25,
                    onPressed: () {},
                  )
                ]),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "V",
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    "4",
                    style: TextStyle(fontSize: 30, color: Colors.purple[200]),
                  ),
                  IconButton(
                    icon: Icon(Icons.edit),
                    color: Colors.grey,
                    iconSize: 25,
                    onPressed: () {},
                  )
                ]),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "M",
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    "5",
                    style: TextStyle(fontSize: 30, color: Colors.purple[200]),
                  ),
                  IconButton(
                    icon: Icon(Icons.edit),
                    color: Colors.grey,
                    iconSize: 25,
                    onPressed: () {},
                  )
                ]),
            Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Total",
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.white),
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        "13",
                        style:
                            TextStyle(fontSize: 30, color: Colors.purple[200]),
                      )),
                ])
          ],
        )),
  );
}
