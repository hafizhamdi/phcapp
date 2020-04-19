import 'package:flutter/material.dart';
import 'package:phcapp/src/events/phc_event.dart';
import 'package:phcapp/src/models/phc.dart';
// import 'package:phcapp/src/events/phc_event.dart';
import 'package:phcapp/src/ui/callcard_tabs.dart';
import 'package:phcapp/theme/theme_provider.dart';
import 'package:provider/provider.dart';
// import '../models/phc_model.dart';
import '../blocs/phc_bloc.dart';

import 'package:intl/intl.dart';

class CallcardList extends StatefulWidget {
  _CallcardList createState() => _CallcardList();
}

class _CallcardList extends State<CallcardList> {
  @override
  void initState() {
    super.initState();
    
    // bloc.fetchAllCallcards();
    // _phcBloc = BlocProvider.of<PhcBloc>(context);
    // _phcBloc.distinct(LoadEventPhc());
  }

  @override
  Widget build(BuildContext context) {
    // bloc.fetchAllCallcards();
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
        body: _buildBody());
  }

  Widget _buildBody() {
    return StreamBuilder(
      // stream: bloc.allCallcards,
      builder: (context, AsyncSnapshot<Phc> snapshot) {
        if (snapshot.hasData) {
          return _buildList(snapshot);
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  // Widget _buildBody2() {
  //   return BlocBuilder(
  //     bloc: _phcBloc,
  //     builder: (BuildContext context, PhcState state) {
  //       if (state is PhcStateLoading) {
  //         return Center(child: CircularProgressIndicator());
  //       } else if (state is PhcStateLoaded) {
  //         return _buildList(state);
  //       }
  //       // else return
  //     },
  //   );
  // }

  Widget _buildList(AsyncSnapshot snapshot) {
    return ListView.separated(
      itemCount: snapshot.data.listCallcards.length,
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
                snapshot.data.listCallcards[index].call_information.callcard_no,
              )),
              Text(
                DateFormat("d MMM, hh:mm aaa").format(DateTime.parse(snapshot
                    .data.listCallcards[index].call_information.call_received)),
                style: TextStyle(color: Colors.grey, fontSize: 14),
              )
            ],
          ),
          subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(right: 6),
                      child: Icon(
                        Icons.person,
                        size: 16,
                      )),
                  Text(snapshot.data.listCallcards[index].patients.length
                          .toString() +
                      " Patients")
                ]),
                Container(
                    padding: EdgeInsets.all(5),
                    decoration: new BoxDecoration(
                        // color: Colo,
                        border: Border.all(width: 1.5, color: Colors.orange),
                        borderRadius:
                            new BorderRadius.all(Radius.circular(5.0))),
                    child: Text((snapshot.data.listCallcards[index]
                                .call_information.plate_no !=
                            null)
                        ? snapshot
                            .data.listCallcards[index].call_information.plate_no
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
                          callcard_no: snapshot.data.listCallcards[index]
                              .call_information.callcard_no,
                          call_information: snapshot
                              .data.listCallcards[index].call_information,
                          response_team:
                              snapshot.data.listCallcards[index].response_team,
                          response_time:
                              snapshot.data.listCallcards[index].response_time,
                          patients: snapshot.data.listCallcards[index].patients,
                          
                        )));
            // Navigator.pushNamed(context, "/callcarddetail");
          },
        );
      },
    );
  }
}
