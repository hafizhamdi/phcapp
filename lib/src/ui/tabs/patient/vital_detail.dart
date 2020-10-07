import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phcapp/custom/header_section.dart';
import 'package:phcapp/src/blocs/vital_bloc.dart';
import 'package:phcapp/src/models/phc.dart';
import 'package:phcapp/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

enum ItemInput { singlePoint, doublePoint }
enum ActionButton { delete, create }

const pupilList = ["", "Reactive", "Sluggish", "Fixed"];
const pvList = ["", "Good", "Poor", "NIL"];
const crList = ["", "Normal Rhythm", "Narrow Complex Tachycardia", "Broad Complex Tachycardia / VF / VT",
"Bradycardia / Heart Blocked", "Atriar Fibrilation"];
const crtList = ["", "< = 2 sec", "> 2 sec"];

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
      DateFormat("h:mm aa").format(new DateTime.now()).toString();
  int totalGcs = 0;

  NumberPicker bpSysPicker = new NumberPicker(abnormal: false, hi: false);
  NumberPicker bpDiasPicker = new NumberPicker();
  NumberPicker mapPicker = new NumberPicker();
  NumberPicker prPicker = new NumberPicker(abnormal: false, hi: false);
  NumberPicker ppPicker = new NumberPicker();
  NumberPicker pvPicker = new NumberPicker();
  NumberPicker crtPicker = new NumberPicker();
  NumberPicker siPicker = new NumberPicker();
  NumberPicker rrPicker = new NumberPicker();
  NumberPicker spo2Picker = new NumberPicker();
  NumberPicker tempPicker = new NumberPicker();
  NumberPicker psPicker = new NumberPicker();
  NumberPicker bgPicker = new NumberPicker(abnormal: false, hi: false);
  NumberPicker bkPicker = new NumberPicker(abnormal: false, hi: false);
  NumberPicker lpPicker = new NumberPicker();
  NumberPicker rpPicker = new NumberPicker();
  NumberPicker gcsEpicker = new NumberPicker();
  NumberPicker gcsVpicker = new NumberPicker();
  NumberPicker gcsMpicker = new NumberPicker();
  NumberPicker gcsTotalpicker = new NumberPicker();
  NumberPicker crPicker = new NumberPicker();

  VitalBloc vitalBloc;

  // bool checkBG = false;
  // bool checkBK = false;

  @override
  initState() {
    print("INIT STATE VITAL DETAIL");

    if (widget.vitalSign != null) {
      var bkDecimal = checkDecimal(widget.vitalSign.bloodKetone);
      var bgDecimal = checkDecimal(widget.vitalSign.bloodGlucose);
      print(widget.vitalSign.temp);
      var tempDecimal = checkDecimal(widget.vitalSign.temp);

      bpSysPicker = new NumberPicker(
          value: checkIsNumberNotNull(widget.vitalSign.bpSystolic),
          hi: widget.vitalSign.bpSystolic != "NR" ? false : true);

      bpDiasPicker = new NumberPicker(
          value: checkIsNumberNotNull(widget.vitalSign.bpDiastolic));
      mapPicker =
          new NumberPicker(option: checkIsStringNotNull(widget.vitalSign.map));
      prPicker =
          new NumberPicker(value: checkIsNumberNotNull(widget.vitalSign.pr),
          
          hi: widget.vitalSign.pr != "NP" ? false : true);
      ppPicker = new NumberPicker(
          option: checkIsStringNotNull(widget.vitalSign.pulsePressure));
      pvPicker = new NumberPicker(
          option: checkIsStringNotNull(widget.vitalSign.pulseVolume));
      crtPicker =
          new NumberPicker(option: checkIsStringNotNull(widget.vitalSign.crt));
      siPicker = new NumberPicker(
          option: checkIsStringNotNull(widget.vitalSign.shockIndex));
      rrPicker =
          new NumberPicker(value: checkIsNumberNotNull(widget.vitalSign.rr));
      spo2Picker =
          new NumberPicker(value: checkIsNumberNotNull(widget.vitalSign.spo2));
      tempPicker = new NumberPicker(
          option: checkIsStringNotNull(widget.vitalSign.temp),
          value: tempDecimal != null ? int.tryParse(tempDecimal[0]) : 0,
          decimal: tempDecimal != null ? int.tryParse(tempDecimal[1]) : 0
          // );

          );
      psPicker = new NumberPicker(
          value: checkIsNumberNotNull(widget.vitalSign.painScore));
      bgPicker = new NumberPicker(
        
          option: checkIsStringNotNull(widget.vitalSign.bloodGlucose),
          value: bgDecimal != null ? int.tryParse(bgDecimal[0]) : 0,
          decimal: bgDecimal != null ? int.tryParse(bgDecimal[1]) : 0,
          // value: checkIsNumberNotNull(widget.vitalSign.bloodGlucose),
          hi: widget.vitalSign.bloodGlucose != "HI" ? false : true);
      bkPicker = new NumberPicker(
          option: checkIsStringNotNull(widget.vitalSign.bloodKetone),
          value: bkDecimal != null ? int.tryParse(bkDecimal[0]) : 0,
          decimal: bkDecimal != null ? int.tryParse(bkDecimal[1]) : 0,
          hi: widget.vitalSign.bloodKetone != "HI" ? false : true);
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
      crPicker = new NumberPicker(
          option: checkIsStringNotNull(widget.vitalSign.cardiacRhythm));
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
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
            boxShadow: [
                                  BoxShadow(
                                    color: Color(0x80000000).withOpacity(0.2),
                                    blurRadius: 10.0,
                                    offset: Offset(0.0, 0.0),
                                  ),
                                ],
            borderRadius: BorderRadius.circular(10),
            shape: BoxShape.rectangle,
            // border: Border.all(color: Colors.grey, width: 0.5)
            
            ),
        width: 230,
        // height: 220,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(title,
                    textAlign: TextAlign.left, style: TextStyle(fontSize: 18, fontFamily: "Poppins", fontWeight: FontWeight.w600)
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
                        style: TextStyle(fontSize: 16),
                      )),
                  Text(
                    ePicker.getValue != null ? ePicker.getValue.toString() : '',
                    // decimalFormating(,
                    style: TextStyle(
                      fontSize: 30,

                      fontWeight: FontWeight.w900
                      // color: Colors.purple[200]
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.edit),
                    color: Colors.blue,
                    iconSize: 25,
                    onPressed: () {
                      setState(() {
                       ePicker.setValue(4); 
                      });
                      showCupertinoModalPopup(
                          context: context,
                          builder: (context) =>
                              cupertinoPicker(ePicker, "GCS E", 5, ePicker.getValue));
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
                        style: TextStyle(fontSize: 16),

                        // style: TextStyle(color: Colors.white),
                      )),
                  //,
                  Text(
                    vPicker.getValue != null ? vPicker.getValue.toString() : '',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w900
                      // color: Colors.purple[200]
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.edit),
                    color: Colors.blue,
                    iconSize: 25,
                    onPressed: () {
                      setState((){
vPicker.setValue(5);


                      });
                      showCupertinoModalPopup(
                          context: context,
                          builder: (context) =>
                              cupertinoPicker(vPicker, "GCS V", 6, vPicker.getValue));

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
                        style: TextStyle(fontSize: 16),

                        // style: TextStyle(color: Colors.white),
                      )),
                  Text(
                    mPicker.getValue != null ? mPicker.getValue.toString() : '',
                    style: TextStyle(
                      fontSize: 30,
                      
                      fontWeight: FontWeight.w900
                      // color: Colors.purple[200]
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.edit),
                    color: Colors.blue,
                    iconSize: 25,
                    onPressed: () {
                      setState((){
                        mPicker.setValue(6);
                      });
                      showCupertinoModalPopup(
                          context: context,
                          builder: (context) =>
                              cupertinoPicker(mPicker, "GCS M", 7, mPicker.getValue));
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
                        style: TextStyle(fontSize: 16, fontFamily: "Poppins"),

                        // style: TextStyle(color: Colors.white),
                      )),
                  Text(
                    totalPicker.getValue != null
                        ? totalPicker.getValue.toString()
                        : '',

                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w900
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
                    backgroundColor: Colors.white,
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
                          range, (int index) => Text(index.toString(),),),),),
            ],),);
  }

  Widget _buildItemPupil(
      context, NumberPicker picker, title, itemCount, initialData, list) {
    return Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          shape: BoxShape.rectangle,
          
            boxShadow: [
                                  BoxShadow(
                                    color: Color(0x80000000).withOpacity(0.2),
                                    blurRadius: 10.0,
                                    offset: Offset(0.0, 0.0),
                                  ),
                                ],
          // border: Border.all(color: Colors.grey, width: 0.5),
        ),
        width: 230,
        // height: 200,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text(title,
                      textAlign: TextAlign.left, style: TextStyle(fontSize: 18, fontFamily: "Poppins", fontWeight: FontWeight.w600)
                      // style: TextStyle(color: Colors.white),
                      ),
                ),
              ],
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    picker.getValue != null ? picker.getValue.toString() : '',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w900
                      // color: Colors.purple[200]
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.edit),
                    color: Colors.blue,
                    iconSize: 25,
                    onPressed: () {
                      setState((){
                        picker.setValue(3);

                      });
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
                      style: TextStyle(color: Colors.grey, fontFamily: "Poppins"),
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
                    color: Colors.blue,
                    iconSize: 25,
                    onPressed: () {
                      showCupertinoModalPopup(
                          context: context,
                          builder: (context) =>
                              optionPicker(picker, title, list));
                    },
                  )
                ])
          ],
        )); //,
    // );
  }

  Widget _buildItemOption(context, NumberPicker picker, title, list) {
    return Container(
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          shape: BoxShape.rectangle,
          
            boxShadow: [
                                  BoxShadow(
                                    color: Color(0x80000000).withOpacity(0.2),
                                    blurRadius: 10.0,
                                    offset: Offset(0.0, 0.0),
                                  ),
                                ],
          // border: Border.all(color: Colors.grey, width: 0.5)
          ),
      width: 230,
      // height: 200,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text(title,
                      textAlign: TextAlign.left, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, fontFamily: "Poppins")
                      // style: TextStyle(color: Colors.white),
                      )),
            ],
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(child:Text(
                  picker.getOption != null ? picker.getOption : '',
                  style: TextStyle(
                    fontSize: 25,
                    color: picker.getOption == "Good"? Colors.green: Colors.orange,
                    fontWeight: FontWeight.w900
                    
                    // color: Colors.purple[200]
                  ),
                  overflow: TextOverflow.ellipsis,
                ),),
                IconButton(
                  icon: Icon(Icons.edit),
                  color: Colors.blue,
                  iconSize: 25,
                  onPressed: () {
                    showCupertinoModalPopup(
                        context: context,
                        builder: (context) =>
                            optionPicker(picker, title, list));
                  },
                )
              ])
        ],
      ),
    );
  }

  Widget _buildItem(
      context, NumberPicker picker, title, itemCount, initialData, unit) {
    // print(title);
    var doneButton = CupertinoButton(
      child: Text("Done"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    if (title == "MAP" || title == "Shock Index" || title == "Pulse Pressure") {
      return Container(
          margin: EdgeInsets.all(5),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
                                  BoxShadow(
                                    color: Color(0x80000000).withOpacity(0.2),
                                    blurRadius: 10.0,
                                    offset: Offset(0.0, 0.0),
                                  ),
                                ],
              borderRadius: BorderRadius.circular(10),
              shape: BoxShape.rectangle,
              // border: Border.all(color: Colors.grey, width: 0.5)
              
              ),
          width: 230,
          // height: 200,
          child: Column(children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text(title,
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 18, fontFamily: "Poppins", fontWeight: FontWeight.w600),
                        // style: TextStyle(color: Colors.white),
                        ),),
              ],
            ),
            
                       (bpSysPicker.hi == false) ?Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    picker.getOption != null ? picker.getOption.toString() : '',
                    // decimalFormating(
                    //     controller.firstValue, controller.secondValue),
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w900
                    ),
                  ),
                ]):Container()
          ],),); //);
    }

    //use attribute option to store decimal value

    var tempDecimal = picker.decimal != null
        ? picker.value.toString() + "." + picker.decimal.toString()
        : picker.value != null ? picker.value.toString() : '';
    return Container(
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        
            color: Colors.white,
            boxShadow: [
                                  BoxShadow(
                                    color: Color(0x80000000).withOpacity(0.2),
                                    blurRadius: 10.0,
                                    offset: Offset(0.0, 0.0),
                                  ),
                                ],
          borderRadius: BorderRadius.circular(10),
          shape: BoxShape.rectangle,
          // border: Border.all(color: Colors.grey, width: 0.5),
          ),
      width: 230,
      // height: 200,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // crossAxisAlignment: CrossAxisAlignment.,
            children: <Widget>[
              Text(title,
                      textAlign: TextAlign.left, style: TextStyle(fontSize: 18, fontFamily: "Poppins", fontWeight: FontWeight.w600),
                      
                      // style: TextStyle(color: Colors.white),
                      // ),
                      ),
            
            Padding(padding:EdgeInsets.only(right: 10),child:Text(unit, style: TextStyle(fontSize: 14, color: Colors.grey, fontWeight: FontWeight.w600),),)],
          ),
          SizedBox(height: 10,),
          ((title == "Blood Ketone" && picker.hi == false) ||
                  (title == "Blood Glucose" && picker.hi == false) || 
                  (title == "BP Systolic" && picker.hi == false)||
                  (title == "PR" && picker.hi == false))
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                      Text(
                        tempDecimal,
                        // picker.getValue != null ? picker.getValue.toString() : '',
                        // decimalFormating(
                        //     controller.firstValue, controller.secondValue),
                        style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w900,
                            color: picker.getAbnormal == true
                                ? Colors.redAccent
                                : null),
                      ),
                      IconButton(
                          icon: Icon(Icons.edit),
                          color: Colors.blue,
                          iconSize: 25,
                          onPressed: () {
                            setState((){
                              picker.setValue(initialData);
                              // picker.setDecimal(0);
                            });

                            if (title == "Blood Ketone" || title == "Blood Glucose" ||
                                      title == "Temperature") {

                                        setState(() {
                                         picker.setDecimal(0); 
                                        });}
                            showCupertinoModalPopup(
                                context: context,
                                builder: (context) {
                                  if (title == "Blood Ketone" || title == "Blood Glucose" ||
                                      title == "Temperature") {

                                        // setState(() {
                                        //  picker.setDecimal(0); 
                                        // });
                                    return cupertinoDoublePicker(
                                        picker, title, itemCount, initialData);
                                  }

                                  return cupertinoPicker(
                                      picker, title, itemCount, initialData);
                                });
                          })
                    ])
              :
              // Container(),
              ((title == "Blood Ketone" && picker.hi != false) ||
                      (title == "Blood Glucose" && picker.hi != false) ||
                      (title == "BP Systolic" && picker.hi != false) ||
                      (title == "BP Diastolic" && bpSysPicker.hi != false) ||
                      (title == "PR" && picker.hi != false) 
                      
                      
                      )
                  ? Container()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                          Text(
                            tempDecimal,
                            // picker.getValue != null ? picker.getValue.toString() : '',
                            // decimalFormating(
                            //     controller.firstValue, controller.secondValue),
                            style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.w900,
                                color: picker.getAbnormal == true
                                    ? Colors.redAccent
                                    : null),
                          ),
                          IconButton(
                              icon: Icon(Icons.edit),
                              color: Colors.blue,
                              iconSize: 25,
                              onPressed: () {
                                
                            setState((){
                              picker.setValue(initialData);
                              // picker.setDecimal(0);
                            });

                                      if (title == "Blood Ketone" || title == "Blood Glucose" ||
                                          title == "Temperature") {

                                            setState((){
                                              picker.setDecimal(0);
                                            });
                                          }

                                showCupertinoModalPopup(
                                    context: context,
                                    builder: (context) {
                                      if (title == "Blood Ketone" || title == "Blood Glucose" ||
                                          title == "Temperature") {

                                            // setState((){
                                            //   picker.setDecimal(0);
                                            // });
                                        return cupertinoDoublePicker(picker,
                                            title, itemCount, initialData);
                                      }

                                      return cupertinoPicker(picker, title,
                                          itemCount, initialData);
                                    });
                              })
                        ]),
          //     : Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: <Widget>[
          //             Text(
          //               tempDecimal,
          //               // picker.getValue != null ? picker.getValue.toString() : '',
          //               // decimalFormating(
          //               //     controller.firstValue, controller.secondValue),
          //               style: TextStyle(
          //                   fontSize: 40,
          //                   color: picker.getAbnormal == true
          //                       ? Colors.redAccent
          //                       : null),
          //             ),
          //             IconButton(
          //                 icon: Icon(Icons.edit),
          //                 color: Colors.grey,
          //                 iconSize: 25,
          //                 onPressed: () {
          //                   showCupertinoModalPopup(
          //                       context: context,
          //                       builder: (context) {
          //                         if (title == "Blood Ketone" ||
          //                             title == "Temperature") {
          //                           return cupertinoDoublePicker(picker,
          //                               title, itemCount, initialData);
          //                         }

          //                         return cupertinoPicker(picker, title,
          //                             itemCount, initialData);
          //                       });
          //                 })
          //           ]),
          (title == "Blood Ketone")
              ? Row(
                  children: <Widget>[
                    Text("HI"),
                    Checkbox(
                      value: picker.getHI,
                      onChanged: (value) {
                        setState(() {
                          // if (title == "Blood Ketone") {
                          picker.setHI(value);
                          if (value == true) {
                            picker.setValue(null);
                            picker.setDecimal(null);
                          }
                          // }
                        });
                      },
                    )
                  ],
                ):Container(),
              // ?

          (title == "Blood Glucose")
                  ? Row(
                      children: <Widget>[
                        Text("HI"),
                        Checkbox(
                          value: picker.getHI,
                          onChanged: (value) {
                           setState(() {
                          // if (title == "Blood Ketone") {
                          picker.setHI(value);
                          if (value == true) {
                            picker.setValue(null);
                            picker.setDecimal(null);
                          }
                          // }
                        });
                      },
                        )
                      ],
                    )
                 :Container() ,
                 
                 
                 (title == "PR")
                  ? Row(
                      children: <Widget>[
                        Text("Non Palpable"),
                        Checkbox(
                          value: picker.getHI,
                          onChanged: (value) {
                            setState(() {
                              // if (title == "Blood Glucose") {
                              picker.setHI(value);

                              if (value == true) {
                                picker.setValue(null);
                              }
                              // }
                            });
                          },
                        )
                      ],
                    ) 
                  : Container(),
                  (title == "BP Systolic")
                  ? Row(
                      children: <Widget>[
                        Text("Non Recordable"),
                        Checkbox(
                          value: picker.getHI,
                          onChanged: (value) {
                            setState(() {
                              // if (title == "Blood Glucose") {
                              picker.setHI(value);

                              if (value == true) {
                                picker.setValue(null);
                              }
                              // }
                            });
                          },
                        )
                      ],
                    ) 
                  
                  
                
                  
                  :Container()
        
//         ,SizedBox(height: 20,),
// Row(children:[Text("Celcius")])
        ],
      ),
    );
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
                    backgroundColor: Colors.white,
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
                          200, (int index) => Text(index.toString(),),),),),
              Expanded(
                  child: CupertinoPicker(
                    backgroundColor: Colors.white,
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
            setState(() {
              vitalBloc.add(RemoveVital(index: index));
            });
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
        var map = (bpSysPicker.getValue + (2 * bpDiasPicker.getValue)) / 3;
        var mapStr = double.parse(map.toString()).toStringAsFixed(2);
        mapPicker.setOption(mapStr);
        // print(map);
        // print(mapStr);
      }

      if (bpSysPicker.getValue != null && bpDiasPicker.getValue != null) {
        var pp = bpSysPicker.getValue - bpDiasPicker.getValue;

        ppPicker.setOption(pp.toString());
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

    formatDecimal(value,decimal){
      return value!=null && decimal !=null?
    value.toString() +
                                        "." +
                                        decimal.toString():
                                        null;
    }

    // final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: Colors.grey,
      // backgroundColor: Colors.grey[900],
      // appBar: AppBar(
      //     //  textTheme: themeProvider.getThemeData,
      //     title: Text(
      //       'Vital signs',
      //     ),
      // actions: <Widget>[
      //   cancelButton(action, widget.index),
      //   createButton(action, widget.index)
      // ],
      // backgroundColor: Colors.purple),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            margin: EdgeInsets.all(12.0),
            child: Container(
              // child: Container(
                  // alignment: Alignment.center,
                  // padding: EdgeInsets.all(10),
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                alignment: WrapAlignment.center,
                children: <Widget>[
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                       
                        IconButton(
                          icon: Icon(Icons.check),
                          onPressed: () {
                            if(widget.index == null){

                            int len = vitalBloc.state.listVitals != null
                                ? vitalBloc.state.listVitals.length
                                : 0;

                            VitalSign vs = new VitalSign(
                                id: (len + 1).toString(),
                                created: new DateTime.now(),
                                bpSystolic: bpSysPicker.getHI == true? "NR"
                                    :transformBlankNull(bpSysPicker.getValue),
                                bpDiastolic: bpSysPicker.getHI == true? "NR":
                                    transformBlankNull(bpDiasPicker.getValue),
                                map: bpSysPicker.getHI == true? "":
                                transformBlankNull(mapPicker.getOption),
                                pr: 
                                prPicker.getHI == true? "NP":
                                transformBlankNull(prPicker.getValue),
                                pulsePressure:
                                bpSysPicker.getHI == true? "":
                                    transformBlankNull(ppPicker.getOption),
                                pulseVolume:
                                    transformBlankNull(pvPicker.getOption),
                                crt: transformBlankNull(crtPicker.getOption),
                                rr: transformBlankNull(rrPicker.getValue),
                                spo2: transformBlankNull(spo2Picker.getValue),
                                temp: formatDecimal(tempPicker.getValue,
                                    tempPicker.decimal),
                                bloodKetone: bkPicker.getHI == true
                                    ? "HI"
                                    : formatDecimal(bkPicker.value,bkPicker.decimal),

                                // temp: transformBlankNull(tempPicker.getOption),
                                painScore:
                                    transformBlankNull(psPicker.getValue),
                                bloodGlucose: bgPicker.getHI == true
                                    ? "HI"
                                    : formatDecimal(bgPicker.value,bgPicker.decimal),
                                // bloodKetone: transformBlankNull(bkPicker.getOption),
                                shockIndex:
                                    transformBlankNull(siPicker.getOption),
                                pupil: Pupil(
                                    leftResponseTolight:
                                        transformBlankNull(lpPicker.getOption),
                                    leftSize:
                                        transformBlankNull(lpPicker.getValue),
                                    rightResponseTolight:
                                        transformBlankNull(rpPicker.getOption),
                                    rightSize: transformBlankNull(rpPicker.getValue)),
                                e: transformBlankNull(gcsEpicker.getValue),
                                v: transformBlankNull(gcsVpicker.getValue),
                                m: transformBlankNull(gcsMpicker.getValue),
                                gcs: transformBlankNull(
                                    gcsTotalpicker.getValue),
                                cardiacRhythm:  transformBlankNull(crPicker.getOption));

                            print("Vital Sigs");
                            // // print(vs.toJson());

                            setState(() {
                              vitalBloc.add(AddVital(vital: vs));
                            });

                            Navigator.pop(context);

                            }else{
                              VitalSign vs = new VitalSign(
                // id: (index + 1).toString(),
                // id: (vitalBloc.state.listVitals.length + 1).toString(),
                created: new DateTime.now(),
                bpSystolic: transformBlankNull(bpSysPicker.getValue),
                bpDiastolic: transformBlankNull(bpDiasPicker.getValue),
                map: transformBlankNull(mapPicker.getOption),
                pr: transformBlankNull(prPicker.getValue),
                pulsePressure: transformBlankNull(ppPicker.getOption),
                pulseVolume: transformBlankNull(pvPicker.getOption),
                crt: transformBlankNull(crtPicker.getOption),
                rr: transformBlankNull(rrPicker.getValue),
                painScore: transformBlankNull(psPicker.getValue),
                spo2: transformBlankNull(spo2Picker.getValue),
                temp: formatDecimal(tempPicker.value,tempPicker.decimal),
                // tempPicker.getValue) +
                //     "." +
                //     tempPicker.decimal.toString(),
                bloodKetone: bkPicker.getHI== true?"HI":    formatDecimal(bkPicker.value,bkPicker.decimal),
                // bkPicker.getValue.toString() +
                //     "." +
                //     bkPicker.decimal.toString(),
                bloodGlucose: bgPicker.getHI== true?"HI": formatDecimal(bgPicker.value,bgPicker.decimal),
                // bgPicker.getValue.toString(),
                shockIndex: transformBlankNull(siPicker.getOption),
                pupil: Pupil(
                    leftResponseTolight: transformBlankNull(lpPicker.getOption),
                    leftSize: transformBlankNull(lpPicker.getValue),
                    rightResponseTolight: transformBlankNull(rpPicker.getOption),
                    rightSize: transformBlankNull(rpPicker.getValue)),
                e: transformBlankNull(gcsEpicker.getValue),
                v: transformBlankNull(gcsVpicker.getValue),
                m: transformBlankNull(gcsMpicker.getValue),
                gcs: transformBlankNull(gcsTotalpicker.getValue),
                cardiacRhythm: transformBlankNull(crPicker.getOption));

            setState(() {
              vitalBloc.add(UpdateVital(index: widget.index, vital: vs));
            });

            Navigator.pop(context);
         
                            }
                          },
                        ),
                      ]),
                       widget.index ==null?HeaderSection("Add Vital Sign"):HeaderSection("Edit Vital Sign"),

                  Center(
                      child: Padding(
                          padding: EdgeInsets.all(10),
                          child: widget.vitalSign == null
                              ? Text("Last changes at " + _timestamp)
                              : Text("Last changes at " +
                                  DateFormat("h:mm aa")
                                      .format(widget.vitalSign.created)))),
                  _buildItem(context, bpSysPicker, "BP Systolic", 300, 120, "mmHg"),
                  _buildItem(context, prPicker, "PR", 200, 70, "bpm"),
                  _buildItem(context, bpDiasPicker, "BP Diastolic", 200, 80,"mmHg"),
                  // _buildItem(
                  //     context, "BP Diastolic", bpDiasController, 200),
                  _buildItem(context, mapPicker, "MAP", 200, 100, "bpm"),
                  _buildItem(context, ppPicker, "Pulse Pressure", 200, 40,"bpm"),
                  _buildItemOption(context, pvPicker, "Pulse Volume", pvList),
                  _buildItemOption(context, crtPicker, "CRT", crtList),
                  _buildItem(context, siPicker, "Shock Index", 200, 100,""),
                  _buildItem(context, rrPicker, "RR", 61, 20,"bpm"),
                  _buildItem(context, spo2Picker, "Sp02", 101, 100, "%"),
                  _buildItem(context, tempPicker, "Temperature", 50, 37, "°C"),
                  _buildItem(context, psPicker, "Pain Score", 11, 1,""),
                  _buildItem(context, bgPicker, "Blood Glucose", 31, 10 ,"mmol/L"),
                  _buildItem(context, bkPicker, "Blood Ketone", 31, 1,"mmol/L"),
                  _buildItemPupil(
                      context, lpPicker, "Left Pupil", 9, 1, pupilList),
                  _buildItemPupil(
                      context, rpPicker, "Right Pupil", 9, 1, pupilList),
                  // _buildItemPupil(context, "Right Pupil", rpController),
                  _buildItemGCS(context, gcsEpicker, gcsVpicker, gcsMpicker,
                      gcsTotalpicker, "GCS"),
                  _buildItemOption(context, crPicker, "Cardiac Rhythm", crList),
                ],
              ),
            ),
          ),
          // ,),
        ),
      ),
    );
  }

  optionPicker(NumberPicker picker, title, list) {
    // const list = ["Reactive", "Sluggish", "Fixed"];
    // controller.setTitle(title);
    // return SizedBox(
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
                backgroundColor: Colors.white,
                  itemExtent: 50,
                  scrollController: FixedExtentScrollController(
                    initialItem:
                        list.indexWhere((item) => item == picker.getOption),
                  ),
                  onSelectedItemChanged: (int index) {
                    setState(() {
                      picker.setOption(list[index]);
                    });
                    // controller.setText(list[index]);
                    // callback(controller);
                    // print(index);
                  },
                  children: List<Widget>.generate(
                    list.length,
                    (int index) => Text(list[index]),
                  )

                  // generate(
                  //         200, (int index) => Text(index.toString())))
                  // Text("Sluggish")
                  // ]
                  ),
            ),
          ]),
    );

    // Expanded(
    //     child: CupertinoPicker(
    //         itemExtent: 50,
    //         onSelectedItemChanged: (int index) {
    //           print(index);
    //         },
    //         children: List<Widget>.generate(
    //             10, (int index) => Text(index.toString()))))
    // ]),]),
    // ],)
    // ),),);
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
      (prPicker.getValue < 60 || prPicker.getValue >= 100)
          ? prPicker.setAbnormal(true)
          : prPicker.setAbnormal(false);
    }

    // RR
    if (rrPicker.getValue != null) {
      (rrPicker.getValue >= 25 || rrPicker.getValue <11)
          ? rrPicker.setAbnormal(true)
          : rrPicker.setAbnormal(false);
    }

    // SpO2
    if (spo2Picker.getValue != null) {
      (spo2Picker.getValue < 95 || spo2Picker.getValue > 200)
          ? spo2Picker.setAbnormal(true)
          : spo2Picker.setAbnormal(false);
    }

    //PULSE PRESSURE
    if (ppPicker.getOption != null && ppPicker.getOption!="") {
      print("ppPicker");
      print(ppPicker.getOption);
      (int.tryParse(ppPicker.getOption) < 20 ||
              int.tryParse(ppPicker.getOption) > 100)
          ? ppPicker.setAbnormal(true)
          : ppPicker.setAbnormal(false);
    }

    //BLOOD GLUCOSE
    if(bgPicker.getValue !=null){

    (bgPicker.getValue >=12 || bgPicker.getValue<4)?
      bgPicker.setAbnormal(true):
      bgPicker.setAbnormal(false);
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
                  backgroundColor: Colors.white,
                    scrollController:
                        FixedExtentScrollController(initialItem:picker.getValue??initialData),
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

  checkDecimal(strVal) {
    if (strVal != null) {
      bool isDecimal = strVal.contains(".");
      // String firstVal;
      // String secondVal;
      if (isDecimal == true) {
        var split = strVal.split(".");
        return split;
      }
    }
    return null;
  }

  cupertinoDoublePicker(NumberPicker picker, title, itemCount, initialData) {
    // var splitData = checkDecimal(initialData);

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

    var temp = checkDecimal(picker.getOption);
    return SizedBox(
      height: 200.0,
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(249, 249, 247, 1.0),
              border: Border(
                bottom: const BorderSide(width: 0.5, color: Colors.black38),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [titleButton, doneButton],
              ),
            ),
          ),
          Expanded(
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: CupertinoPicker(
                    backgroundColor: Colors.white,
                    scrollController: FixedExtentScrollController(
                        initialItem: picker.getValue ?? initialData),
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
                      itemCount,
                      (int index) => Text(
                        index.toString(),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: CupertinoPicker(
                    backgroundColor: Colors.white,
                    scrollController: FixedExtentScrollController(
                        initialItem: picker.getDecimal ?? 0),
                    itemExtent: 50,
                    onSelectedItemChanged: (int index) {
                      // print("onselecteditemchanged --cupertinopicker");
                      // print(index);

                      setState(() {
                        picker.setDecimal(index);
                      });
                      print(picker.getDecimal);
                    },
                    children: List<Widget>.generate(
                      10,
                      (int index) => Text(
                        index.toString(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // ),
        ],
      ),
    );
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
  bool hi = false;

  NumberPicker(
      {this.title, this.option, this.value, this.abnormal, this.decimal, this.hi});

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

  setHI(_value) {
    hi = _value;
  }

  String get getTitle => title;
  String get getOption => option;
  int get getValue => value;
  int get getDecimal => decimal;
  bool get getAbnormal => abnormal;
  bool get getHI => hi;
}

