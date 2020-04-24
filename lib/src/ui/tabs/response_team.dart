import 'package:flutter/material.dart';

import 'package:flutter/rendering.dart';
import 'package:phcapp/custom/choice_chip.dart';
import 'package:phcapp/custom/drop_downlist.dart';
import 'package:phcapp/custom/header_section.dart';
import 'package:phcapp/custom/text_input.dart';
import 'package:phcapp/src/blocs/blocs.dart';
import 'package:phcapp/src/models/phc.dart';
import 'package:phcapp/src/models/phc_staff.dart';
import 'package:phcapp/src/models/team_model.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'staffs.dart';

// constants
const LIST_RESPONSES = [
  "Select option",
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

class ResponseTeamScreen extends StatefulWidget {
  final ResponseTeam response_team;
  final assign_id;

  ResponseTeamScreen({this.response_team, this.assign_id});
  _TeamState createState() => _TeamState();
}

class _TeamState extends State<ResponseTeamScreen> {
  String serviceSelected = "Select option";
  final regNoController = new TextEditingController();

  void serviceCallback(String selected) {
    setState(() {
      print("selected===" + selected);
      serviceSelected = selected;
    });
  }

  TeamBloc teamBloc;
  StaffBloc staffBloc;

  @override
  void initState() {
    teamBloc = BlocProvider.of<TeamBloc>(context);
    staffBloc = BlocProvider.of<StaffBloc>(context);
    regNoController.text = widget.response_team.vehicleRegno;
    teamBloc.add(LoadTeam(assign_id: widget.assign_id));

    //   Person(name: "Abu Bakar", position: "Medical Assistant"),
    //   Person(name: "Malik Sinai", position: "Driver van"),
    //   Person(name: "Malik Sinai", position: "Driver van"),
    //   Person(name: "Malik Sinai", position: "Driver van")
    // ];
  }

  @override
  void dispose() {
    // List<Staff> newStaffs = List<Staff>();

    // newStaffs = teamBloc.selectedStaffs.map((data) {
    //   return Staff(name: data.staffName, position: data.position);
    // }).toList();

    // print("newStaffs");
    // print(newStaffs);

    // teamBloc = BlocProvider.of<TeamBloc>(context);
    // print(teamBloc.state);

    regNoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
        // backgroundColor: Colors.white,
        body: SingleChildScrollView(
            // padding: EdgeInsets.all(20),
            physics: BouncingScrollPhysics(),
            // child:
            child:
                // BlocConsumer<StaffBloc, StaffState>(
                // listener: (context, state) {},
                // builder: (context, state) {
                //       if (state is StaffLoaded) {
                // regNoController.text = state.response_team.vehicleRegno;

                // return ConstrainedBox(
                // constraints: BoxConstraints(),
                // child:
                // return
                Center(
                    child: Card(
                        margin: EdgeInsets.only(
                            top: 10.0, bottom: 80, left: 10, right: 10),
                        child: BlocBuilder<TeamBloc, TeamState>(
                            //     condition: (previous, current) {
                            //   print(previous);
                            //   print(current);
                            //   return true;
                            // },

                            // bloc: staffBloc,
                            builder: (context, state) {
                          if (state is TeamLoaded) {
                            print("HEY UI TEAMLOADED");
                            return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                // mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  HeaderSection("Response Details"),
                                  CustomDropDown(
                                      labelText: "Type of service response",
                                      items: LIST_RESPONSES,
                                      callback: serviceCallback,
                                      itemSelected: serviceSelected),
                                  CustomTextInput(
                                      labelText: "Vehicle Registration No",
                                      textController: regNoController),
                                  Padding(
                                    padding: EdgeInsets.only(top: 20),
                                    child: Stack(children: <Widget>[
                                      HeaderSection("Team"),
                                      Positioned(
                                        child: circle(
                                            state.response_team.staffs.length),
                                        right: 0,
                                        top: 0,
                                        width: 20,
                                      ),
                                    ]),
                                  ),
                                  ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      // addRepaintBoundaries: false,
                                      shrinkWrap: true,
                                      // ke: ,
                                      // padding: EdgeInsets.all(30),
                                      itemCount:
                                          state.response_team.staffs.length,
                                      // state.response_team.staffs.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Card(
                                              child: ListTile(
                                                leading: Icon(Icons.face),
                                                title: Text(
                                                  state.response_team
                                                      .staffs[index].name,
                                                  style: TextStyle(
                                                      fontFamily: "Raleway",
                                                      fontWeight:
                                                          FontWeight.bold
                                                      // fontSize: 16
                                                      // fontWeight: FontWeight.bold
                                                      ),
                                                ),
                                                subtitle: Text(state
                                                            .response_team
                                                            .staffs[index]
                                                            .position !=
                                                        null
                                                    ? state.response_team
                                                        .staffs[index].position
                                                    : ''),
                                                trailing: IconButton(
                                                  icon:
                                                      Icon(Icons.remove_circle),
                                                  onPressed: () {
                                                    BlocProvider.of<TeamBloc>(
                                                            context)
                                                        .add(RemoveTeam(
                                                            removeIndex:
                                                                index));
                                                  },
                                                ),
                                              ),
                                            ));
                                      }),
                                  Padding(
                                    padding: EdgeInsets.all(10),
                                  )
                                ]);
                          }
                          return Container();
                        })))),
        // }

        // return Container();
        // }
        // )
        // ),

        // ))

        // }
        // return CircularProgressIndicator();
        // },
        // )))),

        floatingActionButton: Stack(children: [
          Padding(
              padding: EdgeInsets.only(bottom: 70),
              child: Align(
                  alignment: Alignment.bottomRight,
                  child: FloatingActionButton.extended(
                    heroTag: 0,
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Staffs()));
                      // Add your onPressed code here!
                    },
                    label: Text('ADD STAFF'),
                    icon: Icon(Icons.add),
                    // backgroundColor: Colors.purple,
                  ))),
          Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                heroTag: 1,
                onPressed: () {
                  ResponseTeam responseTeam = new ResponseTeam(
                    serviceResponse: serviceSelected,
                    vehicleRegno: regNoController.text,
                    staffs: teamBloc.state.response_team.staffs,
                  );

                  print("bye---bye reponseteam");
                  print(responseTeam.toJson());

                  teamBloc.add(AddResponseTeam(
                      response_team: responseTeam,
                      assign_id: widget.assign_id));

                  final snackBar = SnackBar(
                    content: Text("Response team has been saved!"),
                  );
                  Scaffold.of(context).showSnackBar(snackBar);
                },
                child: Icon(Icons.save),
              ))
        ]));
  }
}

class Person {
  Person({this.name, this.position});

  String name;
  String position;
}
