import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phcapp/custom/drop_downlist.dart';
import 'package:phcapp/src/models/chip_item.dart';
import 'package:phcapp/src/models/phc.dart';
import 'package:phcapp/src/ui/tabs/patient/asessments/blocs/reporting_bloc.dart';
import 'package:phcapp/src/widgets/mycard_single_option.dart';

const _responseDelay = [
  "direction/ unable to locate",
  "traffic",
  "route obstruction",
  "vehicle failure",
  "vehicle crash",
  "staff delay"
];

const _sceneDelay = [
  "awaiting secondary responder",
  "awaiting specialized vehicle",
  "awaiting specialized equipment",
  "awaiting PDRM officer",
  "vehicle crash",
  "vehicle failure"
];

const _transportDelay = ["traffic", "vehicle crash", "vehicle failure"];

class IncidentReport extends StatefulWidget {
  final IncidentReporting incidentReporting;

  IncidentReport({this.incidentReporting});
  _IncidentState createState() => _IncidentState();
}

class _IncidentState extends State<IncidentReport> {
  List<String> listResponse = new List<String>();
  List<String> listScene = new List<String>();
  List<String> listTransport = new List<String>();

  List<ChipItem> prepareData = [
    ChipItem(
        id: "response_delay",
        name: "Response Delay",
        listData: _responseDelay,
        value: ""),
    ChipItem(
        id: "scene_delay",
        name: "Scene Delay",
        listData: _sceneDelay,
        value: ""),
    ChipItem(
        id: "transport_delay",
        name: "Transport Delay",
        listData: _transportDelay,
        value: ""),
  ];

  mycallback(id, List<String> dataReturn) {
    if (id == "response_delay") {
      setState(() {
        listResponse = dataReturn;
      });
    }
    if (id == "scene_delay") {
      setState(() {
        listScene = dataReturn;
      });
    }
    if (id == "transport_delay") {
      setState(() {
        listTransport = dataReturn;
      });
    }
  }

  @override
  void didChangeDependencies() {
    if (widget.incidentReporting != null) {
      prepareData.map((f) {
        if (f.id == "response_delay") {
          f.value = widget.incidentReporting.responseDelay;
          listResponse.add(widget.incidentReporting.responseDelay);
          if (listResponse.length > 1) {
            listResponse.removeLast();
          }
        }
        if (f.id == "scene_delay") {
          f.value = widget.incidentReporting.sceneDelay;
          listScene.add(widget.incidentReporting.sceneDelay);
          if (listScene.length > 1) {
            listScene.removeLast();
          }
        }
        if (f.id == "transport_delay") {
          f.value = widget.incidentReporting.transportDelay;
          listTransport.add(widget.incidentReporting.transportDelay);
          if (listTransport.length > 1) {
            listTransport.removeLast();
          }
        }

        return f;
      }).toList();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Incident Reporting"), actions: <Widget>[
        FlatButton.icon(
            icon: Icon(Icons.save, color: Colors.white),
            label: Text(
              "SAVE",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              IncidentReporting incidentReporting = new IncidentReporting(
                timestamp: new DateTime.now(),
                responseDelay: listResponse.length > 0 ? listResponse[0] : "",
                sceneDelay: listScene.length > 0 ? listScene[0] : "",
                transportDelay:
                    listTransport.length > 0 ? listTransport[0] : "",
              );

              print(incidentReporting.toJson());

              BlocProvider.of<ReportingBloc>(context)
                  .add(LoadReporting(incidentReporting: incidentReporting));

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
