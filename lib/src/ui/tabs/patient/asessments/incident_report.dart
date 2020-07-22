import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phcapp/src/models/chip_item.dart';
import 'package:phcapp/src/models/phc.dart';
import 'package:phcapp/src/ui/tabs/patient/asessments/blocs/reporting_bloc.dart';
import 'package:phcapp/src/widgets/mycard_single_option.dart';

const _responseDelay = [
  "Direction/ unable to locate",
  "Traffic",
  "Route obstruction",
  "Vehicle failure",
  "Vehicle crash",
  "Staff delay",
  "Other"
];

const _sceneDelay = [
  "Awaiting secondary responder",
  "Awaiting specialized vehicle",
  "Awaiting specialized equipment",
  "Awaiting PDRM officer (personal officer)",
  "Awaiting PDRM (left before arrive)"
  "Vehicle crash",
  "Vehicle failure",
  "Other"
];

const _transportDelay = ["Traffic", "Vehicle crash", "Vehicle failure","Other"];

  TextEditingController rdOtherController = new TextEditingController();
  TextEditingController sdOtherController = new TextEditingController();
  TextEditingController tdOtherController = new TextEditingController();

class IncidentReport extends StatefulWidget {
  final IncidentReporting incidentReporting;

  IncidentReport({this.incidentReporting});
  _IncidentState createState() => _IncidentState();
}

class _IncidentState extends State<IncidentReport> {
  List<String> listResponse = new List<String>();
  List<String> listScene = new List<String>();
  List<String> listTransport = new List<String>();

  List<TextEditingController> otherController = [rdOtherController, sdOtherController, tdOtherController];

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
        rdOtherController.clear();
      });
    }
    if (id == "scene_delay") {
      setState(() {
        listScene = dataReturn;
        sdOtherController.clear();
      });
    }
    if (id == "transport_delay") {
      setState(() {
        listTransport = dataReturn;
        tdOtherController.clear();
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

      !_responseDelay.contains(widget.incidentReporting.responseDelay)
            ? rdOtherController.text = widget.incidentReporting.responseDelay
            : rdOtherController.clear();
      
      !_sceneDelay.contains(widget.incidentReporting.sceneDelay)
            ? sdOtherController.text = widget.incidentReporting.sceneDelay
            : sdOtherController.clear();

      !_transportDelay.contains(widget.incidentReporting.transportDelay)
            ? tdOtherController.text = widget.incidentReporting.transportDelay
            : tdOtherController.clear();

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
                responseDelay: listResponse.length > 0 
                                    ? listResponse[0] == "Other" || !_responseDelay.contains(listResponse[0])
                                    ? rdOtherController.text
                                    : listResponse[0] 
                                    : "",
                sceneDelay: listScene.length > 0 
                                    ? listScene[0] == "Other" || !_sceneDelay.contains(listScene[0])
                                    ? sdOtherController.text
                                    : listScene[0] 
                                    : "",
                transportDelay: listTransport.length > 0 
                                    ? listTransport[0] == "Other" || !_transportDelay.contains(listTransport[0])
                                    ? tdOtherController.text
                                    : listTransport[0] 
                                    : "",
              );

              // print(incidentReporting.toJson());

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
            String initialData;

            if(prepareData[index].name.contains("Response Delay"))
              if(!_responseDelay.contains(prepareData[index].value) && prepareData[index].value != "")
                initialData = "Other";
              else
                initialData = prepareData[index].value;
            else if(prepareData[index].name.contains("Scene Delay"))
              if(!_sceneDelay.contains(prepareData[index].value) && prepareData[index].value != "")
                initialData = "Other";
              else
                initialData = prepareData[index].value;
            else if(prepareData[index].name.contains("Transport Delay"))
              if(!_transportDelay.contains(prepareData[index].value) && prepareData[index].value != "")
                initialData = "Other";
              else
                initialData = prepareData[index].value;
    

            return MyCardSingleOption(
              id: prepareData[index].id,
              name: prepareData[index].name,
              listData: prepareData[index].listData,
              mycallback: mycallback,
              value: initialData,
              controller: otherController[index],
            );
            
          }),
    );
  }
}
