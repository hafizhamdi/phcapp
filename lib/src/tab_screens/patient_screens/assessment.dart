import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:phcapp/src/tab_screens/patient_screens/patient_assesment.dart';
import 'package:phcapp/src/tab_screens/patient_screens/patient_trauma.dart';

class Assessments extends StatelessWidget {
  @override
  build(BuildContext context) {
    return DefaultTabController(
        length: 5,
        child: Scaffold(
          // backgroundColor: Colors.purple,
          // appBar: AppBar(
          //     bottom:
          appBar: TabBar(
            isScrollable: true,
            tabs: [
              Tab(
                  // icon: Icon(Icons.featured_play_list),
                  text: "Patient Assessment"),
              Tab(
                  // icon: Icon(Icons.assessment),
                  text: "Trauma"),
              Tab(
                  // icon: Icon(Icons.airline_seat_flat),
                  text: "Intervention"),
              Tab(
                  // icon: Icon(Icons.favorite),
                  text: "Medication"),
              Tab(
                  // icon: Icon(Icons.favorite),
                  text: "Outcome"),
            ],
            labelColor: Colors.purple,
          ),
          // title: Text(
          //   'Patient',
          // ),
          // backgroundColor: Colors.purple),
          body: TabBarView(
            children: <Widget>[
              PatientAssessment(),
              // PatientAssessment(),
              // PatientAssessment(),
              PatientTrauma(),
              PatientAssessment(),
              PatientAssessment(),
              PatientAssessment(),
            ],
          ),
        ));

    //   return ListView(children: <Widget>[
    //     Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //       children: <Widget>[
    //         _buildIconData(context, Icons.videocam, _typeChoices, "Types"),
    //         _buildIconData(context, Icons.vibration, _rhythmType, "Rhythm"),
    //         _buildIconData(context, Icons.donut_large, _drugsType, "Drugs"),
    //         _buildIconData(context, Icons.surround_sound, _interventionType,
    //             "Intervention"),
    //       ],
    //     ),
    //     PatientAssessment()
    //   ]);
  }
}

// Widget _buildIconData(BuildContext context, IconData icon,
//     List<String> list, String title) {
//   String data;
//   String text;
//   final commentController = TextEditingController();

//   void setItem(String item) {
//     data = item;
//   }

//   void chipCallback(String item) {
//     print('user tapped on $item');
//     setItem(item);
//   }

//   @override
//   void dispose() {
//     commentController.dispose();
//   }

//   String getItem() {
//     return data;
//   }

//   return Column(
//     children: <Widget>[
//       IconButton(
//         icon: Icon(icon),
//         onPressed: () {
//           // showDialog(
//           //     context: context,
//           //     builder: (BuildContext context) {
//           //       return AlertDialog(
//           //           content: SingleChildScrollView(
//           //         child: Column(
//           //           mainAxisSize: MainAxisSize.min,
//           //           children: <Widget>[
//           //             Label("Select type", ""),
//           //             SingleOption(list, chipCallback),
//           //             Padding(
//           //               padding: EdgeInsets.all(8.0),
//           //               child: TextField(
//           //                 decoration: InputDecoration(
//           //                     // border: InputBorder.none,
//           //                     hintText: "Put detail measurements"),
//           //                 controller: commentController,
//           //               ),
//           //             ),
//           //             Padding(
//           //               padding: const EdgeInsets.all(8.0),
//           //               child: RaisedButton(
//           //                 color: Colors.lightGreen,
//           //                 child: Text(
//           //                   "GENERATE LOG",
//           //                 ),
//           //                 onPressed: () {
//           //                 //   String newItem = getItem();
//           //                 //   // Arbitrary location for demonstration purposes
//           //                 //   int insertIndex = 0;
//           //                 //   // int lastItems = logs._item.length;
//           //                 //   // Add the item to the data list.
//           //                 //   logs.add(title +
//           //                 //       " " +
//           //                 //       newItem +
//           //                 //       " " +
//           //                 //       commentController.text);
//           //                 //   // logs._items.insert(0, newItem);
//           //                 //   // _data.insert(insertIndex, newItem);
//           //                 //   // Add the item visually to the AnimatedList.
//           //                 //   _listKey.currentState.insertItem(insertIndex);
//           //                 //   // if (_formKey.currentState.validate()) {
//           //                 //   //   _formKey.currentState.save();
//           //                 //   // }
//           //                 },
//           //               ),
//           //             )
//           //           ],
//           //         ),
//           //       ));
//           //     });
//         },
//       ),
//       Text(
//         title,
//         style: TextStyle(fontSize: 12, color: Colors.grey),
//       ),
//     ],
//   );
