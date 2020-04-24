import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phcapp/src/blocs/blocs.dart';
import 'package:phcapp/src/models/phc.dart';
import 'main_assessment.dart';
import 'information.dart';
import 'cprlog.dart';
// import 'assessment.dart';
import 'vitalsign_list.dart';

enum Action { cancel, delete }

class PatientTab extends StatelessWidget {
  final Patient patient;
  PatientBloc patientBloc;

  final index;

  PatientTab({this.patient, this.index});

  Action getAction(index) {
    if (index == null)
      return Action.cancel;
    else
      return Action.delete;
  }

  @override
  Widget build(BuildContext context) {
    print("patient_TAB");
    print(index);
    patientBloc = BlocProvider.of<PatientBloc>(context);
    final action = getAction(index);

    // TODO: implement build
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
              // automaticallyImplyLeading: false,
              bottom: TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.account_box)),
                  Tab(icon: Icon(Icons.airline_seat_flat)),
                  Tab(icon: Icon(Icons.favorite)),
                  Tab(icon: Icon(Icons.assessment)),
                ],
              ),
              title: Text(
                'Patient',
              ),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      if (action == Action.delete) {
                        patientBloc.add(RemovePatient(index: index));
                      }
                      Navigator.pop(context);
                    },
                    child: Text((action == Action.delete) ? "DELETE" : "CANCEL",
                        style: TextStyle(color: Colors.white))),
                FlatButton(
                    onPressed: () {
                      // patientBloc.listen((onData) {
                      //   print("listen to me!");
                      //   print(onData);
                      // });
                      if (action == Action.delete) {
                        //TODO:Update

                      } else {
                        patientBloc.add(AddPatient(
                            patient: new Patient(
                                patientInformation: new PatientInformation(
                                    name: "ABU SAMAD",
                                    gender: "Male",
                                    age: "34"))));
                      }

                      print("patient created");
                      Navigator.pop(context);
                    },
                    child: Text(
                      (action == Action.delete) ? "SAVE" : "CREATE",
                      style: TextStyle(color: Colors.white),
                    ))

                // Text("Create"))
              ],
              backgroundColor: Colors.purple),
          body: TabBarView(
            children: <Widget>[
              PatientInformationScreen(),
              // patient_information: patient.patientInformation),
              // ),
              CPRLog(),
              VitalSignList(),
              MainAssessment(),
            ],
          ),
        ));
  }
}
