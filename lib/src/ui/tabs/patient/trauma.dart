import 'package:flutter/material.dart';
import 'package:phcapp/custom/choice_chip.dart';

const _disasterTriage = ["red", "yellow", "green", "white"];
const _appearance = ["Oriented", "Lethargy", "Confused", "In pain", "Other"];
const _responsiveness = ["Alert", "Verbal", "Pain", "Unresponsive"];
const _airway = [
  "Adequate airway",
  "Apnea/agonal respiration",
  "Gag reflex absent",
  "Sonorous sound",
  "Injury"
];
const _respiratory = [
  "Normal",
  "Rapid",
  "Distressed",
  "Use of accessory muscles",
  "Apnoeic",
  "Weak/agonal"
];
const _airEntry = ["Normal", "Decreased", "Absent"];
const _breathSound = ["Normal", "Rhonchi", "Crepitation", "Silent"];
const _heartSound = ["Normal", "Muffled", "Murmur"];
const _skinAssment = [
  "Normal",
  "Pale",
  "Mottled",
  "Jaundice",
  "Hot",
  "Diaphoretic",
  "Cold",
  "Clammy",
  "Dry"
];
const _ecg = [
  "Sinus rhythm",
  "Sinus tachycardia",
  "Bradycardia",
  "AF",
  "STEMI",
  "NSTEMI",
  "SVT",
  "VT with pulse"
];
const _abdomenPalpation = [
  "Soft & non-tender",
  "Tender",
  "Rebound tenderness",
  "Guarded",
  "Uterus palpable",
  "Mass"
];
const _abdomenAbnorm = [
  "Generalized",
  "Epigastric",
  "Periumbilical",
  "Left upper quadrant",
  "Left lower quadrant",
  "Right upper quadrant",
  "Right lower quadrant"
];
const _face = [
  "Normal",
  "Abnormal pre-existing",
  "Facial droop left",
  "Facial droop right",
  "Unable to perform"
];
const _speech = [
  "Normal",
  "Abrnormal pre-existing",
  "Slurring",
  "Unable to assess"
];
const _arm = [
  "Normal",
  "Abrnormal pre-existing",
  "Arm drift right",
  "Arm drift left",
  "Unable to assess"
];

class Trauma extends StatefulWidget {
  @override
  _PatientTraumaState createState() => _PatientTraumaState();
}

// class _PatientTraumaState extends State<Trauma> {
//   void callback(String item) {}

class _PatientTraumaState extends State<Trauma> with TickerProviderStateMixin {
  var checked = false;
  final Duration animationDuration = Duration(seconds: 5);
  double transitionIconSize = 16.0;

  Animation _checkAnimation;
  AnimationController _checkAnimationController;

  @override
  void initState() {
    super.initState();

    _checkAnimationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1200));
    _checkAnimation = Tween(begin: 20.0, end: 25.0).animate(CurvedAnimation(
        curve: Curves.elasticInOut, parent: _checkAnimationController));
  }

  void callback(String header, List<String> selectedItems) {
    // print(cb.item.toString());
    setState(() {
      prepareData.forEach((f) {
        // setState(() {
        // print(f.header);
        if (f.header == header) {
          print(header);
          // print(index);
          // int idx = prepareData.indexOf();
          if (selectedItems.length != 0) {
            // f.isChecked = false;

            // _checkAnimationController.reverse();
            // transitionIconSize = 14.0;
            // });
            // } else {
            // setState(() {
            f.isChecked = true;
            _checkAnimationController.forward().orCancel;
            // transitionIconSize = 25.0;
          } else {
            f.isChecked = false;
            // _checkAnimationController.reverse();
            // transitionIconSize = 14.0;
          }
          // });
          // }
          // ;
        }
      });
      // if (prepareData[index].header == item)
      // checked = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            //  textTheme: themeProvider.getThemeData,
            title: Text(
          'Trauma Assessment',
        )),
        // body: Icon(Icons.toys),
        body: Container(
            padding: EdgeInsets.all(10),
            child: ListView.builder(
                itemCount: prepareData.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                      child: ListTile(
                    title: Padding(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(prepareData[index].header),
                              AnimatedBuilder(
                                  animation: _checkAnimationController,
                                  builder: (context, child) {
                                    return Center(
                                        child: Container(
                                            // padding: EdgeInsets.all(10.0),
                                            child: Center(
                                                child: Icon(
                                                    prepareData[index].isChecked
                                                        ? Icons.check_circle //,
                                                        : Icons
                                                            .check_circle_outline,
                                                    color: prepareData[index]
                                                            .isChecked
                                                        ? Colors.green
                                                        : Colors.grey,
                                                    size: prepareData[index]
                                                            .isChecked
                                                        ? _checkAnimation.value
                                                        : 20.0
                                                    // size: (prepareData[index]
                                                    //             .isChecked !=
                                                    //         false)
                                                    //     ? _checkAnimation.value
                                                    //     : null
                                                    // : 20,
                                                    ))));
                                  })
                            ]),
                        padding: EdgeInsets.symmetric(vertical: 10.0)),
                    subtitle:
                        //  Wrap(
                        //   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: <Widget>[
                        SingleOption(
                      header: prepareData[index].header,
                      stateList: prepareData[index].bodyModel.list,
                      callback: callback,
                      multiple: prepareData[index].multiple,
                    ),

                    // ],
                    // ),
                  ));
                })));
  }

  List<ItemModel> prepareData = <ItemModel>[
    ItemModel(
        header: 'Head',
        icon: Icons.sync_problem,
        multiple: true,
        bodyModel: BodyModel(list: _disasterTriage)),
    ItemModel(
        header: 'Face',
        icon: Icons.accessibility,
        multiple: true,
        bodyModel: BodyModel(list: _appearance)),
    ItemModel(
        header: 'Neck',
        icon: Icons.directions_walk,
        multiple: true,
        bodyModel: BodyModel(list: _responsiveness)),
    ItemModel(
        header: 'Neck abnormality',
        icon: Icons.accessible_forward,
        multiple: true,
        bodyModel: BodyModel(list: _airway)),
    ItemModel(
        header: 'Back',
        icon: Icons.account_balance,
        multiple: true,
        bodyModel: BodyModel(list: _respiratory)),
    ItemModel(
        header: 'Back abnormality',
        icon: Icons.add_to_photos,
        multiple: true,
        bodyModel: BodyModel(list: _airEntry)),
    ItemModel(
        header: 'Spine',
        icon: Icons.surround_sound,
        multiple: true,
        bodyModel: BodyModel(list: _breathSound)),
    ItemModel(
        header: 'Spine abnormality',
        icon: Icons.tag_faces,
        multiple: true,
        bodyModel: BodyModel(list: _heartSound)),
    ItemModel(
        header: 'Rigth chest',
        icon: Icons.drag_handle,
        multiple: true,
        bodyModel: BodyModel(list: _skinAssment)),
    ItemModel(
        header: 'Left chest',
        icon: Icons.dashboard,
        multiple: true,
        bodyModel: BodyModel(list: _ecg)),
    ItemModel(
        header: 'Abdomen',
        icon: Icons.insert_emoticon,
        multiple: true,
        bodyModel: BodyModel(list: _abdomenPalpation)),
    ItemModel(
        header: 'Abdomen abnormality',
        icon: Icons.accessible_forward,
        multiple: true,
        bodyModel: BodyModel(list: _abdomenAbnorm)),
    ItemModel(
        header: 'Face Stroke scale',
        icon: Icons.face,
        multiple: true,
        bodyModel: BodyModel(list: _face)),
  ];
}

class ItemModel {
  bool isChecked;
  bool multiple;
  String header;
  BodyModel bodyModel;
  IconData icon;

  ItemModel(
      {this.isChecked: false,
      this.header,
      this.icon,
      this.bodyModel,
      this.multiple});
}

class BodyModel {
  List<String> list;
  IconData icon;
  // int quantity;

  BodyModel({this.list});
}
