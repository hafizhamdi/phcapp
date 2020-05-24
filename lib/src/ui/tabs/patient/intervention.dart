import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phcapp/custom/choice_chip.dart';
import 'package:phcapp/src/blocs/blocs.dart';
import 'package:phcapp/src/models/phc.dart';

enum ActionButton { create, delete }

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
  final InterventionAss interventionAss;

  Intervention({this.interventionAss});

  @override
  _InterventionState createState() => _InterventionState();
}

class _InterventionState extends State<Intervention>
// with TickerProviderStateMixin
{
  var checked = false;
  final Duration animationDuration = Duration(seconds: 5);
  double transitionIconSize = 16.0;

  Animation _checkAnimation;
  AnimationController _checkAnimationController;

  List<String> selectedAirway = List();
  List<String> selectedOxygen = List();
  List<String> selectedExternal = List();
  List<String> selectedVascular = List();
  List<String> selectedImmobilization = List();
  List<String> selectedSpecialCare = List();

  @override
  void initState() {
    print("INITSTATE INTERVENT");

    if (widget.interventionAss != null) {
      selectedAirway = widget.interventionAss.airwayDevice;
      selectedOxygen = widget.interventionAss.oxygen;
      selectedExternal = widget.interventionAss.extHaemorrhage;
      selectedVascular = widget.interventionAss.vascularAccess;
      selectedImmobilization = widget.interventionAss.immobilization;
      selectedSpecialCare = widget.interventionAss.specialCare;

      prepareData.map((f) {
        // if(f.header == "Airway")

        switch (f.header) {
          case "Airway device":
            f.selectedList = selectedAirway;
            break;
          case "Oxygen":
            f.selectedList = selectedOxygen;
            break;
          case "External haemorrhage control method":
            f.selectedList = selectedExternal;
            break;
          case "Vascular access":
            f.selectedList = selectedVascular;
            break;
          case "Immobilization":
            f.selectedList = selectedImmobilization;
            break;
          case "Special care":
            f.selectedList = selectedSpecialCare;
            break;
          default:
            break;
        }
        return f;
      });
    }

    // _checkAnimationController = AnimationController(
    //     vsync: this, duration: Duration(milliseconds: 1200));
    // _checkAnimation = Tween(begin: 20.0, end: 25.0).animate(CurvedAnimation(
    //     curve: Curves.elasticInOut, parent: _checkAnimationController));
    super.initState();
  }

  void callback(String header, List<String> selectedItems) {
    // print(cb.item.toString());
    setState(() {
      switch (header) {
        case "Airway device":
          selectedAirway = selectedItems;
          break;
        case "Oxygen":
          selectedOxygen = selectedItems;
          break;
        case "External haemorrhage control method":
          selectedExternal = selectedItems;
          break;
        case "Vascular access":
          selectedVascular = selectedItems;
          break;
        case "Immobilization":
          selectedImmobilization = selectedItems;
          break;
        case "Special care":
          selectedSpecialCare = selectedItems;
          break;
        default:
          break;
      }
      // prepareData.forEach((f) {

      //   // setState(() {
      //   // print(f.header);
      //   if (f.header == header) {
      //     print(header);
      //     // print(index);
      //     // int idx = prepareData.indexOf();
      //     if (selectedItems.length != 0) {
      //       // f.isChecked = false;

      //       // _checkAnimationController.reverse();
      //       // transitionIconSize = 14.0;
      //       // });
      //       // } else {
      //       // setState(() {
      //       f.isChecked = true;
      //       _checkAnimationController.forward().orCancel;
      //       // transitionIconSize = 25.0;
      //     } else {
      //       f.isChecked = false;
      //       // _checkAnimationController.reverse();
      //       // transitionIconSize = 14.0;
      //     }
      //     // });
      //     // }
      //     // ;
      //   }
      // });
      // // if (prepareData[index].header == item)
      // // checked = true;
    });
  }

  cancelButton() {
    // if (action != ActionButton.delete) {
    return FlatButton(
      child: Text("CANCEL", style: TextStyle(color: Colors.white)),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  createButton() {
    return FlatButton(
        child: Text("SAVE", style: TextStyle(color: Colors.white)),
        onPressed: () {
          print("SAVE pressed!");
          print(selectedAirway.length);
          InterventionAss inter = new InterventionAss(
              timestamp: new DateTime.now(),
              airwayDevice: selectedAirway,
              oxygen: selectedOxygen,
              extHaemorrhage: selectedExternal,
              vascularAccess: selectedVascular,
              immobilization: selectedImmobilization,
              specialCare: selectedSpecialCare);

          BlocProvider.of<InterBloc>(context).add(UpdateInter(inter: inter));

          Navigator.pop(context);
        });
  }

  @override
  Widget build(BuildContext context) {
    // final action = getAction(widget)
    return BlocBuilder<InterBloc, InterState>(
      builder: (context, state) {
        if (state is InterEmpty) {
          InterventionAss inter = new InterventionAss(
              timestamp: new DateTime.now(),
              airwayDevice: selectedAirway,
              oxygen: selectedOxygen,
              extHaemorrhage: selectedExternal,
              vascularAccess: selectedVascular,
              immobilization: selectedImmobilization,
              specialCare: selectedSpecialCare);

          BlocProvider.of<InterBloc>(context).add(LoadInter(inter: inter));
        } else if (state is InterLoaded) {
          // setState(() {
          final newData = prepareData.map((f) {
            switch (f.header) {
              case "Airway device":
                f.selectedList = state.inter.airwayDevice;
                // selectedAirway = selectedItems;
                break;
              case "Oxygen":
                f.selectedList = state.inter.oxygen;
                // selectedOxygen = selectedItems;
                break;
              case "External haemorrhage control method":
                f.selectedList = state.inter.extHaemorrhage;
                break;
              case "Vascular access":
                f.selectedList = state.inter.vascularAccess;
                break;
              case "Immobilization":
                f.selectedList = state.inter.immobilization;
                break;
              case "Special care":
                f.selectedList = state.inter.specialCare;
                // selectedSpecialCare = selectedItems;
                break;
              default:
                break;
            }
            return f;
          }).toList();
          // });

          return Scaffold(
              appBar: AppBar(
                //  textTheme: themeProvider.getThemeData,
                title: Text(
                  'Intervention',
                ),
                actions: <Widget>[cancelButton(), createButton()],
              ),
              // body: Icon(Icons.toys),
              body: Container(
                  padding: EdgeInsets.all(10),
                  child: ListView.builder(
                      itemCount: newData.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                            child: ListTile(
                          title: Padding(
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(newData[index].header),
                                    //   AnimatedBuilder(
                                    //       animation: _checkAnimationController,
                                    //       builder: (context, child) {
                                    //         return Center(
                                    //             child: Container(
                                    //                 // padding: EdgeInsets.all(10.0),
                                    //                 child: Center(
                                    //                     child: Icon(
                                    //                         newData[index].isChecked
                                    //                             ? Icons.check_circle //,
                                    //                             : Icons
                                    //                                 .check_circle_outline,
                                    //                         color: newData[index]
                                    //                                 .isChecked
                                    //                             ? Colors.green
                                    //                             : Colors.grey,
                                    //                         size: newData[index]
                                    //                                 .isChecked
                                    //                             ? _checkAnimation.value
                                    //                             : 20.0
                                    //                         // size: (newData[index]
                                    //                         //             .isChecked !=
                                    //                         //         false)
                                    //                         //     ? _checkAnimation.value
                                    //                         //     : null
                                    //                         // : 20,
                                    //                         ))));
                                    //       })
                                  ]),
                              padding: EdgeInsets.symmetric(vertical: 10.0)),
                          subtitle:
                              //  Wrap(
                              //   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //   children: <Widget>[
                              SingleOption(
                            header: newData[index].header,
                            stateList: newData[index].bodyModel.list,
                            callback: callback,
                            multiple: newData[index].multiple,
                            initialData: newData[index].selectedList,
                          ),

                          // ],
                          // ),
                        ));
                      })));
        }
        return Container();
        // }
      },
    );
  }

  List<ItemModel> prepareData = <ItemModel>[
    ItemModel(
        header: 'Airway device',
        icon: Icons.sync_problem,
        multiple: true,
        // selectedList: selectedAirway,
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
  List<String> selectedList;

  ItemModel(
      {this.isChecked: false,
      this.header,
      this.icon,
      this.bodyModel,
      this.multiple,
      this.selectedList});
}

class BodyModel {
  List<String> list;
  IconData icon;
  // int quantity;

  BodyModel({this.list});
}
