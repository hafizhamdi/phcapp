import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:phcapp/src/blocs/blocs.dart';
import 'package:phcapp/src/database/phc_dao.dart';
import 'package:phcapp/src/repositories/phc_dao_client.dart';
import 'package:phcapp/theme/theme_provider.dart';
import 'package:provider/provider.dart';

import 'callcard_tabs.dart';

class ListCallcards extends StatefulWidget {
  PhcDao phcDao;

  ListCallcards({this.phcDao});

  _ListCallcards createState() => _ListCallcards();
}

class _ListCallcards extends State<ListCallcards> {
  Completer<void> _refreshCompleter;
  PhcBloc phcBloc;
  // PhcDao phcDao;

  @override
  void initState() {
    super.initState();
    _refreshCompleter = Completer<void>();
    phcBloc = BlocProvider.of<PhcBloc>(context);
    phcBloc.add(FetchPhc());
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
          leading: Container(
              child: Switch(
                  value: themeProvider.isLightTheme,
                  onChanged: (val) {
                    themeProvider.setThemeData = val;
                  })),
          title: Text("Call Cards")),
      body: Center(
        child: BlocConsumer<PhcBloc, PhcState>(
          
          listener: (context, state) {
            _refreshCompleter?.complete();
            _refreshCompleter = Completer();
          },
          builder: (context, state) {
            if (state is PhcLoaded) {
              print("Phc loaded");
              final phc = state.phc;

              return RefreshIndicator(
                  onRefresh: () {
                    BlocProvider.of<PhcBloc>(context).add(
                      RefreshPhc(),
                    );
                    return _refreshCompleter.future;
                  },
                  child: _buildList(phc)
                  // ListView.builder(
                  //     itemCount: phc.callcards.length,
                  //     itemBuilder: (context, index) {
                  //       final callInfo = phc.callcards[index].call_information;
                  //       return ListTile(
                  //         title: Text(callInfo.callcard_no),
                  //         subtitle: Text(callInfo.callReceived != null
                  //             ? callInfo.callReceived.substring(
                  //                 0, callInfo.call_received.length - 2)
                  //             : callInfo.callReceived),
                  //       );
                  //     })

                  );
            }

            if (state is PhcFetched) {
              final phc = state.phc;
              print("Phc fetched");

              phcBloc.add(AddPhc(phc: phc));
              print("after loadphc");
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  Widget _buildList(phc) {
    return ListView.separated(
      itemCount: phc.callcards.length,
      separatorBuilder: (context, index) => Divider(
        color: Colors.grey,
      ),
      itemBuilder: (BuildContext context, int index) {
        final callInfo = phc.callcards[index].call_information;

        return ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                  child: Text(
                callInfo.callcard_no,
              )),
              Text(
                DateFormat("d MMM, hh:mm aaa")
                    .format(DateTime.parse(callInfo.call_received)),
                style: TextStyle(color: Colors.grey, fontSize: 14),
              )
            ],
          ),
          subtitle:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <
                  Widget>[
            Column(children: [
              Row(children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(right: 6),
                    child: Icon(
                      Icons.person,
                      size: 16,
                    )),
                Text(phc.callcards[index].patients.length.toString() +
                    ' Patients'),
                Padding(
                    padding: EdgeInsets.only(right: 6),
                    child: Icon(
                      Icons.person,
                      size: 16,
                    )),
                Text(phc.callcards[index].response_team.staffs.length
                        .toString() +
                    ' Teams')
              ])
            ]),
            Container(
                padding: EdgeInsets.all(5),
                decoration: new BoxDecoration(
                    // color: Colo,
                    border: Border.all(width: 1.5, color: Colors.orange),
                    borderRadius: new BorderRadius.all(Radius.circular(5.0))),
                child:
                    Text((callInfo.plate_no != null) ? callInfo.plate_no : ""))
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
                          callcard_no: callInfo.callcard_no,
                          call_information:
                              phc.callcards[index].call_information,
                          response_team: phc.callcards[index].response_team,
                          response_time: phc.callcards[index].response_time,
                          patients: phc.callcards[index].patients,
                          phcDao: widget.phcDao,
                        )));
            // Navigator.pushNamed(context, "/callcarddetail");
          },
        );
      },
    );
  }
}
