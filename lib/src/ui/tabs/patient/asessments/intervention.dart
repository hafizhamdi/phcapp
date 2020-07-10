import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phcapp/src/blocs/blocs.dart';
import 'package:phcapp/src/models/chip_item.dart';
import 'package:phcapp/src/models/phc.dart';
import 'package:phcapp/src/ui/tabs/patient/asessments/blocs/intervention_bloc.dart';
import 'package:phcapp/src/widgets/my_multiple_option.dart';
import 'package:phcapp/src/widgets/my_single_option.dart';
import 'package:phcapp/src/widgets/mycard_single_option.dart';

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
  "Room Air",
  "CPAP3 cmH20",
  "CPAP5 cmH20",
  "CPAP7.5 cmH20",
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
  "Thermal Blanket"
];

class InterventionScreen extends StatefulWidget {
  InterventionAss interAssessment;

  InterventionScreen({this.interAssessment});
  _InterventionScreen createState() => _InterventionScreen();
}

class _InterventionScreen extends State<InterventionScreen> {
  List<String> listAirwayDevice = new List<String>();
  List<String> listOxygen = new List<String>();
  List<String> listExtHaemo = new List<String>();
  List<String> listVascular = new List<String>();
  List<String> listImmobil = new List<String>();
  List<String> listSpecialCare = new List<String>();

  TextEditingController vascularTextController = TextEditingController();

  List<ChipItem> prepareData = [
    ChipItem(
      id: "airway_device",
      name: "Airway Device Intervention",
      listData: _airwayDevice,
      value: "",
    ),
    ChipItem(id: "oxygen", name: "Oxygen", listData: _oxygen, value: ""),
    ChipItem(
        id: "ext_haemo",
        name: "External Haemorrhage Control Method",
        listData: _extHaemorrhage,
        value: List<String>(),
        multiple: true),
    ChipItem(
        id: "vascular_access",
        name: "Vascular Access",
        listData: _vascularAccess,
        value: List<String>(),
        multiple: true),
    ChipItem(
        id: "immobilization",
        name: "Immobilization",
        listData: _immobilization,
        value: List<String>(),
        multiple: true),
    ChipItem(
        id: "special_care",
        name: "Special Care",
        listData: _specialCare,
        value: List<String>(),
        multiple: true),
  ];

  mycallback(id, List<String> dataReturn) {
    print("callback");
    print(dataReturn);
    if (id == "airway_device") {
      setState(() {
        listAirwayDevice = dataReturn;
      });
    }
    if (id == "oxygen") {
      setState(() {
        listOxygen = dataReturn;
      });
    }
    if (id == "ext_haemo") {
      setState(() {
        listExtHaemo = dataReturn;
      });
    }
    if (id == "vascular_access") {
      setState(() {
        listVascular = dataReturn;
      });
    }
    if (id == "immobilization") {
      setState(() {
        listImmobil = dataReturn;
      });
    }
    if (id == "special_care") {
      setState(() {
        listSpecialCare = dataReturn;
      });
    }
  }

  @override
  void didChangeDependencies() {
    print("didChangeDependencies.");
    if (widget.interAssessment != null) {
      prepareData.map((f) {
        if (f.id == "airway_device") {
          f.value = widget.interAssessment.airwayDevice;
          listAirwayDevice.add(widget.interAssessment.airwayDevice);
          if (listAirwayDevice.length > 1) {
            listAirwayDevice.removeLast();
          }
        }
        if (f.id == "oxygen") {
          f.value = widget.interAssessment.oxygen;
          listOxygen.add(widget.interAssessment.oxygen);
          if (listOxygen.length > 1) {
            listOxygen.removeLast();
          }
        }
        if (f.id == "ext_haemo") {
          f.value = widget.interAssessment.extHaemorrhage;
          listExtHaemo = widget.interAssessment.extHaemorrhage;
        }
        if (f.id == "vascular_access") {
          f.value = widget.interAssessment.vascularAccess;
          listVascular = widget.interAssessment.vascularAccess;
        }
        if (f.id == "immobilization") {
          f.value = widget.interAssessment.immobilization;
          listImmobil = widget.interAssessment.immobilization;
        }
        if (f.id == "special_care") {
          f.value = widget.interAssessment.specialCare;
          listSpecialCare = widget.interAssessment.specialCare;
        }

        vascularTextController.text =
            widget.interAssessment.vascularAccessLocation;

        return f;
      }).toList();
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Intervention Assessment"),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.save, color: Colors.white),
            label: Text(
              "SAVE",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              InterventionAss inter = new InterventionAss(
                  timestamp: new DateTime.now(),
                  airwayDevice:
                      listAirwayDevice.length > 0 ? listAirwayDevice[0] : "",
                  oxygen: listOxygen.length > 0 ? listOxygen[0] : "",
                  vascularAccessLocation: vascularTextController.text,
                  extHaemorrhage: listExtHaemo,
                  vascularAccess: listVascular,
                  immobilization: listImmobil,
                  specialCare: listSpecialCare);

              BlocProvider.of<InterBloc>(context)
                  .add(UpdateInter(inter: inter));

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

                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                // style: TextStyle(fontSize: 20),
              ),
            ),
            MyMultipleOptions(
              id: id,
              listDataset: listData,
              initialData: value,
              callback: mycallback,
            ),
            id == "vascular_access"
                ? Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: TextField(
                      style: TextStyle(fontSize: 18),
                      controller: vascularTextController,
                      decoration: InputDecoration(
                          labelText: "Vascular Access Location"),
                    ),
                  )
                : Container()
            // ],
            // ),
          ],
        ),
      ),
    );
  }
// }
}
