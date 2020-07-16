import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phcapp/src/models/chip_item.dart';
import 'package:phcapp/src/models/phc.dart';
import 'package:phcapp/src/ui/tabs/patient/asessments/blocs/outcome_bloc.dart';
import 'package:phcapp/src/widgets/mycard_freetext.dart';
import 'package:phcapp/src/widgets/mycard_single_option.dart';

const _etdTriage = [
  "Red",
  "Yellow",
  "Green",
  "BID",
];
const _transport = [
  "Transported (resus)",
  "Transported (not resus)",
  "Treat and release",
  "Transport refusal (at own risk)",
  "Death at scene"
];
const _facilityType = [
  "Government hospital",
  "Government clinic",
  "Private hospital"
];
const _justification = [
  "Nearest facility",
  "Bypass protocol (stroke/trauma/cardiac)",
  "Patient preferred facility (follow up)",
  "Patient preferred facility (family reason)"
];

const _deterioration = [
  "None",
  "Respiratory arrest",
  "Cardiorespiratory arrest"
];

class OutcomeAssessment extends StatefulWidget {
  final Outcome outcome;

  OutcomeAssessment({this.outcome});

  _OutcomeAssessment createState() => _OutcomeAssessment();
}

class _OutcomeAssessment extends State<OutcomeAssessment> {
  List<String> listETDTriage = new List<String>();
  List<String> listTransport = new List<String>();
  List<String> listDestinationFacility = new List<String>();
  List<String> listDestinationJustification = new List<String>();
  List<String> listDeterioration = new List<String>();

  TextEditingController diagnosisController = new TextEditingController();
  TextEditingController destinationFacController = new TextEditingController();
  TextEditingController doctorNameController = new TextEditingController();

  List<dynamic> prepareData = [
    FreeTextItem(id: "diagnosis_text", name: "Provisional diagnosis"),
    ChipItem(
        id: "etd_triage", name: "ETD Triage", listData: _etdTriage, value: ""),
    ChipItem(
        id: "transport_status",
        name: "Transport Status",
        listData: _transport,
        value: ""),
    FreeTextItem(id: "destination_text", name: "Destination facility"),
    ChipItem(
        id: "facility_type",
        name: "Destination facility type",
        listData: _facilityType,
        value: ""),
    ChipItem(
        id: "justification",
        name: "Destination justification",
        listData: _justification,
        value: ""),
    FreeTextItem(
        id: "doctor_text",
        name: "Medical direction doctor name (if consulted)"),
    ChipItem(
        id: "deterioration",
        name: "Deterioration during transport",
        listData: _deterioration,
        value: ""),
  ];

  mycallback(id, List<String> dataReturn) {
    if (id == "etd_triage") {
      setState(() {
        listETDTriage = dataReturn;
      });
    }
    if (id == "transport_status") {
      setState(() {
        listTransport = dataReturn;
      });
    }
    if (id == "facility_type") {
      setState(() {
        listDestinationFacility = dataReturn;
      });
    }
    if (id == "justification") {
      setState(() {
        listDestinationJustification = dataReturn;
      });
    }
    if (id == "deterioration") {
      setState(() {
        listDeterioration = dataReturn;
      });
    }
  }

  @override
  void didChangeDependencies() {
    if (widget.outcome != null) {
      diagnosisController.text = widget.outcome.provisionDiagnosis;
      destinationFacController.text = widget.outcome.destinationFacility;
      doctorNameController.text = widget.outcome.medicalDirectionDoctorName;

      prepareData.map((f) {
        if (f.id == "etd_triage") {
          f.value = widget.outcome.etdTriage;
          listETDTriage.add(widget.outcome.etdTriage);
          if (listETDTriage.length > 1) {
            listETDTriage.removeLast();
          }
        }
        if (f.id == "transport_status") {
          f.value = widget.outcome.transportStatus;
          listTransport.add(widget.outcome.transportStatus);
          if (listTransport.length > 1) {
            listTransport.removeLast();
          }
        }
        if (f.id == "facility_type") {
          f.value = widget.outcome.destinationFacilityType;
          listDestinationFacility.add(widget.outcome.destinationFacilityType);
          if (listDestinationFacility.length > 1) {
            listDestinationFacility.removeLast();
          }
        }
        if (f.id == "justification") {
          f.value = widget.outcome.destinationJustification;
          listDestinationJustification
              .add(widget.outcome.destinationJustification);
          if (listDestinationJustification.length > 1) {
            listDestinationJustification.removeLast();
          }
        }
        if (f.id == "deterioration") {
          f.value = widget.outcome.deteriorationTransport;
          listDeterioration.add(widget.outcome.deteriorationTransport);
          if (listDeterioration.length > 1) {
            listDeterioration.removeLast();
          }
        }
        return f;
      }).toList();
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    diagnosisController.dispose();
    destinationFacController.dispose();
    doctorNameController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Outcome Assessment"), actions: <Widget>[
        FlatButton.icon(
            icon: Icon(Icons.save, color: Colors.white),
            label: Text(
              "SAVE",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              Outcome outcome = new Outcome(
                timestamp: new DateTime.now(),
                provisionDiagnosis: diagnosisController.text,
                etdTriage: listETDTriage.length > 0 ? listETDTriage[0] : "",
                transportStatus:
                    listTransport.length > 0 ? listTransport[0] : "",
                destinationFacility: destinationFacController.text,
                destinationFacilityType: listDestinationFacility.length > 0
                    ? listDestinationFacility[0]
                    : "",
                destinationJustification:
                    listDestinationJustification.length > 0
                        ? listDestinationJustification[0]
                        : "",
                medicalDirectionDoctorName: doctorNameController.text,
                deteriorationTransport:
                    listDeterioration.length > 0 ? listDeterioration[0] : "",
              );

              // print(outcome.toJson());

              BlocProvider.of<OutcomeBloc>(context)
                  .add(LoadOutcome(outcome: outcome));

              Navigator.of(context).pop();
            }),
      ]),
      body: _buildBody(),
    );
  }

  _buildBody() {
    return Container(
      margin: EdgeInsets.all(10),
      child: ListView.builder(
          itemCount: prepareData.length,
          itemBuilder: (context, index) {
            if (prepareData[index].id == "diagnosis_text") {
              return MyCardFreeText(
                id: prepareData[index].id,
                name: prepareData[index].name,
                controller: diagnosisController,
              );
            }

            if (prepareData[index].id == "destination_text") {
              return MyCardFreeText(
                id: prepareData[index].id,
                name: prepareData[index].name,
                controller: destinationFacController,
              );
            }

            if (prepareData[index].id == "doctor_text") {
              return MyCardFreeText(
                id: prepareData[index].id,
                name: prepareData[index].name,
                controller: doctorNameController,
              );
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
}

class FreeTextItem {
  final id;
  final name;
  final value;

  FreeTextItem({this.id, this.name, this.value});
}
