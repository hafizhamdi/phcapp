import 'package:flutter/material.dart';
import 'package:phcapp/custom/choice_chip.dart';
import 'package:phcapp/custom/label.dart';
import 'package:phcapp/src/models/phc.dart';
// import 'package:phcapp/src/providers/assessment_provider.dart';
import 'package:provider/provider.dart';

enum Assessment {
  triage,
  appearance,
  responsiveness,
  airway,
  respiratory,
  airentry,
  breathSound,
  heartSound,
  skin,
  ecg,
  abdomenPalpation,
  abdomenAbnormal,
  faceStroke
}

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

class PatientAssessments extends StatefulWidget {
  @override
  _PatientAssessmentState createState() => _PatientAssessmentState();
}

class _PatientAssessmentState extends State<PatientAssessments>
    with TickerProviderStateMixin {
  var checked = false;
  final Duration animationDuration = Duration(seconds: 5);
  double transitionIconSize = 16.0;

  Animation _checkAnimation;
  AnimationController _checkAnimationController;
  // AssessmentProvider provider;
  @override
  void initState() {
    // provider = Provider.of<AssessmentProvider>(context);

    super.initState();

    _checkAnimationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1200));
    _checkAnimation = Tween(begin: 20.0, end: 25.0).animate(CurvedAnimation(
        curve: Curves.elasticInOut, parent: _checkAnimationController));
  }

  @override
  void dispose() {
    // print(provider.patientAssessment.toJson());
    super.dispose();
  }

  void updateAssessment(header, value, provider) {
    PatientAssessment data = provider.patientAssessment;

    switch (header) {
      case "Disaster Triage":
        data.disasterTriage = value[0];
        break;
      case 'Appearance':
        data.appearance = value[0];
        break;
      case "Level of responsiveness":
        data.levelResponsive = value[0];
        break;
      case "Airway patency":
        data.airwayPatency = value[0];
        break;
      case 'Respiratory Effort':
        data.respiratoryEffort = value[0];
        break;
      case 'Air Entry - Right lung':
        data.airEntry.rightLung = value[0];
        break;
      case 'Air Entry - Left lung':
        data.airEntry.leftLung = value[0];
        break;
      case 'Breath Sound - Right lung':
        data.breathSound.rightLung = value[0];
        break;
      case 'Breath Sound - Left lung':
        data.breathSound.leftLung = value[0];
        break;
      case 'Heart Sound':
        data.heartSound = value[0];
        break;
      case 'Skin Assessment':
        data.skin = value[0];
        break;
      case 'ECG':
        data.ecg = value[0];
        break;
      case 'Abdomen palpation':
        data.abdomenPalpation = value[0];
        break;
      case 'Abdomen abnormality location':
        data.abdomenAbnormalityLocation = value[0];
        break;
      case 'Stoke scale - face':
        data.strokeScale.face = value[0];
        break;
      case 'Stoke scale - speech':
        data.strokeScale.speech = value[0];
        break;
      case 'Stoke scale - arm':
        data.strokeScale.arm = value[0];
        break;

      default:
        break;
    }

    provider.setPatientAssessment = data;
  }

  void callback(String header, List<String> selectedItems) {
    // print("Callback");
    // print(selectedItems);
    // updateAssessment(header, selectedItems);

    // // print(cb.item.toString());

    // setState(() {
    //   prepareData.forEach((f) {
    //     // setState(() {
    //     // print(f.header);
    //     if (f.header == header) {
    //       print(header);
    //       // print(index);
    //       // int idx = prepareData.indexOf();
    //       if (selectedItems.length != 0) {
    //         // f.isChecked = false;

    //         // _checkAnimationController.reverse();
    //         // transitionIconSize = 14.0;
    //         // });
    //         // } else {
    //         // setState(() {
    //         f.isChecked = true;
    //         _checkAnimationController.forward().orCancel;
    //         // transitionIconSize = 25.0;
    //       } else {
    //         f.isChecked = false;
    //         // _checkAnimationController.reverse();
    //         // transitionIconSize = 14.0;
    //       }
    //       // });
    //       // }
    //       // ;
    //     }
    //   });
    //   // if (prepareData[index].header == item)
    //   // checked = true;
    // });
  }

  String changeEnumToTitle(selector) {
    switch (selector) {
      case Assessment.triage:
        return "Disaster Triage";
        break;
      case Assessment.appearance:
        return "Appearance";
        break;
      case Assessment.responsiveness:
        return "Level of Responsiveness";
        break;
      case Assessment.airway:
        return "Airway";
        break;
      case Assessment.respiratory:
        return "Respiratory Effort";
        break;
      case Assessment.airentry:
        return "Air Entry";
        break;
      case Assessment.breathSound:
        return "Breath Sound";
        break;
      case Assessment.heartSound:
        return "Heart Sound";
        break;
      case Assessment.skin:
        return "Skin Assessment";
        break;
      case Assessment.ecg:
        return "ECG";
        break;
      case Assessment.abdomenPalpation:
        return "Abdomen Palpation";
        break;
      case Assessment.abdomenAbnormal:
        return "Abdomen Abnormal Location";
        break;
      case Assessment.faceStroke:
        return "Face Stroke Scale";
        break;
      // case Assessment.: return "Abdomen Abnormal Location";
      // break;

      default:
        return "";
        break;
    }
    // print(selector.toString());
    // final data = selector.toString().replaceAll(new RegExp(r'_'), ' ');
    // print(data);

    // return data;
  }

  singleSelectionChoiceChip(list) {
    List<String> selectedList = new List();
    return Container(
        padding: EdgeInsets.only(left: 10),
        child: Wrap(
          spacing: 10,
          children: List<Widget>.generate(
            list.length,
            (int index) {
              return ChoiceChip(
                elevation: 2.0,
                label: Text(list[index]),
                selected: selectedList.contains(list[index]),
                onSelected: (selected) {
                  // provider.selectedItems.add();
                  print(selected);

                  (selected)
                      ? selectedList.add(list[index])
                      : selectedList.removeAt(index);
                },
              );
              // }
            },
          ).toList(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
          'Patient Assessment',
        )),
        body: Container(
            padding: EdgeInsets.all(10),
            child: ListView.builder(
                itemCount: prepareData.length,
                itemBuilder: (BuildContext context, int index) {
                  return _buildCard(prepareData[index].header,
                      prepareData[index].bodyModel.list);
                })));
  }

  _buildCard(title, list) {
    return Card(
        child: ListTile(
            title: Padding(
                child: Text(changeEnumToTitle(title)),
                padding: EdgeInsets.symmetric(vertical: 10.0)),
            subtitle: singleSelectionChoiceChip(list)));
  }

  List<ItemModel> prepareData = <ItemModel>[
    ItemModel(
        header: Assessment.triage,
        icon: Icons.sync_problem,
        multiple: false,
        bodyModel: BodyModel(list: _disasterTriage)),
    // ItemModel(
    //     header: Assessment.appearance,
    //     icon: Icons.accessibility,
    //     multiple: false,
    //     bodyModel: BodyModel(list: _appearance)),
    // ItemModel(
    //     header: Assessment.responsiveness,
    //     icon: Icons.directions_walk,
    //     multiple: false,
    //     bodyModel: BodyModel(list: _responsiveness)),
    // ItemModel(
    //     header: Assessment.airway,
    //     icon: Icons.accessible_forward,
    //     multiple: false,
    //     bodyModel: BodyModel(list: _airway)),
    // ItemModel(
    //     header: Assessment.respiratory,
    //     icon: Icons.account_balance,
    //     multiple: false,
    //     bodyModel: BodyModel(list: _respiratory)),
    // ItemModel(
    //     header: Assessment.airentry,
    //     icon: Icons.add_to_photos,
    //     multiple: false,
    //     bodyModel: BodyModel(list: _airEntry)),
    // ItemModel(
    //     header: Assessment.breathSound,
    //     icon: Icons.surround_sound,
    //     multiple: false,
    //     bodyModel: BodyModel(list: _breathSound)),
    // ItemModel(
    //     header: Assessment.heartSound,
    //     icon: Icons.tag_faces,
    //     multiple: false,
    //     bodyModel: BodyModel(list: _heartSound)),
    // ItemModel(
    //     header: Assessment.skin,
    //     icon: Icons.drag_handle,
    //     multiple: false,
    //     bodyModel: BodyModel(list: _skinAssment)),
    // ItemModel(
    //     header: Assessment.skin,
    //     icon: Icons.dashboard,
    //     multiple: false,
    //     bodyModel: BodyModel(list: _ecg)),
    // ItemModel(
    //     header: Assessment.abdomenPalpation,
    //     icon: Icons.insert_emoticon,
    //     multiple: false,
    //     bodyModel: BodyModel(list: _abdomenPalpation)),
    // ItemModel(
    //     header: Assessment.abdomenAbnormal,
    //     icon: Icons.accessible_forward,
    //     multiple: false,
    //     bodyModel: BodyModel(list: _abdomenAbnorm)),
    // ItemModel(
    //     header: Assessment.faceStroke,
    //     icon: Icons.face,
    //     multiple: false,
    //     bodyModel: BodyModel(list: _face)),
  ];
}

class ItemModel {
  bool isChecked;
  bool multiple;
  Assessment header;
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
