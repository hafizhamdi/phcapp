// import 'package:flutter/widgets.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:intl/intl.dart';
// import 'package:phcapp/custom/header_section.dart';
// import 'package:flutter/material.dart';
// import 'package:phcapp/src/blocs/blocs.dart';
// import 'package:phcapp/src/blocs/cpr_bloc.dart';
// import 'package:phcapp/src/models/phc.dart';
// import 'package:phcapp/src/providers/cpr_provider.dart';
// import 'package:phcapp/src/ui/tabs/patient/cpr_items.dart';
// import 'package:phcapp/src/ui/tabs/patient/cprlog.dart';
// import 'package:phcapp/src/ui/tabs/patient/vital_detail.dart';
// import 'package:phcapp/theme/theme_provider.dart';
// import 'package:provider/provider.dart';

// class CPRLogList extends StatefulWidget {
//   CPRLogList();

//   _CPRLogList createState() => _CPRLogList();
// }

// class _CPRLogList extends State<CPRLogList>
//     with AutomaticKeepAliveClientMixin<CPRLogList> {
//   @override
//   bool get wantKeepAlive => true;
//   CprBloc cprBloc;

//   @override
//   String counterStartingWord(index) {
//     switch (index) {
//       case 0:
//         return "1st";
//         break;
//       case 1:
//         return "2nd";
//         break;
//       case 2:
//         return "3rd";
//         break;

//       default:
//         return (index + 1).toString() + "th";
//         break;
//     }
//   }

//   _buildCard(CprSection cprSection, index) {
//     final reading = counterStartingWord(index);
//     return Card(
//       child: ListTile(
//         leading: Icon(Icons.star),
//         title: Text("$reading reading",
//             style:
//                 TextStyle(fontWeight: FontWeight.bold, fontFamily: "Raleway")),
//         subtitle: Container(
//             child: Row(
//               children: <Widget>[
//                 Padding(
//                     padding: EdgeInsets.only(right: 20),
//                     child: Row(children: <Widget>[
//                       Padding(
//                           padding: EdgeInsets.only(right: 5),
//                           child: Icon(
//                             Icons.access_time,
//                             color: Colors.purple,
//                           )),
//                       Text(DateFormat("hh:mm aa")
//                           .format(DateTime.parse(cprSection.timestamp)))
//                     ])
//                     // )

//                     ),
//                 Expanded(
//                     child: Row(children: <Widget>[
//                   Padding(
//                       padding: EdgeInsets.only(right: 5),
//                       child: Icon(Icons.flag, color: Colors.purple)),
//                   Text("Normal")
//                 ])),
//               ],
//             ),
//             padding: EdgeInsets.only(right: 20)),
//         trailing: Icon(Icons.arrow_forward_ios),
//         onTap: () {
//           Navigator.push(
//               context,
//               MaterialPageRoute(
//                   builder: (context) => CPRLog(
//                         cprSection: cprSection,
//                         index: index,
//                       )));
//         },
//       ),
//     );
//   }

//   @override
//   build(BuildContext context) {
//     // final cprProvider = Provider.of<CPRProvider>(context);
//     final cprBloc = BlocProvider.of<CprBloc>(context);
//     return Scaffold(
//         body: SingleChildScrollView(
//             physics: BouncingScrollPhysics(),
//             child: Center(
//                 child: Card(
//                     margin: EdgeInsets.only(
//                         left: 10, right: 10, top: 10, bottom: 70),
//                     child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         mainAxisSize: MainAxisSize.min,
//                         children: <Widget>[
//                           HeaderSection("CPR Logs"),
//                           BlocBuilder<CprBloc, CprState>(
//                             builder: (context, state) {
//                               // },)
//                               // BlocConsumer<CprBloc, CprState>(
//                               //   listener: (context, state) {},
//                               //   builder: (context, state) {
//                               print("WHAT S STATE NOWS");
//                               print(state);
//                               if (state is InitialCpr) {
//                                 cprBloc.add(LoadCpr(
//                                     cpr: new CPR(
//                                         cprLogs: new List<CprSection>())));
//                               } else if (state is LoadedCpr) {
//                                 // return
//                                 return Container(
//                                     width: 500,
//                                     padding: EdgeInsets.only(bottom: 10),
//                                     child: ListView.builder(
//                                         physics: NeverScrollableScrollPhysics(),
//                                         shrinkWrap: true,
//                                         itemCount: state.cpr.cprLogs.length,
//                                         itemBuilder:
//                                             (BuildContext context, int index) {
//                                           print("HOw much in CPR");
//                                           print(state.cpr.cprLogs.length
//                                               .toString());
//                                           return _buildCard(
//                                               state.cpr.cprLogs[index], index);
//                                         }));
//                               }

//                               return Container(
//                                   width: 500,
//                                   child: Padding(
//                                     padding: EdgeInsets.all(10),
//                                     child: Center(child: Text("No data")),
//                                   ));
//                             },
//                           )
//                           // Container(
//                           //     width: 500,
//                           //     padding: EdgeInsets.only(bottom: 10),
//                           //     child: Consumer<CPRProvider>(
//                           //       builder: (context, cpr, child) {
//                           //         return ListView.builder(
//                           //           physics: NeverScrollableScrollPhysics(),
//                           //           shrinkWrap: true,
//                           //           itemCount: cpr.listCPRs.length,
//                           //           itemBuilder: (BuildContext context, int index) {
//                           //             return Container();
//                           //           },
//                           //         );
//                           //       },
//                           // ))
//                         ])))),
//         floatingActionButton: FloatingActionButton.extended(
//           heroTag: 101,
//           onPressed: () {
//             Navigator.push(
//                 context, MaterialPageRoute(builder: (context) => CPRLog()));
//           },
//           label: Text('ADD CPRLOG'),
//           icon: Icon(Icons.add),
//           backgroundColor: Colors.purple,
//         ));
//   }
// }
