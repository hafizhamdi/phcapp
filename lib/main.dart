import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:phcapp/callcard_detail.dart';

void main() {
  runApp(PhcApp());
}

class PhcApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => CallCardList(),
        '/callcarddetail': (context) => CallCardDetail()
      },
    );
    // home: );
  }
}

class CallCardList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple,
          title: Text("Call Cards"),
        ),
        body: ListView.separated(
          separatorBuilder: (context, index) => Divider(
            color: Colors.grey,
          ),
          itemCount: 2,
          itemBuilder: (context, index) => ListTile(
            title: Text("392020011"),
            subtitle: Text("26/03/2020, 2:59 PM"),
            leading: Icon(Icons.headset_mic),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.pushNamed(context, "/callcarddetail");
            },
          ),
        ));
  }
}
