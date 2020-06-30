import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:phcapp/custom/header_section.dart';
import 'package:phcapp/src/blocs/blocs.dart';
import 'package:phcapp/src/models/phc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

// class Team extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         // backgroundColor: Colors.grey[200],
//         body: _Team(),
//         floatingActionButton: FloatingActionButton.extended(
//           onPressed: () {
//             // Add your onPressed code here!
//           },
//           label: Text('ADD TEAM'),
//           icon: Icon(Icons.add),
//           // backgroundColor: Colors.purple,
//         ));
//   }
// }

class EditTeamScreen extends StatefulWidget {
  final vehicleRegNo;
  final serviceResponse;

  // final BuildContext context;
  // final ResponseTeam response_team;
  // final assign_id;

  EditTeamScreen({this.vehicleRegNo, this.serviceResponse});
  _EditTeamScreen createState() => _EditTeamScreen();
}

class _EditTeamScreen extends State<EditTeamScreen> //{
    with
        AutomaticKeepAliveClientMixin<EditTeamScreen> {
  @override
  bool get wantKeepAlive => true;
  String _serviceSelected;
  TextEditingController regNoController = new TextEditingController();

  StreamController<String> _serviceController =
      new StreamController.broadcast();

  // void serviceCallback(String selected) {
  //   setState(() {
  //     print("selected===" + selected);
  //     serviceSelected = selected;
  //   });
  // }

  // TeamBloc teamBloc;
  StaffBloc staffBloc;

  @override
  void initState() {
    // print("=================INIT STATE============");
    // print(widget.response_team.staffs.length);
    //   staffBloc = BlocProvider.of<StaffBloc>(context);
    //   teamBloc = BlocProvider.of<TeamBloc>(context);
    //   regNoController.text = widget.response_team.vehicleRegno;
    //   teamBloc.add(LoadTeam(assign_id: widget.assign_id));
    regNoController.text = widget.vehicleRegNo;
    _serviceSelected = widget.serviceResponse;
  }

  // @override
  // void initState() {
  //   super.initState();
  // }

  @override
  void didChangeDependencies() {
    print("DIDCHANGE START HEERRE");
    BlocProvider.of<TeamBloc>(context).add(InitTeam());
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

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // List<Staff> newStaffs = List<Staff>();

    // newStaffs = teamBloc.selectedStaffs.map((data) {
    //   return Staff(name: data.staffName, position: data.position);
    // }).toList();

    // print("newStaffs");
    // print(newStaffs);

    // print(teamBloc.state);

    regNoController.dispose();
    _serviceController.close();
    super.dispose();
  }

  // TeamBloc teamBloc;

  @override
  Widget build(BuildContext context) {
    final teamBloc = BlocProvider.of<TeamBloc>(context);

    print("BUILD RESPONSE TEAM======");

    // teamBloc.add(LoadTeam(
    //     assign_id: widget.assign_id, responseTeam: widget.response_team));
    // if (widget.response_team != null) {
    //   print("most wanted");
    // teamBloc.add(LoadTeam(
    //     assign_id: widget.assign_id,
    //     responseTeam: new ResponseTeam(
    //         serviceResponse: widget.response_team.serviceResponse,
    //         vehicleRegno: widget.response_team.vehicleRegno,
    //         staffs: widget.response_team.staffs)));
    // } else {
    //   print("not exist");
    //   teamBloc.add(LoadTeam(
    //       assign_id: widget.assign_id, responseTeam: new ResponseTeam()));
    // }

    // final teamBloc = BlocProvider.of<TeamBloc>(context);
    // teamBloc.add(LoadTeam(
    //     assign_id: widget.assign_id, responseTeam: new ResponseTeam()));
    // if (widget.response_team.staffs != null) {
    //   print("most wanted");
    //   teamBloc.add(LoadTeam(
    //       assign_id: widget.assign_id,
    //       responseTeam: new ResponseTeam(
    //           serviceResponse: widget.response_team.serviceResponse,
    //           vehicleRegno: widget.response_team.vehicleRegno,
    //           staffs: widget.response_team.staffs)));
    // } else {
    //   print("not exist");
    //   teamBloc.add(LoadTeam(
    //       assign_id: widget.assign_id, responseTeam: new ResponseTeam()));
    // }
    Widget circle(count) => new Container(
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

    return Scaffold(
      // appBar: AppBar(),
      backgroundColor: Colors.grey,
      body: SafeArea(
        child: SingleChildScrollView(
          // padding: EdgeInsets.all(20),
          physics: BouncingScrollPhysics(),
          // child:
          child: Center(
            child: Container(
              // width: 500,
              height: MediaQuery.of(context).size.height,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                ),
                margin:
                    EdgeInsets.only(top: 10.0, bottom: 80, left: 10, right: 10),
                child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    // mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          IconButton(
                              icon: Icon(Icons.close),
                              onPressed: () {
                                Navigator.pop(context);
                              }),
                          HeaderSection("Response Details"),
                          IconButton(
                              icon: Icon(Icons.check),
                              onPressed: () {
                                final responseBloc =
                                    BlocProvider.of<ResponseBloc>(context);
                                responseBloc.add(AddResponse(
                                    vehicleRegNo: regNoController.text,
                                    serviceResponse: _serviceSelected));

                                Navigator.pop(context);
                              }),
                        ],
                      ),
                      DropDownList("Type of service response", LIST_RESPONSES,
                          InputOption.service, _serviceSelected),
                      // CustomDropDown(
                      //     labelText: "Type of service response",
                      //     items: LIST_RESPONSES,
                      //     callback: serviceCallback,
                      //     itemSelected: serviceSelected),
                      TextInput(
                          labelText: "Vehicle Registration No",
                          controller: regNoController),
                      // initialData:
                      // state.response_team.vehicleRegno),
                    ]),
              ),
            ),
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   heroTag: 102,
      //   onPressed: () {

      // ResponseTeam responseTeam = new ResponseTeam(
      //   serviceResponse: _serviceSelected,
      //   vehicleRegno: regNoController.text,
      //   staffs: teamBloc.state.response_team.staffs,
      // );

      // print("bye---bye reponseteam");
      // print(responseTeam.toJson());

      // teamBloc.add(AddResponseTeam(
      //     response_team: responseTeam, assign_id: widget.assign_id));

      // final snackBar = SnackBar(
      //   content: Text("Response team has been saved!"),
      // );
      // Scaffold.of(context).showSnackBar(snackBar);
      // },
      // child: Icon(Icons.save),
      // ),
      //   ),
      // ],
      // ),
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
        // width: 500,
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
  final controller;
  final inputType;
  final maskFormater;
  final hintText;
  final initialData;

  TextInput(
      {this.labelText,
      this.controller,
      this.maskFormater,
      this.inputType,
      this.hintText,
      this.initialData});

  @override
  Widget build(BuildContext context) {
    return Container(
        // width: 500,
        // width: 500,
        child: Padding(
            padding: EdgeInsets.all(16),
            child: TextFormField(
                textCapitalization: TextCapitalization.characters,
                // initialValue: initialData,
                // validator: validator,
                inputFormatters: maskFormater != null ? [maskFormater] : [],
                // keyboardType: inputType,
                controller: controller,
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
