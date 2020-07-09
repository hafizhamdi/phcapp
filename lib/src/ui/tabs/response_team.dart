import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/rendering.dart';
import 'package:phcapp/custom/choice_chip.dart';
import 'package:phcapp/custom/drop_downlist.dart';
import 'package:phcapp/custom/header_section.dart';
import 'package:phcapp/custom/text_input.dart';
import 'package:phcapp/src/blocs/blocs.dart';
import 'package:phcapp/src/database/phc_dao.dart';
import 'package:phcapp/src/models/phc.dart';
import 'package:phcapp/src/models/phc_staff.dart';
import 'package:phcapp/src/models/team_model.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phcapp/src/ui/tabs/call_information.dart';
import 'package:phcapp/src/ui/tabs/edit_screen/edit_team.dart';
import 'package:provider/provider.dart';

import 'staffs.dart';

// constants

enum InputOption { service }
const LIST_RESPONSES = [
  "",
  "999 Primary",
  "999 Secondary",
  "Supervisor Vehicle"
];

const LIST_AGENCIES = [
  "Civil defence",
  "Fire rescue",
  "Red cresent",
  "St John ambulance",
  "Private"
];

class ResponseTeamScreen extends StatefulWidget {
  final BuildContext context;
  final ResponseTeam response_team;
  final assign_id;

  ResponseTeamScreen({this.context, this.response_team, this.assign_id});
  _TeamState createState() => _TeamState();
}

class _TeamState extends State<ResponseTeamScreen> //{
    with
        AutomaticKeepAliveClientMixin<ResponseTeamScreen> {
  @override
  bool get wantKeepAlive => true;
  String _serviceSelected;
  TextEditingController regNoController = new TextEditingController();

  StreamController<String> _serviceController =
      new StreamController.broadcast();

  StaffBloc staffBloc;

  // @override
  // void didChangeDependencies() {
  //   if (widget.assign_id == null) {}
  // print("DIDCHANGE START HEERRE");
  // BlocProvider.of<TeamBloc>(context).add(InitTeam());
  // if (widget.response_team != null) {
  //   regNoController.text = widget.response_team.vehicleRegno;

  //   _serviceSelected = widget.response_team.serviceResponse;
  // }

  // final teamBloc = BlocProvider.of<TeamBloc>(context);
  // teamBloc.add(LoadTeam(
  //     assign_id: widget.assign_id,
  //     responseTeam: new ResponseTeam(
  //         serviceResponse: widget.response_team.serviceResponse,
  //         vehicleRegno: widget.response_team.vehicleRegno,
  //         staffs: widget.response_team.staffs)));

  // }
  // BlocProvider.of<TeamBloc>(context).add(Init());

  //   super.didChangeDependencies();
  // }

  @override
  void dispose() {
    regNoController.dispose();
    _serviceController.close();
    super.dispose();
  }

  // TeamBloc teamBloc;

  @override
  Widget build(BuildContext context) {
    final teamBloc = BlocProvider.of<TeamBloc>(context);

    return Scaffold(
      backgroundColor: Colors.grey,
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 40),
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xFF3383CD),
              Color(0xFF11249F),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            // padding: EdgeInsets.all(20),
            physics: BouncingScrollPhysics(),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                BlocBuilder<ResponseBloc, ResponseState>(
                  builder: (context, state) {
                    if (state is LoadedResponse) {
                      return ResponseDetail(
                        typeResponse: state.serviceResponse,
                        vehicleRegno: state.vehicleRegNo,
                      );
                    }

                    return ResponseDetail(
                        typeResponse: (widget.response_team != null)
                            ? widget.response_team.serviceResponse
                            : '',
                        vehicleRegno: (widget.response_team != null)
                            ? widget.response_team.vehicleRegno
                            : '');
                  },
                ),
                BlocBuilder<TeamBloc, TeamState>(builder: (context, state) {
                  if (state is TeamLoaded) {
                    return TeamList(selectedStaffs: state.selectedStaffs);
                  }
                  return TeamList(
                    selectedStaffs: (widget.response_team != null)
                        ? widget.response_team.staffs
                        : null,
                  );
                })
              ],
            ),
          ),
          // floatingActionButton: FloatingActionButton.extended(
          //   heroTag: 200,
          //   onPressed: () {
          //     Navigator.push(
          //         context, MaterialPageRoute(builder: (context) => Staffs()));
          //     // Add your onPressed code here!
          //   },
          //   label: Text('ADD STAFF'),
          //   icon: Icon(Icons.add),
          //   // backgroundColor: Colors.purple,
        ),
      ),
    );
  }

  void setInputOption(selector, value) {
    switch (selector) {
      case InputOption.service:
        _serviceSelected = value;
        break;
      default:
        break;
      // case InputOption.distance:
      //   _distance = value;
      //   break;
      // case InputOption.priority:
      //   _priority = value;
      //   break;
    }
  }

  StreamController getStreamController(selector) {
    switch (selector) {
      case InputOption.service:
        return _serviceController;
        break;
      // case InputOption.distance:
      //   return _distanceController;
      //   break;
      // case InputOption.location:
      //   return _locationController;
      // break;
      default:
        return new StreamController();
    }
  }

  Widget DropDownList(labelText, List<String> list, selector, initialData) {
    final controller = getStreamController(selector);

    // if (!list.contains(initialData)) initialData = "";

    print(selector);
    print(initialData);
    return Container(
        width: 500,
        child: Padding(
            padding: EdgeInsets.all(16),
            child: StreamBuilder(
                stream: controller.stream,
                initialData: initialData,
                builder: (context, snapshot) {
                  print("Streambuilder value");
                  print(snapshot.data);

                  setInputOption(selector, snapshot.data);
                  // child:

                  return DropdownButtonFormField(
                      isDense: true,
                      items: list.map((String dropDownStringItem) {
                        return DropdownMenuItem<String>(
                            child: Text(dropDownStringItem),
                            value: dropDownStringItem);
                      }).toList(),
                      onChanged: (valueChanged) {
                        print("WHATS IS INDESIDE:$valueChanged");
                        controller.sink.add(valueChanged);
                      },
                      value: snapshot.data,
                      decoration: InputDecoration(
                          labelText: labelText,
                          fillColor: Colors.white,
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(10.0),
                            borderSide: new BorderSide(),
                          )));
                })));
  }
}

class Person {
  Person({this.name, this.position});

  String name;
  String position;
}

class TextInput extends StatelessWidget {
  final labelText;
  // final controller;
  // final inputType;
  // final maskFormater;
  // final hintText;
  final initialData;

  TextInput(
      {this.labelText,
      // this.controller,
      // this.maskFormater,
      // this.inputType,
      // this.hintText,
      this.initialData});

  @override
  Widget build(BuildContext context) {
    return Container(
        // width: 500,
        width: 500,
        child: Padding(
            padding: EdgeInsets.all(16),
            child: TextFormField(
                initialValue: initialData,
                enabled: false,
                // validator: validator,
                // inputFormatters: maskFormater != null ? [maskFormater] : [],
                // keyboardType: inputType,
                // controller: controller,
                decoration: InputDecoration(
                    // hintText: hintText,
                    labelText: labelText,
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                      borderSide: new BorderSide(),
                    )))));
  }
}

class TeamList extends StatefulWidget {
  // final count;
  final selectedStaffs;
  TeamList({this.selectedStaffs});
  _TeamList createState() => _TeamList();
}

class _TeamList extends State<TeamList> {
  // final count;
  // final state;

  // TeamList({this.state, this.count});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      margin: EdgeInsets.all(12.0),
      // width: 500,
      child: Container(
        padding: EdgeInsets.all(10.0),

        // margin: EdgeInsets.only(top: 10.0, bottom: 80, left: 10, right: 10),
        // child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // Row(children: [
            Stack(children: <Widget>[
              HeaderSection("Response Team"),
              Positioned(
                child: badgeCircle(widget.selectedStaffs != null
                    ? widget.selectedStaffs.length
                    : 0),
                right: 0,
                top: 0,
                width: 20,
              ),
            ]),

            // Container(
            //   height: 1,
            //   color: Colors.grey,
            // ),
            SizedBox(
              height: 10,
            ),
            // ]),

            // ),
            (widget.selectedStaffs != null)
                ? Container(
                    constraints: BoxConstraints(),
                    child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        // addRepaintBoundaries: false,
                        shrinkWrap: true,
                        // ke: ,
                        // padding: EdgeInsets.all(30),
                        itemCount: widget.selectedStaffs.length,
                        // state.response_team.staffs.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              child: Card(
                                child: ListTile(
                                  leading: Icon(Icons.face),
                                  title: Text(
                                    widget.selectedStaffs[index].name != null
                                        ? widget.selectedStaffs[index].name
                                        : '',
                                    style: TextStyle(
                                        fontFamily: "Raleway",
                                        fontWeight: FontWeight.bold
                                        // fontSize: 16
                                        // fontWeight: FontWeight.bold
                                        ),
                                  ),
                                  subtitle: Text(widget
                                              .selectedStaffs[index].position !=
                                          null
                                      ? widget.selectedStaffs[index].position
                                      : ''),
                                  trailing: IconButton(
                                    icon: Icon(Icons.remove_circle),
                                    onPressed: () {
                                      final teamBloc =
                                          BlocProvider.of<TeamBloc>(context);

                                      setState(() {
                                        teamBloc.add(
                                            RemoveTeam(removeIndex: index));
                                      });
                                    },
                                  ),
                                ),
                              ));
                        }),
                  )
                // : Container(),
                // widget.selectedStaffs.length < 1
                // ?
                : Center(
                    child: Container(
                      child: Text("No response team",
                          style: TextStyle(
                              color: Colors.grey, fontFamily: "OpenSans")),
                    ),
                  ),
            // : Container(),
            SizedBox(
              height: 10,
            ),
            Container(
              child: RaisedButton.icon(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                ),
                icon: Icon(
                  Icons.add,
                  color: Colors.blueAccent,
                ),
                label: Text(
                  "ADD STAFF",
                  style: TextStyle(color: Colors.blueAccent),
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Staffs()));
                },
              ),
            )
          ],
        ),
      ),
      // ),
    );
  }

  badgeCircle(count) => new Container(
        width: 25,
        height: 25,
        decoration:
            BoxDecoration(color: Colors.pinkAccent, shape: BoxShape.circle),
        child: Center(
            child: Text(
          "${count}",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        )),
      );
}

class ResponseDetail extends StatelessWidget {
  final String vehicleRegno;
  final String typeResponse;

  ResponseDetail({this.vehicleRegno, this.typeResponse});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      margin: EdgeInsets.all(12.0),
      // width: 500,
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                HeaderSection("Response Details"),
                IconButton(
                    icon: Icon(
                      Icons.edit,
                      color: Colors.blueAccent,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => EditTeamScreen(
                                    vehicleRegNo: vehicleRegno,
                                    serviceResponse: typeResponse,
                                  )));
                    }),
              ],
            ),

            // Container(
            //   height: 1,
            //   color: Colors.grey,
            // ),
            SizedBox(
              height: 10,
            ),

            Row(children: <Widget>[
              MyTextField(
                labelText: "Type of service response",
                // items: LIST_RESPONSES,
                // itemSelected: typeResponse),
                initialData: typeResponse,
              ),
            ]),
            // // InputOption.service, typeResponse),
            Row(children: <Widget>[
              MyTextField(
                labelText: "Vehicle Registration No",
                initialData: vehicleRegno,
                //                 controller: regNoController),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
