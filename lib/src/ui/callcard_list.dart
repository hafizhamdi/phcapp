import 'package:flutter/material.dart';
import 'package:phcapp/src/ui/callcard_tabs.dart';
import 'package:phcapp/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import '../models/phc_model.dart';
import '../blocs/phc_bloc.dart';

import 'package:intl/intl.dart';

class CallcardList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bloc.fetchAllCallcards();
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Call Cards"),
        leading: Container(
            child: Switch(
          value: themeProvider.isLightTheme,
          onChanged: (val) {
            themeProvider.setThemeData = val;
          },
        )),
      ),
      body: StreamBuilder(
        stream: bloc.allCallcards,
        builder: (context, AsyncSnapshot<PhcModel> snapshot) {
          if (snapshot.hasData) {
            return _buildList(snapshot);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildList(AsyncSnapshot<PhcModel> snapshot) {
    return ListView.separated(
      itemCount: snapshot.data.callcards.length,
      separatorBuilder: (context, index) => Divider(
        color: Colors.grey,
      ),
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                  child: Text(
                snapshot.data.callcards[index].call_information.callcard_no,
              )),
              Text(
                DateFormat("d MMM, hh:mm aaa").format(snapshot
                    .data.callcards[index].call_information.call_received),
                style: TextStyle(color: Colors.grey, fontSize: 14),
              )
            ],
          ),
          subtitle:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <
                  Widget>[
            Row(children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(right: 6),
                  child: Icon(
                    Icons.person,
                    size: 16,
                  )),
              Text(snapshot.data.callcards[index].patients.length.toString() +
                  " Patients")
            ]),
            Container(
                padding: EdgeInsets.all(5),
                decoration: new BoxDecoration(
                    // color: Colo,
                    border: Border.all(width: 1.5, color: Colors.orange),
                    borderRadius: new BorderRadius.all(Radius.circular(5.0))),
                child: Text((snapshot
                            .data.callcards[index].call_information.plate_no !=
                        null)
                    ? snapshot.data.callcards[index].call_information.plate_no
                    : ""))
          ]),
          leading: Container(
              // alignment: Alignment.centerLeft,
              width: 70,
              height: 70,
              decoration: new BoxDecoration(
                color: Colors.orange,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.headset_mic)),
          // trailing: Icon(Icons.arrow_forward_ios),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CallcardTabs(
                          callcard_no: snapshot.data.callcards[index]
                              .call_information.callcard_no,
                          call_information:
                              snapshot.data.callcards[index].call_information,
                          response_team:
                              snapshot.data.callcards[index].response_team,
                          response_time:
                              snapshot.data.callcards[index].response_time,
                          patients: snapshot.data.callcards[index].patients,
                        )));
            // Navigator.pushNamed(context, "/callcarddetail");
          },
        );
      },
    );
  }
}
