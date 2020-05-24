import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phcapp/src/blocs/vital_bloc.dart';
import 'package:phcapp/src/models/phc.dart';
import 'package:phcapp/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

enum ItemInput { singlePoint, doublePoint }
enum ActionButton { delete, create }

class VitalDetail extends StatefulWidget {
  final VitalSign vitalSign;
  final index;

  VitalDetail({this.vitalSign, this.index});

  @override
  _VitalDetailState createState() => _VitalDetailState();
}

class _VitalDetailState extends State<VitalDetail> {
  // ControllerInput
  String _timestamp =
      DateFormat("HH:mm aa").format(new DateTime.now()).toString();
  int totalGcs = 0;

  NumberPicker bpSysPicker = new NumberPicker();
  NumberPicker bpDiasPicker = new NumberPicker();
  NumberPicker mapPicker = new NumberPicker();
  NumberPicker prPicker = new NumberPicker();
  NumberPicker ppPicker = new NumberPicker();
  NumberPicker pvPicker = new NumberPicker();
  NumberPicker crtPicker = new NumberPicker();
  NumberPicker siPicker = new NumberPicker();
  NumberPicker rrPicker = new NumberPicker();
  NumberPicker spo2Picker = new NumberPicker();
  NumberPicker tempPicker = new NumberPicker();
  NumberPicker psPicker = new NumberPicker();
  NumberPicker bgPicker = new NumberPicker();
  NumberPicker lpPicker = new NumberPicker();
  NumberPicker rpPicker = new NumberPicker();
  NumberPicker gcsEpicker = new NumberPicker();
  NumberPicker gcsVpicker = new NumberPicker();
  NumberPicker gcsMpicker = new NumberPicker();
  NumberPicker gcsTotalpicker = new NumberPicker();

  VitalBloc vitalBloc;

  @override
  initState() {
    print("INIT STATE VITAL DETAIL");

    if (widget.vitalSign != null) {
      bpSysPicker = new NumberPicker(
          value: checkIsNumberNotNull(widget.vitalSign.bpSystolic));

      bpDiasPicker = new NumberPicker(
          value: checkIsNumberNotNull(widget.vitalSign.bpDiastolic));
      mapPicker =
          new NumberPicker(option: checkIsStringNotNull(widget.vitalSign.map));
      prPicker =
          new NumberPicker(value: checkIsNumberNotNull(widget.vitalSign.pr));
      ppPicker = new NumberPicker(
          value: checkIsNumberNotNull(widget.vitalSign.pulsePressure));
      pvPicker = new NumberPicker(
          value: checkIsNumberNotNull(widget.vitalSign.pulseVolume));
      crtPicker =
          new NumberPicker(value: checkIsNumberNotNull(widget.vitalSign.crt));
      siPicker = new NumberPicker(
          option: checkIsStringNotNull(widget.vitalSign.shockIndex));
      rrPicker =
          new NumberPicker(value: checkIsNumberNotNull(widget.vitalSign.rr));
      spo2Picker =
          new NumberPicker(value: checkIsNumberNotNull(widget.vitalSign.spo2));
      tempPicker = new NumberPicker();
      psPicker = new NumberPicker(
          value: checkIsNumberNotNull(widget.vitalSign.painScore));
      bgPicker = new NumberPicker(
          value: checkIsNumberNotNull(widget.vitalSign.bloodGlucose));
      lpPicker = new NumberPicker(
          value: checkIsNumberNotNull(widget.vitalSign.pupil.leftSize),
          option:
              checkIsStringNotNull(widget.vitalSign.pupil.leftResponseTolight));
      rpPicker = new NumberPicker(
          value: checkIsNumberNotNull(widget.vitalSign.pupil.rightSize),
          option: checkIsStringNotNull(
              widget.vitalSign.pupil.rightResponseTolight));
      gcsEpicker =
          new NumberPicker(value: checkIsNumberNotNull(widget.vitalSign.e));
      gcsVpicker =
          new NumberPicker(value: checkIsNumberNotNull(widget.vitalSign.v));
      gcsMpicker =
          new NumberPicker(value: checkIsNumberNotNull(widget.vitalSign.m));
      gcsTotalpicker =
          new NumberPicker(value: checkIsNumberNotNull(widget.vitalSign.gcs));
    }
  }

  @override
  didChangeDependencies() {}

  checkIsNumberNotNull(value) {
    if (value == null) return null;
    return int.tryParse(value);
  }

  checkIsStringNotNull(value) {
    if (value == "null") return "";
    return value;
  }

  getActionPicker(labelName) {
    switch (labelName) {
      case "BP Systolic":
        return ItemInput.singlePoint;
        break;
      case "BP Diastolic":
        return ItemInput.singlePoint;
        break;
      default:
        return ItemInput.doublePoint;
        break;
    }
  }

  Widget _buildItemGCS(
      context, NumberPicker ePicker, vPicker, mPicker, totalPicker, title) {
    return Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.only(left: 8, top: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            shape: BoxShape.rectangle,
            border: Border.all(color: Colors.grey, width: 0.5)),
        width: 160,
        height: 220,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(title,
                    textAlign: TextAlign.left, style: TextStyle(fontSize: 16)
                    // style: TextStyle(color: Colors.white),
                    ),
              ],
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(right: 40),
                      child: Text(
                        "E",
                        textAlign: TextAlign.left,
                        // style: TextStyle(color: Colors.white),
                      )),
                  Text(
                    ePicker.getValue != null ? ePicker.getValue.toString() : '',
                    // decimalFormating(,
                    style: TextStyle(
                      fontSize: 30,
                      // color: Colors.purple[200]
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.edit),
                    color: Colors.grey,
                    iconSize: 25,
                    onPressed: () {
                      showCupertinoModalPopup(
                          context: context,
                          builder: (context) =>
                              cupertinoPicker(ePicker, "GCS E", 5, 1));
                      // showCupertinoModalPopup(
                      //     context: context,
                      //     builder: (context) => _actionSinglePicker(
                      //         "E", controller, callbackGcs, 5));
                    },
                  )
                ]),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(right: 40),
                      child: Text(
                        "V",
                        textAlign: TextAlign.left,
                        // style: TextStyle(color: Colors.white),
                      )),
                  //,
                  Text(
                    vPicker.getValue != null ? vPicker.getValue.toString() : '',
                    style: TextStyle(
                      fontSize: 30,
                      // color: Colors.purple[200]
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.edit),
                    color: Colors.grey,
                    iconSize: 25,
                    onPressed: () {
                      showCupertinoModalPopup(
                          context: context,
                          builder: (context) =>
                              cupertinoPicker(vPicker, "GCS V", 6, 1));

                      // showCupertinoModalPopup(
                      //     context: context,
                      //     builder: (context) => _actionSinglePicker(
                      //         "V", controller, callbackGcs, 6));
                    },
                  )
                ]),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(right: 40),
                      child: Text(
                        "M",
                        textAlign: TextAlign.left,
                        // style: TextStyle(color: Colors.white),
                      )),
                  Text(
                    mPicker.getValue != null ? mPicker.getValue.toString() : '',
                    style: TextStyle(
                      fontSize: 30,
                      // color: Colors.purple[200]
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.edit),
                    color: Colors.grey,
                    iconSize: 25,
                    onPressed: () {
                      showCupertinoModalPopup(
                          context: context,
                          builder: (context) =>
                              cupertinoPicker(mPicker, "GCS M", 7, 1));
                      // showCupertinoModalPopup(
                      //     context: context,
                      //     builder: (context) => _actionSinglePicker(
                      //         "M", controller, callbackGcs, 7));
                    },
                  )
                ]),
            Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(right: 39),
                      child: Text(
                        "Total",
                        textAlign: TextAlign.left,
                        // style: TextStyle(color: Colors.white),
                      )),
                  Text(
                    totalPicker.getValue != null
                        ? totalPicker.getValue.toString()
                        : '',

                    style: TextStyle(
                      fontSize: 30,
                      // color: Colors.purple[200]
                    ),
                    // )
                  ),
                ])
          ],
        )); //,
    // );
  }

  int selectPicker(title, first, second, third) {
    switch (title) {
      case "E":
        return first;
        break;
      case "V":
        return second;
        break;
      case "M":
        return third;
        break;
      default:
        return 0;
    }
  }

  Widget _actionSinglePicker(title, controller, callback, range) {
    // controller.setTitle(title);
    return SizedBox(
        height: 200,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Expanded(
                  child: CupertinoPicker(
                      scrollController: FixedExtentScrollController(
                          initialItem: selectPicker(
                              title,
                              controller.firstValue,
                              controller.secondValue,
                              controller.thirdValue)),
                      itemExtent: 50,
                      onSelectedItemChanged: (int index) {
                        print(index);
                        if (title == "E") controller.setFirstValue(index);
                        if (title == "V") controller.setSecondValue(index);
                        if (title == "M") controller.setThirdValue(index);

                        if (title == "Right Pupil")
                          controller.setFirstValue(index);
                        if (title == "Left Pupil")
                          controller.setFirstValue(index);
                        if (title == "BP Systolic")
                          controller.setFirstValue(index);

                        callback(controller);
                        // setState(() {
                        //   controller.first_value = index.toString();
                        // });
                      },
                      children: List<Widget>.generate(
                          range, (int index) => Text(index.toString())))),
            ]));
  }

  Widget _buildItemPupil(
      context, NumberPicker picker, title, itemCount, initialData) {
    return Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.only(left: 8, top: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            shape: BoxShape.rectangle,
            border: Border.all(color: Colors.grey, width: 0.5)),
        width: 160,
        height: 170,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text(title,
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 16)
                        // style: TextStyle(color: Colors.white),
                        )),
              ],
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    picker.getValue != null ? picker.getValue.toString() : '',
                    style: TextStyle(
                      fontSize: 40,
                      // color: Colors.purple[200]
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.edit),
                    color: Colors.grey,
                    iconSize: 25,
                    onPressed: () {
                      showCupertinoModalPopup(
                          context: context,
                          builder: (context) => cupertinoPicker(
                              picker, title, itemCount, initialData));
                    },
                  )
                ]),
            Padding(
                padding: EdgeInsets.only(top: 10),
                child: Row(
                  children: <Widget>[
                    Text(
                      "Response to light",
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                )),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    picker.getOption != null ? picker.getOption : '',
                    style: TextStyle(
                      fontSize: 25,
                      // color: Colors.purple[200]
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.edit),
                    color: Colors.grey,
                    iconSize: 25,
                    onPressed: () {
                      showCupertinoModalPopup(
                          context: context,
                          builder: (context) => pupilPicker(picker, title));
                    },
                  )
                ])
          ],
        )); //,
    // );
  }

  Widget _buildItem(
      context, NumberPicker picker, title, itemCount, initialData) {
    // print(title);
    var doneButton = CupertinoButton(
      child: Text("Done"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    if (title == "MAP" || title == "Shock Index") {
      return Container(
          margin: EdgeInsets.all(5),
          padding: EdgeInsets.only(left: 8, top: 8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              shape: BoxShape.rectangle,
              border: Border.all(color: Colors.grey, width: 0.5)),
          width: 160,
          height: 100,
          child: Column(children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text(title,
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 16)
                        // style: TextStyle(color: Colors.white),
                        )),
              ],
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    picker.getOption != null ? picker.getOption.toString() : '',
                    // decimalFormating(
                    //     controller.firstValue, controller.secondValue),
                    style: TextStyle(
                      fontSize: 40,
                      // color:
                      //     picker.getAbnormal ? Colors.red : null
                      // color: Colors.purple[200]
                    ),
                  ),
                  // IconButton(
                  //     icon: Icon(Icons.edit),
                  //     color: Colors.grey,
                  //     iconSize: 25,
                  //     onPressed: () {
                  //       showCupertinoModalPopup(
                  //           context: context,
                  //           builder: (context) => cupertinoPicker(
                  //               picker, title, itemCount, initialData));
                  //       // ItemInput.singlePoint == getActionPicker(title)
                  //       //     ? showCupertinoModalPopup(
                  //       //         context: context,
                  //       //         builder: (context) => _actionSinglePicker(
                  //       //             title, controller, callbackSingle, range))
                  //       //     : showCupertinoModalPopup(
                  //       //         context: context,
                  //       //         builder: (context) => _actionDoublePicker(
                  //       //             title, controller, callbackSingle));
                  //     })
                ])
          ])); //);
    }
    return Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.only(left: 8, top: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            shape: BoxShape.rectangle,
            border: Border.all(color: Colors.grey, width: 0.5)),
        width: 160,
        height: 100,
        child: Column(children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text(title,
                      textAlign: TextAlign.left, style: TextStyle(fontSize: 16)
                      // style: TextStyle(color: Colors.white),
                      )),
            ],
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  picker.getValue != null ? picker.getValue.toString() : '',
                  // decimalFormating(
                  //     controller.firstValue, controller.secondValue),
                  style: TextStyle(
                      fontSize: 40,
                      color:
                          picker.getAbnormal == true ? Colors.redAccent : null),
                ),
                IconButton(
                    icon: Icon(Icons.edit),
                    color: Colors.grey,
                    iconSize: 25,
                    onPressed: () {
                      showCupertinoModalPopup(
                          context: context,
                          builder: (context) => cupertinoPicker(
                              picker, title, itemCount, initialData));
                    })
              ])
        ]));
  }

  String decimalFormating(first, second) {
    if (first == 0 && second == 0)
      return "";
    else if (first != null && second != null)
      return first.toString() + "." + second.toString();
    else if (first != null)
      return first.toString();
    else if (second != null) return "." + second.toString();
    return "";
  }

  Widget _actionDoublePicker(title, controller, callback) {
    controller.setTitle(title);
    return SizedBox(
        height: 200,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Expanded(
                  child: CupertinoPicker(
                      scrollController: FixedExtentScrollController(
                          initialItem: controller.firstValue),
                      // magnification: 1.5,
                      itemExtent: 50,
                      onSelectedItemChanged: (int index) {
                        print(index);
                        controller.setFirstValue(index);
                        // ControllerInput ci = new ControllerInput(
                        // title: title, first: index.toString());
                        callback(controller);
                        // setState(() {
                        //   controller.setFirstValue = index.toString();
                        //   // controller =
                        //   //     new ControllerInput(first: index.toString());
                        //   // controller.firstValue = index.toString();
                        // });
                      },
                      children: List<Widget>.generate(
                          200, (int index) => Text(index.toString())))),
              Expanded(
                  child: CupertinoPicker(
                      itemExtent: 50,
                      scrollController: FixedExtentScrollController(
                          initialItem: controller.secondValue),
                      onSelectedItemChanged: (int index) {
                        controller.setSecondValue(index);
                        // ControllerInput ci = new ControllerInput(
                        // title: title, second: index.toString());
                        callback(controller);

                        // print(index);
                        // setState(() {
                        // controller.setSecondValue = index.toString();

                        // controller.secondValue = index.toString();
                        // });
                      },
                      children: List<Widget>.generate(
                          10, (int index) => Text(index.toString()))))
            ]));
  }

  String appendDecimal(first, second) {
    return (first.toString() + "." + second.toString());
  }

  ActionButton getAction(index) {
    print("WHAT INDEX:" + index.toString());
    if (index == null)
      return ActionButton.create;
    else
      return ActionButton.delete;
  }

  cancelButton(action, index) {
    if (action != ActionButton.delete) {
      return FlatButton(
        child: Text("CANCEL", style: TextStyle(color: Colors.white)),
        onPressed: () {
          Navigator.pop(context);
        },
      );
    } else {
      return FlatButton(
          child: Text("DELETE", style: TextStyle(color: Colors.white)),
          onPressed: () {
            vitalBloc.add(RemoveVital(index: index));
            Navigator.pop(context);
          });
    }
  }

  String transformBlankNull(number) {
    if (number == null) {
      return null;
    }
    return number.toString();
  }

  createButton(action, index) {
    if (action == ActionButton.create) {
      return FlatButton(
        child: Text("CREATE", style: TextStyle(color: Colors.white)),
        onPressed: () {
          int len = vitalBloc.state.listVitals.length != null
              ? vitalBloc.state.listVitals.length
              : 0;

          VitalSign vs = new VitalSign(
              id: (len + 1).toString(),
              created: new DateTime.now(),
              bpSystolic: transformBlankNull(bpSysPicker.getValue),
              bpDiastolic: transformBlankNull(bpDiasPicker.getValue),
              map: transformBlankNull(mapPicker.getOption),
              pr: transformBlankNull(prPicker.getValue),
              pulsePressure: transformBlankNull(ppPicker.getValue),
              pulseVolume: transformBlankNull(pvPicker.getValue),
              crt: transformBlankNull(crtPicker.getValue),
              rr: transformBlankNull(rrPicker.getValue),
              spo2: transformBlankNull(spo2Picker.getValue),
              temp: transformBlankNull(tempPicker.getValue),
              painScore: transformBlankNull(psPicker.getValue),
              bloodGlucose: transformBlankNull(bgPicker.getValue),
              shockIndex: transformBlankNull(siPicker.getOption),
              pupil: Pupil(
                  leftResponseTolight: transformBlankNull(lpPicker.getOption),
                  leftSize: transformBlankNull(lpPicker.getValue),
                  rightResponseTolight: transformBlankNull(rpPicker.getOption),
                  rightSize: rpPicker.getValue.toString()),
              e: transformBlankNull(gcsEpicker.getValue),
              v: transformBlankNull(gcsVpicker.getValue),
              m: transformBlankNull(gcsMpicker.getValue),
              gcs: transformBlankNull(gcsTotalpicker.getValue));

          print("Vital Sigs");
          // print(vs.toJson());
          vitalBloc.add(AddVital(vital: vs));

          Navigator.pop(context);
        },
      );
    } else {
      //save -update button
      return FlatButton(
          child: Text("SAVE", style: TextStyle(color: Colors.white)),
          onPressed: () {
            VitalSign vs = new VitalSign(
                // id: (index + 1).toString(),
                // id: (vitalBloc.state.listVitals.length + 1).toString(),
                created: new DateTime.now(),
                bpSystolic: bpSysPicker.getValue.toString(),
                bpDiastolic: bpDiasPicker.getValue.toString(),
                map: mapPicker.getOption.toString(),
                pr: prPicker.getValue.toString(),
                pulsePressure: ppPicker.getValue.toString(),
                pulseVolume: pvPicker.getValue.toString(),
                crt: crtPicker.getValue.toString(),
                rr: rrPicker.getValue.toString(),
                spo2: spo2Picker.getValue.toString(),
                temp: tempPicker.getValue.toString(),
                painScore: psPicker.getValue.toString(),
                bloodGlucose: bgPicker.getValue.toString(),
                shockIndex: siPicker.getOption.toString(),
                pupil: Pupil(
                    leftResponseTolight: lpPicker.getOption.toString(),
                    leftSize: lpPicker.getValue.toString(),
                    rightResponseTolight: rpPicker.getOption.toString(),
                    rightSize: rpPicker.getValue.toString()),
                e: gcsEpicker.getValue.toString(),
                v: gcsVpicker.getValue.toString(),
                m: gcsMpicker.getValue.toString(),
                gcs: gcsTotalpicker.getValue.toString());

            vitalBloc.add(UpdateVital(index: index, vital: vs));

            Navigator.pop(context);
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    vitalBloc = BlocProvider.of<VitalBloc>(context);

    final action = getAction(widget.index);
    setState(() {
      if (gcsEpicker.getValue != null &&
          gcsMpicker.getValue != null &&
          gcsVpicker.getValue != null) {
        var total =
            gcsEpicker.getValue + gcsMpicker.getValue + gcsVpicker.getValue;
        gcsTotalpicker.setValue(total);
        // print(total);
      }

      if (bpSysPicker.getValue != null && bpDiasPicker.getValue != null) {
        var map = (bpSysPicker.getValue + (2 * bpDiasPicker.getValue) / 3);
        var mapStr = double.parse(map.toString()).toStringAsFixed(2);
        mapPicker.setOption(mapStr);
        // print(map);
        // print(mapStr);
      }

      if (bpSysPicker.getValue != null && bpDiasPicker.getValue != null) {
        var pp = bpSysPicker.getValue - bpDiasPicker.getValue;

        ppPicker.setValue(pp);
      }

      if (prPicker.getValue != null && bpSysPicker.getValue != null) {
        var shockIndex = prPicker.getValue / bpSysPicker.getValue;

        var siStr = double.parse(shockIndex.toString()).toStringAsFixed(2);
        siPicker.setOption(siStr);

        // print("shock index");
        // print(siStr);
      }
      changeColorAbnormal();
    });

    // final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      // backgroundColor: Colors.grey[900],
      appBar: AppBar(
          //  textTheme: themeProvider.getThemeData,
          title: Text(
            'Vital signs',
          ),
          actions: <Widget>[
            cancelButton(action, widget.index),
            createButton(action, widget.index)
          ],
          backgroundColor: Colors.purple),
      body: SingleChildScrollView(
          child: Center(
              child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  child: Wrap(
                    // alignment: Alignment.center,
                    children: <Widget>[
                      Center(
                          child: Padding(
                              padding: EdgeInsets.all(10),
                              child: widget.vitalSign == null
                                  ? Text("Last changes at " + _timestamp)
                                  : Text("Last changes at " +
                                      DateFormat("HH:mm aa")
                                          .format(widget.vitalSign.created)))),
                      _buildItem(context, bpSysPicker, "BP Systolic", 200, 90),
                      _buildItem(
                          context, bpDiasPicker, "BP Diastolic", 200, 60),
                      // _buildItem(
                      //     context, "BP Diastolic", bpDiasController, 200),
                      _buildItem(context, mapPicker, "MAP", 200, 100),
                      _buildItem(context, prPicker, "PR", 200, 60),
                      _buildItem(context, ppPicker, "Pulse Pressure", 200, 20),
                      _buildItem(context, pvPicker, "Pulse Volume", 200, 100),
                      _buildItem(context, crtPicker, "CRT", 200, 100),
                      _buildItem(context, siPicker, "Shock Index", 200, 100),
                      _buildItem(context, rrPicker, "RR", 100, 1),
                      _buildItem(context, spo2Picker, "Sp02", 200, 95),
                      _buildItem(context, tempPicker, "Temperature", 100, 30),
                      _buildItem(context, psPicker, "Pain Score", 11, 1),
                      _buildItem(context, bgPicker, "Blood Glucose", 200, 100),
                      _buildItemPupil(context, lpPicker, "Left Pupil", 9, 1),
                      _buildItemPupil(context, rpPicker, "Right Pupil", 9, 1),
                      // _buildItemPupil(context, "Right Pupil", rpController),
                      _buildItemGCS(context, gcsEpicker, gcsVpicker, gcsMpicker,
                          gcsTotalpicker, "GCS"),
                    ],
                  )))),
    );
  }

  pupilPicker(NumberPicker picker, title) {
    const list = ["Reactive", "Sluggish", "Fixed"];
    // controller.setTitle(title);
    return SizedBox(
        height: 200,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Expanded(
                  child: CupertinoPicker(
                      itemExtent: 50,
                      scrollController: FixedExtentScrollController(
                          initialItem: list
                              .indexWhere((item) => item == picker.getOption)),
                      onSelectedItemChanged: (int index) {
                        setState(() {
                          picker.setOption(list[index]);
                        });
                        // controller.setText(list[index]);
                        // callback(controller);
                        // print(index);
                      },
                      children: List<Widget>.generate(
                          list.length, (int index) => Text(list[index]))

                      // generate(
                      //         200, (int index) => Text(index.toString())))
                      // Text("Sluggish")
                      // ]
                      )),
              // Expanded(
              //     child: CupertinoPicker(
              //         itemExtent: 50,
              //         onSelectedItemChanged: (int index) {
              //           print(index);
              //         },
              //         children: List<Widget>.generate(
              //             10, (int index) => Text(index.toString()))))
            ]));
  }

  changeColorAbnormal() {
    print("Change color abnormal");

    // BP SYSTOLIC
    if (bpSysPicker.getValue != null) {
      (bpSysPicker.getValue < 90 || bpSysPicker.getValue > 139)
          ? bpSysPicker.setAbnormal(true)
          : bpSysPicker.setAbnormal(false);
    }

    // BP DIASTOLIC
    if (bpDiasPicker.getValue != null) {
      (bpDiasPicker.getValue < 60 || bpDiasPicker.getValue > 89)
          ? bpDiasPicker.setAbnormal(true)
          : bpDiasPicker.setAbnormal(false);
    }

    // PULSE RATE
    if (prPicker.getValue != null) {
      (prPicker.getValue < 60 || prPicker.getValue > 90)
          ? prPicker.setAbnormal(true)
          : prPicker.setAbnormal(false);
    }

    // RR
    if (rrPicker.getValue != null) {
      (rrPicker.getValue >= 20)
          ? prPicker.setAbnormal(true)
          : prPicker.setAbnormal(false);
    }

    // SpO2
    if (spo2Picker.getValue != null) {
      (spo2Picker.getValue < 95 || spo2Picker.getValue > 200)
          ? spo2Picker.setAbnormal(true)
          : spo2Picker.setAbnormal(false);
    }

    //PULSE PRESSURE
    if (ppPicker.getValue != null) {
      (ppPicker.getValue < 20 || ppPicker.getValue > 100)
          ? ppPicker.setAbnormal(true)
          : ppPicker.setAbnormal(false);
    }
  }

  cupertinoPicker(NumberPicker picker, title, itemCount, initialData) {
    var titleButton = CupertinoButton(
      child: Text(title),
      onPressed: () {
        // Navigator.of(context).pop();
      },
    );
    var doneButton = CupertinoButton(
      child: Text("Done"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    return SizedBox(
        height: 200.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
                alignment: Alignment.centerRight,
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(249, 249, 247, 1.0),
                    border: Border(
                        bottom: const BorderSide(
                            width: 0.5, color: Colors.black38))),
                child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [titleButton, doneButton]))),
            Expanded(
                child: CupertinoPicker(
                    scrollController:
                        FixedExtentScrollController(initialItem: initialData),
                    itemExtent: 50,
                    onSelectedItemChanged: (int index) {
                      print("onselecteditemchanged --cupertinopicker");
                      print(index);

                      setState(() {
                        picker.setValue(index);
                      });
                      print(picker.getValue);
                    },
                    children: List<Widget>.generate(
                        itemCount, (int index) => Text(index.toString()))))
          ],
        ));
  }
}

// Widget

class NumberPicker {
// extends ChangeNotifier {
  String title;
  String option;
  int value;
  int decimal;
  bool abnormal = false;

  NumberPicker(
      {this.title, this.option, this.value, this.abnormal, this.decimal});

  setOption(_option) {
    option = _option;
  }

  setTitle(_title) {
    title = _title;
  }

  setValue(_value) {
    value = _value;
  }

  setAbnormal(_select) {
    abnormal = _select;
  }

  setDecimal(_value) {
    decimal = _value;
  }

  String get getTitle => title;
  String get getOption => option;
  int get getValue => value;
  int get getDecimal => decimal;
  bool get getAbnormal => abnormal;
}
