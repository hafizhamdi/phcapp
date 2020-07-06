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
  List<VitalSign> listVitals;
  final index;

  VitalSignList({this.listVitals, this.index});

  _VitalSignList createState() => _VitalSignList();
}

class _VitalSignList extends State<VitalSignList>
//  {
    with
        AutomaticKeepAliveClientMixin<VitalSignList> {
  @override
  bool get wantKeepAlive => true;
  VitalBloc vitalBloc;

  // @override
  // void didChangeDependencies() {}

  // @override
  // void initState() {
  //   vitalBloc = BlocProvider.of<VitalBloc>(context);

  //   print(vitalBloc.state.listVitals);
  //   if (vitalBloc.state.listVitals == null) {
  //     vitalBloc.add(LoadVital(listVitals: widget.listVitals));
  //   }

  //   print(widget.index);
  //   if (widget.index == null) {
  //     print(widget.index);
  //     vitalBloc.add(LoadVital(listVitals: []));
  //   }

  //   super.initState();
  // }

  // @override
  // void dispose() {
  //   vitalBloc.add(LoadVital(listVitals: null));
  //   super.dispose();
  // }

  @override
  String counterStartingWord(index) {
    switch (index) {
      case 0:
        return "1st";
        break;
      case 1:
        return "2nd";
        break;
      case 2:
        return "3rd";
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
            style:
                TextStyle(fontWeight: FontWeight.bold, fontFamily: "Raleway")),
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
                // Expanded(
                //     child: Row(children: <Widget>[
                //   Padding(
                //       padding: EdgeInsets.only(right: 5),
                //       child: Icon(Icons.flag, color: Colors.purple)),
                //   Text("Normal")
                // ]),),
              ],
            ),
            padding: EdgeInsets.only(right: 20)),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return VitalDetail(
                  vitalSign: vital,
                  index: index,
                );
              },
            ),
          );
        },
      ),
    );
  }

  @override
  build(BuildContext context) {
    vitalBloc = BlocProvider.of<VitalBloc>(context);

    // if (widget.listVitals != null) {
    //   vitalBloc.add(LoadVital(listVitals: widget.listVitals));
    // } else if (vitalBloc.state.listVitals == null) {
    //   vitalBloc.add(LoadVital(listVitals: []));
    // } else if (vitalBloc.state.listVitals.length > 0) {
    //   vitalBloc.add(LoadVital(listVitals: vitalBloc.state.listVitals));
    // }
    // else
    //             vitalBloc.add(LoadVital(listVitals: currentState.listVitals));

    // return ChangeNotifierProvider(
    //     builder: (_) => ThemeProvider(isLightTheme: true),
    //     child: Scaffold(

    return Scaffold(
        // backgroundColor: Colors.grey[200],
        body:
            // if (currentState is VitalEmpty) {
            // vitalBloc = BlocProvider.of<VitalBloc>(context);
            // if (widget.listVitals != null)
            //   vitalBloc.add(LoadVital(listVitals: widget.listVitals));
            // else
            // vitalBloc.add(LoadVital(listVitals: []));
            // // vitalBloc.add(LoadVital());
            // super.didChangeDependencies();
            // } else
            // if (currentState is VitalLoaded) {
            //   print("VitalLoaded");
            //   print(currentState);
            // return
            SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Center(
            child: Card(
              margin: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 70),
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  // backgroundColor: Colors.grey[200],
                  // body: ListView(
                  children: <Widget>[
                    HeaderSection("Vital Signs"),
                    BlocBuilder<VitalBloc, VitalState>(
                        // bloc: vitalBloc,
                        builder: (context, state) {
                      final currentState = state;

                      if (state is VitalLoaded) {
                        return (currentState.listVitals != null)
                            ? Container(
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
                                        currentState.listVitals[index], index);
                                  },
                                ),
                              )
                            : Container();
                      }

                      return Container();
                      // return Container(
                      //   width: 500,
                      //   padding: EdgeInsets.only(bottom: 10),
                      //   child: ListView.builder(
                      //     physics: NeverScrollableScrollPhysics(),
                      //     // addRepaintBoundaries: false,
                      //     shrinkWrap: true,
                      //     // ke: ,
                      //     // padding: EdgeInsets.all(30),
                      //     itemCount: widget.listVitals.length,
                      //     itemBuilder: (BuildContext context, int index) {
                      //       return _buildCard(widget.listVitals[index], index);
                      //     },
                      //   ),
                      // );
                      // : Container();
                      // return Center(
                      //     child: Container(
                      //   child: Text("No Vital signs recorded. Add VITALSIGN"),
                      // ));
                      //   width: 500,
                      //   padding: EdgeInsets.only(bottom: 10),
                      //   child: ListView.builder(
                      //     physics: NeverScrollableScrollPhysics(),
                      //     // addRepaintBoundaries: false,
                      //     shrinkWrap: true,
                      //     // ke: ,
                      //     // padding: EdgeInsets.all(30),
                      //     itemCount: widget.listVitals.length,
                      //     itemBuilder: (BuildContext context, int index) {
                      //       return _buildCard(widget.listVitals[index], index);
                      //     },
                      //   ),
                      // );
                    }
                        // ),),
                        // }
// },

                        // ) // )));

                        // }
                        ),
                  ],
                ),
              ),
            ),
            //               ))));
            // // }
            // return Container();
            // }
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          heroTag: 200,
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
