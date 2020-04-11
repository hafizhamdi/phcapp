import 'package:flutter/material.dart';
import 'package:phcapp/custom/choice_chip.dart';

const _airwayDevice = [
  "OPA",
  "NPA",
  "LMA",
  "Laryngeal tube",
  "ETT",
  "Tracheostomy tube"
];
const _oxygen = [
  "Nasal prong",
  "HFM",
  "BVM",
  "Face mask",
  "Venturi mask",
  "NIV"
];
const _extHaemorrhage = ["Bandage", "Haemostatic bandages", "Torniquet"];
const _vascularAccess = ["IV", "IO"];
const _immobilization = [
  "Cervical collar",
  "Spinal board",
  "Pelvic",
  "Upper limb",
  "Lower limb"
];
const _specialCare = [
  "Amputed limb care",
  "Evisceration care",
  "Foreign object stabilization",
];

class Intervention extends StatefulWidget {
  @override
  _InterventionState createState() => _InterventionState();
}

class _InterventionState extends State<Intervention>
    with TickerProviderStateMixin {
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
        header: 'Airway device',
        icon: Icons.sync_problem,
        multiple: true,
        bodyModel: BodyModel(list: _airwayDevice)),
    ItemModel(
        header: 'Oxygen',
        icon: Icons.accessibility,
        multiple: true,
        bodyModel: BodyModel(list: _oxygen)),
    ItemModel(
        header: 'External haemorrhage control method',
        icon: Icons.directions_walk,
        multiple: true,
        bodyModel: BodyModel(list: _extHaemorrhage)),
    ItemModel(
        header: 'Vascular access',
        icon: Icons.accessible_forward,
        multiple: true,
        bodyModel: BodyModel(list: _vascularAccess)),
    ItemModel(
        header: 'Immobilization',
        icon: Icons.account_balance,
        multiple: true,
        bodyModel: BodyModel(list: _immobilization)),
    ItemModel(
        header: 'Special care',
        icon: Icons.add_to_photos,
        multiple: true,
        bodyModel: BodyModel(list: _specialCare)),
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
