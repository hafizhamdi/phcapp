import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phcapp/src/models/chip_item.dart';
import 'package:phcapp/src/models/phc.dart';
import 'package:phcapp/src/ui/tabs/patient/asessments/blocs/trauma_bloc.dart';
import 'package:phcapp/src/widgets/my_multiple_option.dart';
import 'package:phcapp/src/widgets/mycard_single_option.dart';

const _head = [
  "normal",
  "abrasion",
  "burn",
  "deformity",
  "laceration",
  "foreign body",
  "puncture/stab wound",
  "gunshot wound",
  "swelling",
  "tenderness"
];
const _neck_abnormal = [
  "anterior right",
  "anteriror left",
  "posterior right",
  "posterior left"
];
const _back_abnormal = [
  "thoracic right",
  "thoracic left",
  "lumbar right",
  "lumbar left",
  "sacral right",
  "sacral left"
];

const _spine = ["normal", "tender", "deformity"];
const _spine_abnormal = ["cervical", "thoracic", "lumbar", "sacral"];
const _limb = [
  "normal",
  "abrasion",
  "amputation above elbow",
  "burn",
  "crush",
  "deformity",
  "dislocation shoulder",
  "mangled",
  "laceration",
  "foreign body",
  "puncture/stab wound",
  "gunshot wound",
  "swelling",
  "tenderness",
];

const _chest = [
  "normal",
  "abrasion",
  "burn",
  "deformity",
  "laceration",
  "foreign body",
  "puncture/stab wound",
  "gunshot wound",
  "swelling",
  "tenderness"
];

const _abdomen = [
  "normal",
  "abrasion",
  "burn",
  "deformity",
  "laceration",
  "foreign body",
  "puncture/stab wound (no evisceration)",
  "puncture/stab wound (with evisceration)",
  "gunshot wound",
  "swelling",
  "tenderness",
];

const _limb_forearm = [
  "normal",
  "abrasion",
  "amputation below elbow",
  "amputation above wrist",
  "burn",
  "crush",
  "deformity",
  "dislocation elbow",
  "mangled",
  "laceration",
  "foreign body",
  "puncture/stab wound",
  "gunshot wound",
  "swelling",
  "tenderness",
];

const _limb_hand = [
  "normal",
  "abrasion",
  "amputation of digit(s)",
  "burn",
  "crush",
  "deformity",
  "dislocation digit(s)",
  "mangled",
  "laceration",
  "foreign body",
  "puncture/stab wound",
  "gunshot wound",
  "swelling",
  "tenderness",
];

const _limb_femur = [
  "normal",
  "abrasion",
  "amputation above knee",
  "burn",
  "crush",
  "deformity",
  "dislocation hip",
  "mangled",
  "laceration",
  "foreign body",
  "puncture/stab wound",
  "gunshot wound",
  "swelling",
  "tenderness",
];

const _limb_leg = [
  "normal",
  "abrasion",
  "amputation below knee",
  "burn",
  "crush",
  "deformity",
  "dislocation knee",
  "mangled",
  "laceration",
  "foreign body",
  "puncture/stab wound",
  "gunshot wound",
  "swelling",
  "tenderness",
];

const _limb_feet = [
  "normal",
  "abrasion",
  "amputation of ankle",
  "amputation of toe(s)",
  "burn",
  "crush",
  "deformity",
  "dislocation toe(s)",
  "mangled",
  "laceration",
  "foreign body",
  "puncture/stab wound",
  "gunshot wound",
  "swelling",
  "tenderness",
];

class TraumaScreen extends StatefulWidget {
  final TraumaAssessment trauma;

  TraumaScreen({this.trauma});
  _TraumaScreen createState() => _TraumaScreen();
}

class _TraumaScreen extends State<TraumaScreen> {
  List<String> listHead = new List<String>();
  List<String> listFace = new List<String>();
  List<String> listNeck = new List<String>();
  List<String> listNeckAbnormal = new List<String>();
  List<String> listBack = new List<String>();
  List<String> listBackAbnormal = new List<String>();
  List<String> listSpine = new List<String>();
  List<String> listSpineAbnormal = new List<String>();
  List<String> listChestR = new List<String>();
  List<String> listChestL = new List<String>();
  List<String> listAbdomenRU = new List<String>();
  List<String> listAbdomenLU = new List<String>();
  List<String> listAbdomenRL = new List<String>();
  List<String> listAbdomenLL = new List<String>();
  List<String> listLimbArmR = new List<String>();
  List<String> listLimbArmL = new List<String>();
  List<String> listLimbForearmR = new List<String>();
  List<String> listLimbForearmL = new List<String>();
  List<String> listLimbHandR = new List<String>();
  List<String> listLimbHandL = new List<String>();
  List<String> listLimbFemurR = new List<String>();
  List<String> listLimbFemurL = new List<String>();
  List<String> listLimbLegR = new List<String>();
  List<String> listLimbLegL = new List<String>();
  List<String> listLimbFeetR = new List<String>();
  List<String> listLimbFeetL = new List<String>();

  List<ChipItem> prepareData = [
    ChipItem(
        id: "head",
        name: "Head",
        listData: _head,
        value: List<String>(),
        multiple: true),
    ChipItem(
        id: "face",
        name: "Face",
        listData: _head,
        value: List<String>(),
        multiple: true),
    ChipItem(
        id: "neck",
        name: "Neck",
        listData: _head,
        value: List<String>(),
        multiple: true),
    ChipItem(
        id: "neck_abnorm",
        name: "Neck Abnormality Location",
        listData: _neck_abnormal,
        value: List<String>(),
        multiple: true),
    ChipItem(
        id: "back",
        name: "Back",
        listData: _head,
        value: List<String>(),
        multiple: true),
    ChipItem(
        id: "back_abnorm",
        name: "Back Abnormality Location",
        listData: _back_abnormal,
        value: List<String>(),
        multiple: true),
    ChipItem(
        id: "spine",
        name: "Spine",
        listData: _spine,
        value: List<String>(),
        multiple: true),
    ChipItem(
        id: "spine_abnorm",
        name: "Spine Abnormality Location",
        listData: _spine_abnormal,
        value: List<String>(),
        multiple: true),
    ChipItem(
        id: "right_chest",
        name: "Right Chest",
        listData: _chest,
        value: List<String>(),
        multiple: true),
    ChipItem(
        id: "left_chest",
        name: "Left Chest",
        listData: _chest,
        value: List<String>(),
        multiple: true),
    ChipItem(
        id: "abdomen_right_upper",
        name: "Abdomen: Right upper quadrant",
        listData: _abdomen,
        value: List<String>(),
        multiple: true),
    ChipItem(
        id: "abdomen_left_upper",
        name: "Abdomen: Left upper quadrant",
        listData: _abdomen,
        value: List<String>(),
        multiple: true),
    ChipItem(
        id: "abdomen_right_lower",
        name: "Abdomen: Right lower quadrant",
        listData: _abdomen,
        value: List<String>(),
        multiple: true),
    ChipItem(
        id: "abdomen_left_lower",
        name: "Abdomen: Left lower quadrant",
        listData: _abdomen,
        value: List<String>(),
        multiple: true),
    ChipItem(
        id: "limb_right_arm",
        name: "Limb: Right arm",
        listData: _limb,
        value: List<String>(),
        multiple: true),
    ChipItem(
        id: "limb_left_arm",
        name: "Limb: Left arm",
        listData: _limb,
        value: List<String>(),
        multiple: true),
    ChipItem(
        id: "limb_right_forearm",
        name: "Limb: Right forearm",
        listData: _limb_forearm,
        value: List<String>(),
        multiple: true),
    ChipItem(
        id: "limb_left_forearm",
        name: "Limb: Left forearm",
        listData: _limb_forearm,
        value: List<String>(),
        multiple: true),
    ChipItem(
        id: "limb_right_hand",
        name: "Limb: Right hand",
        listData: _limb_hand,
        value: List<String>(),
        multiple: true),
    ChipItem(
        id: "limb_left_hand",
        name: "Limb: Left hand",
        listData: _limb_hand,
        value: List<String>(),
        multiple: true),
    ChipItem(
        id: "limb_right_femur",
        name: "Limb: Right femur",
        listData: _limb_femur,
        value: List<String>(),
        multiple: true),
    ChipItem(
        id: "limb_left_femur",
        name: "Limb: Left femur",
        listData: _limb_femur,
        value: List<String>(),
        multiple: true),
    ChipItem(
        id: "limb_right_leg",
        name: "Limb: Right leg",
        listData: _limb_leg,
        value: List<String>(),
        multiple: true),
    ChipItem(
        id: "limb_left_leg",
        name: "Limb: Left leg",
        listData: _limb_leg,
        value: List<String>(),
        multiple: true),
    ChipItem(
        id: "limb_right_feet",
        name: "Limb: Right feet",
        listData: _limb_feet,
        value: List<String>(),
        multiple: true),
    ChipItem(
        id: "limb_left_feet",
        name: "Limb: Left feet",
        listData: _limb_feet,
        value: List<String>(),
        multiple: true),
  ];

  mycallback(id, List<String> dataReturn) {
    // print("callback");
    // print(dataReturn);
    if (id == "head") {
      setState(() {
        listHead = dataReturn;
      });
    }
    if (id == "face") {
      setState(() {
        listFace = dataReturn;
      });
    }
    if (id == "neck") {
      setState(() {
        listNeck = dataReturn;
      });
    }
    if (id == "neck_abnorm") {
      setState(() {
        listNeckAbnormal = dataReturn;
      });
    }
    if (id == "back") {
      setState(() {
        listBack = dataReturn;
      });
    }
    if (id == "back_abnorm") {
      setState(() {
        listBackAbnormal = dataReturn;
      });
    }
    if (id == "spine") {
      setState(() {
        listSpine = dataReturn;
      });
    }
    if (id == "spine_abnorm") {
      setState(() {
        listSpineAbnormal = dataReturn;
      });
    }
    if (id == "right_chest") {
      setState(() {
        listChestR = dataReturn;
      });
    }
    if (id == "left_chest") {
      setState(() {
        listChestL = dataReturn;
      });
    }
    if (id == "abdomen_right_upper") {
      setState(() {
        listAbdomenRU = dataReturn;
      });
    }
    if (id == "abdomen_left_upper") {
      setState(() {
        listAbdomenLU = dataReturn;
      });
    }
    if (id == "abdomen_right_lower") {
      setState(() {
        listAbdomenRL = dataReturn;
      });
    }
    if (id == "abdomen_left_lower") {
      setState(() {
        listAbdomenLL = dataReturn;
      });
    }
    if (id == "limb_right_arm") {
      setState(() {
        listLimbArmR = dataReturn;
      });
    }
    if (id == "limb_left_arm") {
      setState(() {
        listLimbArmL = dataReturn;
      });
    }
    if (id == "limb_right_forearm") {
      setState(() {
        listLimbForearmR = dataReturn;
      });
    }
    if (id == "limb_left_forearm") {
      setState(() {
        listLimbForearmL = dataReturn;
      });
    }
    if (id == "limb_right_hand") {
      setState(() {
        listLimbHandR = dataReturn;
      });
    }
    if (id == "limb_left_hand") {
      setState(() {
        listLimbHandL = dataReturn;
      });
    }
    if (id == "limb_right_femur") {
      setState(() {
        listLimbFemurR = dataReturn;
      });
    }
    if (id == "limb_left_femur") {
      setState(() {
        listLimbFemurL = dataReturn;
      });
    }
    if (id == "limb_right_leg") {
      setState(() {
        listLimbLegR = dataReturn;
      });
    }
    if (id == "limb_left_leg") {
      setState(() {
        listLimbLegL = dataReturn;
      });
    }
    if (id == "limb_left_feet") {
      setState(() {
        listLimbFeetL = dataReturn;
      });
    }
    if (id == "limb_right_feet") {
      setState(() {
        listLimbFeetR = dataReturn;
      });
    }
  }

  @override
  void didChangeDependencies() {
    print("didChangeDependencies.");
    if (widget.trauma != null) {
      prepareData.map((f) {
        if (f.id == "neck") {
          f.value = widget.trauma.neck;
          listNeck = widget.trauma.neck;
        }
        if (f.id == "head") {
          f.value = widget.trauma.head;
          listHead = widget.trauma.head;
        }
        if (f.id == "face") {
          f.value = widget.trauma.face;
          listFace = widget.trauma.face;
        }
        if (f.id == "neck_abnorm") {
          f.value = widget.trauma.neckAbnormalityLocation;
          listNeckAbnormal = widget.trauma.neckAbnormalityLocation;
        }
        if (f.id == "back") {
          f.value = widget.trauma.back;
          listBack = widget.trauma.back;
        }
        if (f.id == "back_abnorm") {
          f.value = widget.trauma.backAbnormalityLocation;
          listBackAbnormal = widget.trauma.backAbnormalityLocation;
        }
        if (f.id == "spine") {
          f.value = widget.trauma.spine;
          listSpine = widget.trauma.spine;
        }
        if (f.id == "spine_abnorm") {
          f.value = widget.trauma.spineAbnormalityLocation;
          listSpineAbnormal = widget.trauma.spineAbnormalityLocation;
        }
        if (f.id == "right_chest") {
          f.value = widget.trauma.rightChest;
          listChestR = widget.trauma.rightChest;
        }
        if (f.id == "left_chest") {
          f.value = widget.trauma.leftChest;
          listChestL = widget.trauma.leftChest;
        }
        if (f.id == "abdomen_right_upper") {
          f.value = widget.trauma.abdomen.rightUpperQuadrant;
          listAbdomenRU = widget.trauma.abdomen.rightUpperQuadrant;
        }
        if (f.id == "abdomen_left_upper") {
          f.value = widget.trauma.abdomen.leftUpperQuadrant;
          listAbdomenLU = widget.trauma.abdomen.leftUpperQuadrant;
        }
        if (f.id == "abdomen_right_lower") {
          f.value = widget.trauma.abdomen.rightLowerQuadrant;
          listAbdomenRL = widget.trauma.abdomen.rightLowerQuadrant;
        }
        if (f.id == "abdomen_left_lower") {
          f.value = widget.trauma.abdomen.leftLowerQuadrant;
          listAbdomenLL = widget.trauma.abdomen.leftLowerQuadrant;
        }
        if (f.id == "limb_right_arm") {
          f.value = widget.trauma.limb.rightArm;
          listLimbArmR = widget.trauma.limb.rightArm;
        }
        if (f.id == "limb_left_arm") {
          f.value = widget.trauma.limb.leftArm;
          listLimbArmL = widget.trauma.limb.leftArm;
        }
        if (f.id == "limb_right_forearm") {
          f.value = widget.trauma.limb.rightForearm;
          listLimbForearmR = widget.trauma.limb.rightForearm;
        }
        if (f.id == "limb_left_forearm") {
          f.value = widget.trauma.limb.leftForearm;
          listLimbForearmL = widget.trauma.limb.leftForearm;
        }
        if (f.id == "limb_right_hand") {
          f.value = widget.trauma.limb.rightHand;
          listLimbHandR = widget.trauma.limb.rightHand;
        }
        if (f.id == "limb_left_hand") {
          f.value = widget.trauma.limb.leftHand;
          listLimbHandL = widget.trauma.limb.leftHand;
        }
        if (f.id == "limb_right_femur") {
          f.value = widget.trauma.limb.rightFemur;
          listLimbFemurR = widget.trauma.limb.rightFemur;
        }
        if (f.id == "limb_left_femur") {
          f.value = widget.trauma.limb.leftFemur;
          listLimbFemurL = widget.trauma.limb.leftFemur;
        }
        if (f.id == "limb_right_leg") {
          f.value = widget.trauma.limb.rightLeg;
          listLimbLegR = widget.trauma.limb.rightLeg;
        }
        if (f.id == "limb_left_leg") {
          f.value = widget.trauma.limb.leftLeg;
          listLimbLegL = widget.trauma.limb.leftLeg;
        }
        if (f.id == "limb_right_feet") {
          f.value = widget.trauma.limb.rightFeet;
          listLimbFeetR = widget.trauma.limb.rightFeet;
        }
        if (f.id == "limb_left_feet") {
          f.value = widget.trauma.limb.leftFeet;
          listLimbFeetL = widget.trauma.limb.leftFeet;
        }
        return f;
      }).toList();
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final traumaBloc = BlocProvider.of<TraumaBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Trauma Assessment"),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.save, color: Colors.white),
            label: Text(
              "SAVE",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              TraumaAssessment traumaAssessment = new TraumaAssessment(
                timestamp: new DateTime.now(),
                head: listHead,
                face: listFace,
                neck: listNeck,
                neckAbnormalityLocation: listNeckAbnormal,
                back: listBack,
                backAbnormalityLocation: listBackAbnormal,
                spine: listSpine,
                spineAbnormalityLocation: listSpineAbnormal,
                rightChest: listChestR,
                leftChest: listChestL,
                abdomen: Abdomen(
                    leftLowerQuadrant: listAbdomenLL,
                    rightLowerQuadrant: listAbdomenRL,
                    leftUpperQuadrant: listAbdomenLU,
                    rightUpperQuadrant: listAbdomenRU),
                limb: Limb(
                    leftArm: listLimbArmL,
                    rightArm: listLimbArmR,
                    leftForearm: listLimbForearmL,
                    rightForearm: listLimbForearmR,
                    leftFemur: listLimbFemurL,
                    rightFemur: listLimbFeetR,
                    leftLeg: listLimbLegL,
                    rightLeg: listLimbLegR,
                    rightHand: listLimbHandR,
                    leftHand: listLimbHandL,
                    leftFeet: listLimbFeetL,
                    rightFeet: listLimbFeetR),
              );

              // print(traumaAssessment.toJson());

              traumaBloc.add(UpdateTrauma(traumaAssessment: traumaAssessment));

              Navigator.pop(context);
            },
          )
        ],
      ),
      body: _buildBody(),
    );
  }

  _buildBody() {
    return Container(
      margin: EdgeInsets.all(10),
      child: ListView.builder(
          itemCount: prepareData.length,
          itemBuilder: (context, index) {
            if (prepareData[index].multiple == true) {
              return _buildCardMultiple(prepareData[index]);
            }
            return MyCardSingleOption(
              id: prepareData[index].id,
              name: prepareData[index].name,
              listData: prepareData[index].listData,
              mycallback: mycallback,
              value: prepareData[index].value,
            );
          }),
    );
  }

  _buildCardMultiple(mystate) {
    var id = mystate.id;
    var name = mystate.name;
    var listData = mystate.listData;
    List<String> value = mystate.value;

    return Card(
      child: Container(
        // margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(12),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(bottom: 20),
              child: Text(
                name,
                style: TextStyle(fontSize: 20),
              ),
            ),
            MyMultipleOptions(
              id: id,
              listDataset: listData,
              initialData: value,
              callback: mycallback,
            ),
          ],
        ),
      ),
    );
  }
}
