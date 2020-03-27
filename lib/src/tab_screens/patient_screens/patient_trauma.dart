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

class PatientTrauma extends StatefulWidget {
  @override
  _PatientTraumaState createState() => _PatientTraumaState();
}

class _PatientTraumaState extends State<PatientTrauma> {
  void callback(String item) {}

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: ListView.builder(
          itemCount: prepareData.length,
          itemBuilder: (BuildContext context, int index) {
            return ExpansionPanelList(
              animationDuration: Duration(seconds: 1),
              children: [
                ExpansionPanel(
                  canTapOnHeader: true,
                  body: Container(
                      alignment: Alignment.centerLeft,
                      // margin: EdgeInsets.all(10),
                      padding: EdgeInsets.only(bottom: 10),
                      child: SingleOption(
                          prepareData[index].bodyModel.list, callback)),
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return Container(
                        // margin: EdgeInsets.only(bottom: 40),
                        padding: EdgeInsets.all(10),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(prepareData[index].icon),
                              Text(prepareData[index].header,
                                  style: TextStyle(
                                    // color: Colors.black54,
                                    fontSize: 18,
                                  ))
                            ]));
                  },
                  isExpanded: prepareData[index].isExpanded,
                )
              ],

              // )]

              expansionCallback: (int item, bool status) {
                setState(() {
                  prepareData[index].isExpanded =
                      !prepareData[index].isExpanded;
                });
              },
            );
          }),
      // },
    );
  }

  List<ItemModel> prepareData = <ItemModel>[
    ItemModel(
        header: 'Head',
        icon: Icons.sync_problem,
        bodyModel: BodyModel(list: _disasterTriage)),
    ItemModel(
        header: 'Face',
        icon: Icons.accessibility,
        bodyModel: BodyModel(list: _appearance)),
    ItemModel(
        header: 'Neck',
        icon: Icons.directions_walk,
        bodyModel: BodyModel(list: _responsiveness)),
    ItemModel(
        header: 'Neck abnormality',
        icon: Icons.accessible_forward,
        bodyModel: BodyModel(list: _airway)),
    ItemModel(
        header: 'Back',
        icon: Icons.account_balance,
        bodyModel: BodyModel(list: _respiratory)),
    ItemModel(
        header: 'Back abnormality',
        icon: Icons.add_to_photos,
        bodyModel: BodyModel(list: _airEntry)),
    ItemModel(
        header: 'Spine',
        icon: Icons.surround_sound,
        bodyModel: BodyModel(list: _breathSound)),
    ItemModel(
        header: 'Spine abnormality',
        icon: Icons.tag_faces,
        bodyModel: BodyModel(list: _heartSound)),
    ItemModel(
        header: 'Rigth chest',
        icon: Icons.drag_handle,
        bodyModel: BodyModel(list: _skinAssment)),
    ItemModel(
        header: 'Left chest',
        icon: Icons.dashboard,
        bodyModel: BodyModel(list: _ecg)),
    ItemModel(
        header: 'Abdomen',
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
