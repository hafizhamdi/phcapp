import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phcapp/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class VitalDetail extends StatefulWidget {
  VitalDetail({Key key}) : super(key: key);

  @override
  _VitalDetailState createState() => _VitalDetailState();
}

class _VitalDetailState extends State<VitalDetail> {
  // ControllerInput
  String _timestamp =
      DateFormat("dd/MM/yyyy HH:mm:ss").format(new DateTime.now()).toString();
  int totalGcs = 0;

  //  ControllerInput gcsController = new ControllerInput();
  ControllerInput bpSysController = new ControllerInput(first: 0, second: 0);
  ControllerInput bpDiasController = new ControllerInput(first: 0, second: 0);
  ControllerInput mapController = new ControllerInput(first: 0, second: 0);
  ControllerInput prController = new ControllerInput(first: 0, second: 0);
  ControllerInput ppController = new ControllerInput(first: 0, second: 0);
  ControllerInput pvController = new ControllerInput(first: 0, second: 0);
  ControllerInput crtController = new ControllerInput(first: 0, second: 0);
  ControllerInput siController = new ControllerInput(first: 0, second: 0);
  ControllerInput rrController = new ControllerInput(first: 0, second: 0);
  ControllerInput spo2Controller = new ControllerInput(first: 0, second: 0);
  ControllerInput tempController = new ControllerInput(first: 0, second: 0);
  ControllerInput psController = new ControllerInput(first: 0, second: 0);
  ControllerInput bgController = new ControllerInput(first: 0, second: 0);
  ControllerInput lpController =
      new ControllerInput(first: 0, second: 0, text: "");
  ControllerInput rpController =
      new ControllerInput(first: 0, second: 0, text: "");
  ControllerInput gcsController =
      new ControllerInput(first: 0, second: 0, third: 0);

  @override
  initState() {
    // bpSysController.first_value.text = "1";
    // bpSysController.second_value.text = "1";

    // gcsController.first_value.text = "1";
    // gcsController.second_value.text = "1";
    // gcsController.third_value.text = "1";
  }

  Widget _buildItemGCS(context, title, controller) {
    return Card(
      // color: Colors.white10,
      elevation: 2.4,
      child: Container(
          padding: EdgeInsets.only(left: 8, top: 8),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          width: 160,
          height: 220,
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(title,
                      textAlign: TextAlign.left, style: TextStyle(fontSize: 20)
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
                      controller.firstValue.toString(),
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
                            builder: (context) => _actionSinglePicker(
                                "E", controller, callbackGcs, 5));
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
                      controller.secondValue.toString(),
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
                            builder: (context) => _actionSinglePicker(
                                "V", controller, callbackGcs, 6));
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
                      controller.thirdValue.toString(),
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
                            builder: (context) => _actionSinglePicker(
                                "M", controller, callbackGcs, 7));
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
                      controller.responseText != null
                          ? controller.responseText
                          : '',
                      style: TextStyle(
                        fontSize: 30,
                        // color: Colors.purple[200]
                      ),
                      // )
                    ),
                  ])
            ],
          )),
    );
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

                        callback(controller);
                        // setState(() {
                        //   controller.first_value = index.toString();
                        // });
                      },
                      children: List<Widget>.generate(
                          range, (int index) => Text(index.toString())))),
            ]));
  }

  Widget _buildItemPupil(context, title, controller) {
    return Card(
      // color: Colors.white10,
      elevation: 2.4,
      child: Container(
          padding: EdgeInsets.only(left: 8, top: 8),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
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
                          style: TextStyle(fontSize: 20)
                          // style: TextStyle(color: Colors.white),
                          )),
                ],
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      controller.firstValue.toString() == "0"
                          ? ""
                          : controller.firstValue.toString(),
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
                            builder: (context) => _actionSinglePicker(
                                title, controller, callbackPupil, 9));
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
                      controller.responseText,
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
                            builder: (context) => _actionPupilPicker(
                                title, controller, callbackPupil));
                      },
                    )
                  ])
            ],
          )),
    );
  }

  Widget _buildItem(context, title, controller) {
    var doneButton = CupertinoButton(
      child: Text("Done"),
      onPressed: () {
        // setState(() {
        //   _dateTime = new DateFormat("dd/MM/yyyy HH:mm:ss")
        //       .format(_cupertinoTime)
        //       .toString();
        // });
        Navigator.of(context).pop();
      },
    );
    return Card(
        // color: Colors.white10,
        elevation: 2.4,
        child: Container(
            padding: EdgeInsets.only(left: 8, top: 8),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            width: 160,
            height: 100,
            child: Column(children: <Widget>[
              Row(
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Text(title,
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 20)
                          // style: TextStyle(color: Colors.white),
                          )),
                ],
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      decimalFormating(
                          controller.firstValue, controller.secondValue),
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
                              builder: (context) => _actionDoublePicker(
                                  title, controller, callbackDouble));
                        })
                  ])
            ])));
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

  void callbackGcs(ControllerInput data) {
    setState(() {
      totalGcs = 0;
      gcsController.setFirstValue(data.firstValue);
      gcsController.setSecondValue(data.secondValue);
      gcsController.setThirdValue(data.thirdValue);

      totalGcs += data.firstValue;
      totalGcs += data.secondValue;
      totalGcs += data.thirdValue;

      gcsController.setText(totalGcs.toString());
    });
    // if (data.title == "BP Systolic") {
    // print(data.secondValue);
    // }
  }

  void callbackPupil(ControllerInput data) {
    setState(() {
      if (data.title == "Left Pupil") {
        lpController.setFirstValue(data.firstValue);
        lpController.setText(data.responseText);
      }

      if (data.title == "Right Pupil") {
        rpController.setFirstValue(data.firstValue);
        rpController.setText(data.responseText);
      }
    });
  }

  void callbackDouble(ControllerInput data) {
    print(data.title);
    setState(() {
      // print()
      if (data.title == "BP Systolic") {
        bpSysController.setFirstValue(data.firstValue);
        bpSysController.setSecondValue(data.secondValue);
        // print(data.secondValue);
      }
      if (data.title == "BP Diastolic") {
        bpDiasController.setFirstValue(data.firstValue);
        bpDiasController.setSecondValue(data.secondValue);
        // print(data.secondValue);
      }
      if (data.title == "MAP") {
        mapController.setFirstValue(data.firstValue);
        mapController.setSecondValue(data.secondValue);
        // print(data.secondValue);
      }
      if (data.title == "PR") {
        prController.setFirstValue(data.firstValue);
        prController.setSecondValue(data.secondValue);
        // print(data.secondValue);
      }
      if (data.title == "Pulse Pressure") {
        ppController.setFirstValue(data.firstValue);
        ppController.setSecondValue(data.secondValue);
        // print(data.secondValue);
      }
      if (data.title == "Pulse Volume") {
        pvController.setFirstValue(data.firstValue);
        pvController.setSecondValue(data.secondValue);
        // print(data.secondValue);
      }
      if (data.title == "CRT") {
        crtController.setFirstValue(data.firstValue);
        crtController.setSecondValue(data.secondValue);
        // print(data.secondValue);
      }
      if (data.title == "RR") {
        rrController.setFirstValue(data.firstValue);
        rrController.setSecondValue(data.secondValue);
        // print(data.secondValue);
      }
      if (data.title == "Sp02") {
        spo2Controller.setFirstValue(data.firstValue);
        spo2Controller.setSecondValue(data.secondValue);
        // print(data.secondValue);
      }
      if (data.title == "Temperature") {
        tempController.setFirstValue(data.firstValue);
        tempController.setSecondValue(data.secondValue);
        // print(data.secondValue);
      }
      if (data.title == "Pain Score") {
        psController.setFirstValue(data.firstValue);
        psController.setSecondValue(data.secondValue);
        // print(data.secondValue);
      }
      if (data.title == "Blood Glucose") {
        bgController.setFirstValue(data.firstValue);
        bgController.setSecondValue(data.secondValue);
        // print(data.secondValue);
      }

      //   controller.setFirstValue = index.toString();
      //   // controller =
      //   //     new ControllerInput(first: index.toString());
      //   // controller.firstValue = index.toString();
    });
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

  @override
  Widget build(BuildContext context) {
    // final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      // backgroundColor: Colors.grey[900],
      appBar: AppBar(
          //  textTheme: themeProvider.getThemeData,
          title: Text(
            'Vital signs',
          ),
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
                              child: Text("Created at " + _timestamp))),
                      _buildItem(context, "BP Systolic", bpSysController),
                      _buildItem(context, "BP Diastolic", bpDiasController),
                      _buildItem(context, "MAP", mapController),
                      _buildItem(context, "PR", prController),
                      _buildItem(context, "Pulse Pressure", ppController),
                      _buildItem(context, "Pulse Volume", pvController),
                      _buildItem(context, "CRT", crtController),
                      _buildItem(context, "Shock Index", siController),
                      _buildItem(context, "RR", rrController),
                      _buildItem(context, "Sp02", spo2Controller),
                      _buildItem(context, "Temperature", tempController),
                      _buildItem(context, "Pain Score", psController),
                      _buildItem(context, "Blood Glucose", bgController),
                      _buildItemPupil(context, "Left Pupil", lpController),
                      _buildItemPupil(context, "Right Pupil", rpController),
                      _buildItemGCS(context, "GCS", gcsController),
                    ],
                  )))),
    );
  }
}

Widget _actionPupilPicker(title, controller, callback) {
  const list = ["Reactive", "Sluggish", "Fixed"];
  controller.setTitle(title);
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
                        initialItem: list.indexWhere(
                            (item) => item == controller.firstValue)),
                    onSelectedItemChanged: (int index) {
                      controller.setText(list[index]);
                      callback(controller);
                      print(index);
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

class ControllerInput {
  String title;
  String text;
  int first;
  int second;
  int third;

  ControllerInput({this.title, this.first, this.second, this.third, this.text});

  void setFirstValue(int value) {
    first = value;
  }

  void setSecondValue(int value) {
    second = value;
  }

  void setThirdValue(int value) {
    third = value;
  }

  void setTitle(String value) {
    title = value;
  }

  void setText(String value) {
    text = value;
  }

  int get firstValue => first;
  int get secondValue => second;
  int get thirdValue => third;
  String get responseText => text;
}
