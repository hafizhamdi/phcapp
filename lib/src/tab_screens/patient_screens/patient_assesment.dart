import 'package:flutter/material.dart';
import 'package:phcapp/custom/choice_chip.dart';
import 'package:phcapp/custom/label.dart';

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

class PatientAssessment extends StatefulWidget {
  @override
  _PatientAssessmentState createState() => _PatientAssessmentState();
}

class _PatientAssessmentState extends State<PatientAssessment>
    with TickerProviderStateMixin {
  var checked = false;
  final Duration animationDuration = Duration(seconds: 5);
  double transitionIconSize = 16.0;

  void callback(String header, int index) {
    // print(cb.item.toString());
    // setState(() {

    prepareData.forEach((f) {
      setState(() {
        // print(f.header);
        if (f.header == header) {
          print(header);
          print(index);
          // int idx = prepareData.indexOf();
          if (index == 10) {
            f.isExpanded = false;

            // _checkAnimationController.reverse();
            // transitionIconSize = 14.0;
            // });
          } else {
            // setState(() {
            f.isExpanded = true;
            _checkAnimationController.forward();
            // transitionIconSize = 25.0;
            // });
          }
          ;
        }
      });
      // if (prepareData[index].header == item)
      // checked = true;
    });
  }

  Animation _checkAnimation;
  AnimationController _checkAnimationController;

  @override
  void initState() {
    super.initState();

    _checkAnimationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1200));
    _checkAnimation = Tween(begin: 20.0, end: 25.0).animate(CurvedAnimation(
        curve: Curves.bounceInOut, parent: _checkAnimationController));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                                  prepareData[index].isExpanded
                                      ? Icons.check_circle //,
                                      : Icons.check_circle_outline,
                                  color: prepareData[index].isExpanded
                                      ? Colors.green
                                      : Colors.grey,
                                  size: prepareData[index].isExpanded
                                      ? _checkAnimation.value
                                      : 20,
                                ))));
                              })
                        ]),
                    padding: EdgeInsets.symmetric(vertical: 10.0)),
                subtitle:
                    //  Wrap(
                    //   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: <Widget>[
                    SingleOption(
                      header:prepareData[index].header,
                      stateList:  prepareData[index].bodyModel.list,
                      callback: callback),
                // ],
                // ),
              ));
            }));
  }

  List<ItemModel> prepareData = <ItemModel>[
    ItemModel(
        header: 'Disaster triage',
        icon: Icons.sync_problem,
        bodyModel: BodyModel(list: _disasterTriage)),
    ItemModel(
        header: 'Appearance',
        icon: Icons.accessibility,
        bodyModel: BodyModel(list: _appearance)),
    ItemModel(
        header: 'Level of responsiveness',
        icon: Icons.directions_walk,
        bodyModel: BodyModel(list: _responsiveness)),
    ItemModel(
        header: 'Airway patency',
        icon: Icons.accessible_forward,
        bodyModel: BodyModel(list: _airway)),
    ItemModel(
        header: 'Respiratory effort',
        icon: Icons.account_balance,
        bodyModel: BodyModel(list: _respiratory)),
    ItemModel(
        header: 'Air entry',
        icon: Icons.add_to_photos,
        bodyModel: BodyModel(list: _airEntry)),
    ItemModel(
        header: 'Breath sound',
        icon: Icons.surround_sound,
        bodyModel: BodyModel(list: _breathSound)),
    ItemModel(
        header: 'Heart sound',
        icon: Icons.tag_faces,
        bodyModel: BodyModel(list: _heartSound)),
    ItemModel(
        header: 'Skin assessment',
        icon: Icons.drag_handle,
        bodyModel: BodyModel(list: _skinAssment)),
    ItemModel(
        header: 'ECG', icon: Icons.dashboard, bodyModel: BodyModel(list: _ecg)),
    ItemModel(
        header: 'Abdomen palpation',
        icon: Icons.insert_emoticon,
        bodyModel: BodyModel(list: _abdomenPalpation)),
    ItemModel(
        header: 'Abdomen abnormality',
        icon: Icons.accessible_forward,
        bodyModel: BodyModel(list: _abdomenAbnorm)),
    ItemModel(
        header: 'Face Stroke scale',
        icon: Icons.face,
        bodyModel: BodyModel(list: _face)),
  ];
}

class ItemModel {
  bool isExpanded;
  String header;
  BodyModel bodyModel;
  IconData icon;

  ItemModel({this.isExpanded: false, this.header, this.icon, this.bodyModel});
}

class BodyModel {
  List<String> list;
  IconData icon;
  // int quantity;

  BodyModel({this.list});
}
