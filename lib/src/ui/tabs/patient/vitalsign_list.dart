import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:phcapp/custom/header_section.dart';
import 'package:flutter/material.dart';
import 'package:phcapp/src/blocs/blocs.dart';
import 'package:phcapp/src/models/phc.dart';
import 'package:phcapp/src/ui/tabs/patient/vital_detail.dart';
import 'package:phcapp/theme/theme_provider.dart';
import 'package:provider/provider.dart';
// import 'package:phcapp/src/tab_screens/patient_screens/vitals/vital_detail.dart';

class VitalSignList extends StatefulWidget {
  _VitalSignList createState() => _VitalSignList();
}

class _VitalSignList extends State<VitalSignList> {
  VitalBloc vitalBloc;

  @override
  void initState() {
    vitalBloc = BlocProvider.of<VitalBloc>(context);

    vitalBloc.add(LoadVital());

    super.initState();
  }

  String counterStartingWord(index) {
    switch (index) {
      case 0:
        return "First";
        break;
      case 1:
        return "Second";
        break;
      case 2:
        return "Third";
        break;
      case 3:
        return "Fourth";
        break;
      case 4:
        return "Fifth";
        break;
      case 5:
        return "Sixth";
        break;
      case 6:
        return "Seventh";
        break;
      case 7:
        return "Eighth";
        break;
      case 8:
        return "Ninth";
        break;
      case 9:
        return "Tenth";
        break;

      default:
        return (index + 1).toString() + "th";
        break;
    }
  }

  _buildCard(VitalSign vital, index) {
    final reading = counterStartingWord(index);
    return Card(
      // color: Colors.purple[100],
      // margin: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 100),
      child: ListTile(
        leading: Icon(Icons.star),
        title: Text("$reading reading",
            style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Container(
            child: Row(
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(right: 20),
                    child:
                        // Expanded(
                        //     child:

                        Row(children: <Widget>[
                      Padding(
                          padding: EdgeInsets.only(right: 5),
                          child: Icon(
                            Icons.access_time,
                            color: Colors.purple,
                          )),
                      Text(DateFormat("hh:mm aa").format(vital.created))
                    ])
                    // )

                    ),
                Expanded(
                    child: Row(children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(right: 5),
                      child: Icon(Icons.flag, color: Colors.purple)),
                  Text("Severe")
                ])),
              ],
            ),
            padding: EdgeInsets.only(right: 20)),
        trailing: Icon(Icons.arrow_forward_ios),
      ),
    );
  }

  @override
  build(BuildContext context) {
    // return ChangeNotifierProvider(
    //     builder: (_) => ThemeProvider(isLightTheme: true),
    //     child: Scaffold(

    return Scaffold(
        // backgroundColor: Colors.grey[200],
        body: BlocBuilder(
            bloc: vitalBloc,
            builder: (context, state) {
              final currentState = state;
              if (currentState is VitalLoaded) {
                print("VitalLoaded");
                print(currentState);
                return SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Center(
                        child: Card(
                            margin: EdgeInsets.only(
                                left: 10, right: 10, top: 10, bottom: 70),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              // backgroundColor: Colors.grey[200],
                              // body: ListView(
                              children: <Widget>[
                                HeaderSection("Vital Signs"),

                                Container(
                                    width: 500,
                                    padding: EdgeInsets.only(bottom: 10),
                                    child: ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      // addRepaintBoundaries: false,
                                      shrinkWrap: true,
                                      // ke: ,
                                      // padding: EdgeInsets.all(30),
                                      itemCount: currentState.listVitals.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return _buildCard(
                                            currentState.listVitals[index],
                                            index);
                                      },
                                    )
                                    // }
// },

                                    ) // )));
                              ],
                            ))));
              }
              return Container();
            }),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            //  onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => VitalDetail()));
            // }
            // Add your onPressed code here!
          },
          label: Text('ADD VITALSIGN'),
          icon: Icon(Icons.add),
          // backgroundColor: Colors.purple,
        ));
  }
}
