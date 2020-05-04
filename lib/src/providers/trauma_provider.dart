import 'package:flutter/foundation.dart';
import 'package:phcapp/src/models/phc.dart';
import 'package:flutter/material.dart';

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

class TraumaProvider extends ChangeNotifier {
  TraumaAssessment traumaAssessment = new TraumaAssessment();

  set setTraumaAssessment(data) => traumaAssessment = data;

  List<ItemModel> prepareData = <ItemModel>[
    ItemModel(
        header: 'Head',
        icon: Icons.sync_problem,
        multiple: true,
        bodyModel: BodyModel(list: _head)),
    ItemModel(
        header: 'Face',
        icon: Icons.accessibility,
        multiple: true,
        bodyModel: BodyModel(list: _head)),
    ItemModel(
        header: 'Neck',
        icon: Icons.directions_walk,
        multiple: true,
        bodyModel: BodyModel(list: _head)),
    ItemModel(
        header: 'Neck abnormality location',
        icon: Icons.accessible_forward,
        multiple: true,
        bodyModel: BodyModel(list: _neck_abnormal)),
    ItemModel(
        header: 'Back',
        icon: Icons.account_balance,
        multiple: true,
        bodyModel: BodyModel(list: _head)),
    ItemModel(
        header: 'Back abnormality location',
        icon: Icons.add_to_photos,
        multiple: true,
        bodyModel: BodyModel(list: _back_abnormal)),
    ItemModel(
        header: 'Spine',
        icon: Icons.surround_sound,
        multiple: true,
        bodyModel: BodyModel(list: _spine)),
    ItemModel(
        header: 'Spine abnormality',
        icon: Icons.tag_faces,
        multiple: true,
        bodyModel: BodyModel(list: _spine_abnormal)),
    ItemModel(
        header: 'Rigth chest',
        icon: Icons.drag_handle,
        multiple: true,
        bodyModel: BodyModel(list: _head)),
    ItemModel(
        header: 'Left chest',
        icon: Icons.dashboard,
        multiple: true,
        bodyModel: BodyModel(list: _head)),
    ItemModel(
        header: 'Abdomen - right upper quadrant',
        icon: Icons.insert_emoticon,
        multiple: true,
        bodyModel: BodyModel(list: _head)),
    ItemModel(
        header: 'Abdomen - left upper quadrant',
        icon: Icons.insert_emoticon,
        multiple: true,
        bodyModel: BodyModel(list: _head)),
    ItemModel(
        header: 'Abdomen - right lower quadrant',
        icon: Icons.insert_emoticon,
        multiple: true,
        bodyModel: BodyModel(list: _head)),
    ItemModel(
        header: 'Abdomen - left lower quadrant',
        icon: Icons.insert_emoticon,
        multiple: true,
        bodyModel: BodyModel(list: _head)),
    ItemModel(
        header: 'Limb - right arm',
        icon: Icons.insert_emoticon,
        multiple: true,
        bodyModel: BodyModel(list: _head)),
    ItemModel(
        header: 'Limb - left arm',
        icon: Icons.insert_emoticon,
        multiple: true,
        bodyModel: BodyModel(list: _head)),
    ItemModel(
        header: 'Limb - right forearm',
        icon: Icons.insert_emoticon,
        multiple: true,
        bodyModel: BodyModel(list: _head)),
    ItemModel(
        header: 'Right hand',
        icon: Icons.insert_emoticon,
        multiple: true,
        bodyModel: BodyModel(list: _head)),
    ItemModel(
        header: 'Left hand',
        icon: Icons.insert_emoticon,
        multiple: true,
        bodyModel: BodyModel(list: _head)),
    ItemModel(
        header: 'Right femur',
        icon: Icons.insert_emoticon,
        multiple: true,
        bodyModel: BodyModel(list: _head)),
    ItemModel(
        header: 'Left femur',
        icon: Icons.accessible_forward,
        multiple: true,
        bodyModel: BodyModel(list: _abdomenAbnorm)),
    ItemModel(
        header: 'Right leg',
        icon: Icons.face,
        multiple: true,
        bodyModel: BodyModel(list: _face)),
    ItemModel(
        header: 'Left leg',
        icon: Icons.face,
        multiple: true,
        bodyModel: BodyModel(list: _face)),
    ItemModel(
        header: 'Right feet',
        icon: Icons.face,
        multiple: true,
        bodyModel: BodyModel(list: _face)),
    ItemModel(
        header: 'Left feet',
        icon: Icons.face,
        multiple: true,
        bodyModel: BodyModel(list: _face)),
  ];
// }
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
