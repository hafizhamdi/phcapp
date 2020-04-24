import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phcapp/custom/choice_chip.dart';
import 'package:phcapp/custom/header_section.dart';
import 'package:phcapp/src/blocs/blocs.dart';
import 'package:phcapp/src/ui/tabs/patient/patient_tab.dart';
// import 'package:phcapp/custom/label.dart';
// import 'package:phcapp/custom/input.dart';
import '../../models/phc.dart';
// import 'package:phcapp/src/tab_screens/patient_screens/main.dart';

const _otherServices = [
  "Civil defence",
  "Fire rescue",
  "Red cresent",
  "St. John ambulance",
  "Private",
  "Police",
  "Supervisor vehicle"
];

class PatientListScreen extends StatefulWidget {
  final List<Patient> patients;

  PatientListScreen({this.patients});
  _Patients createState() => _Patients();
}

class _Patients extends State<PatientListScreen> {
  // List<PatientModel> patients = <PatientModel>[
  //   PatientModel(name: "Abu Bakar malik bin marwan", age: "45", gender: "Male"),
  //   PatientModel(name: "Abu Bakar", age: "45", gender: "Male"),
  //   PatientModel(name: "Abu Bakar", age: "45", gender: "Female"),
  //   PatientModel(name: "Abu Bakar", age: "45", gender: "Male"),
  // ];

  PatientBloc patientBloc;

  @override
  initState() {
    patientBloc = BlocProvider.of<PatientBloc>(context);
  }

  @override
  dispose() {
    // patientBloc.close();
    super.dispose();
  }

  Widget _buildSceneChips(header, list, callback) {
    return Container(
        width: 500,
        margin: EdgeInsets.all(10),
        child: Card(
            child: ListTile(
          title: Padding(
              child: Text(header),
              padding: EdgeInsets.symmetric(vertical: 10.0)),
          subtitle:
              //  Wrap(
              //   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: <Widget>[
              SingleOption(
            header: header,
            stateList: list,
            callback: callback,
            multiple: true,
          ),
          // ],
          // ),
        )));
  }

  Widget _buildPatient(data, route) => Container(
          child: Container(
        width: 500,
        child: Card(
          // color: Colors.purple[100],
          margin: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
          ),
          child: ListTile(
              leading: Icon(Icons.face),
              title: Text(data.name != null ? data.name : "No data",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontFamily: "Raleway")),
              subtitle: Container(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: Row(children: <Widget>[
                        Icon(
                          Icons.accessibility_new,
                          color: Colors.purple,
                          size: 20,
                        ),
                        Text(
                          (data.age != null ? data.age : "0") +
                              " yrs (" +
                              (data.gender != ""
                                  ? data.gender.substring(0, 1)
                                  : 'N') +
                              ")",
                          style: TextStyle(fontFamily: "Arial"),
                        )
                      ])),
                    ],
                  ),
                  padding: EdgeInsets.only(right: 20)),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                //  onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => route));
                // Add your onPressed code here!
              }
              // },
              ),
        ),
      ));

  @override
  Widget build(BuildContext context) {
    Widget circle(count) => Container(
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

    void callback(String item, List<String> selectedItems) {}

    return Scaffold(
        body: BlocBuilder(
            bloc: patientBloc,
            builder: (context, state) {
              final currentState = state;
              if (currentState is PatientLoaded) {
                return SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Center(
                        child: Card(
                      margin: EdgeInsets.only(
                          left: 10, right: 10, top: 10, bottom: 70),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          HeaderSection("Scene Assessment"),
                          _buildSceneChips("Other services at scene",
                              _otherServices, callback),
                          Padding(
                              padding: EdgeInsets.all(10),
                              child: Stack(children: <Widget>[
                                HeaderSection("Patients"),
                                Positioned(
                                  child: circle(currentState.patients.length),
                                  right: 0,
                                  top: 0,
                                  width: 20,
                                ),
                              ])),
                          Container(
                              width: 500,
                              padding: EdgeInsets.only(bottom: 10),
                              child: ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                // addRepaintBoundaries: false,
                                shrinkWrap: true,
                                // ke: ,
                                // padding: EdgeInsets.all(30),
                                itemCount: currentState.patients.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return _buildPatient(
                                      currentState
                                          .patients[index].patientInformation,
                                      PatientTab(
                                          patient: currentState.patients[index],
                                          index: index));
                                },
                              )
                              // }
// },
                              )
                        ],
                      ),
                    )));
              }

              return Container();
            }),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            // BlocProvider.of(context);
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => PatientTab()));
            // Add your onPressed code here!
          },
          label: Text('ADD PATIENT'),
          icon: Icon(Icons.add),
          // backgroundColor: Colors.purple,
        ));
  }
}
