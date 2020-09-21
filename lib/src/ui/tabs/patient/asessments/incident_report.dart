import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phcapp/src/models/phc.dart';
import 'package:phcapp/src/models/chip_item.dart';
import 'package:phcapp/src/ui/tabs/patient/asessments/blocs/reporting_bloc.dart';
import 'package:phcapp/src/widgets/my_multiple_option.dart';


const _responseDelay = [
  "Direction/ unable to locate",
  "Traffic",
  "Route obstruction",
  "Vehicle failure",
  "Vehicle crash",
  "Staff delay"
];

const _sceneDelay = [
  "Awaiting secondary responder",
  "Awaiting specialized vehicle",
  "Awaiting specialized equipment",
  "Awaiting PDRM officer (personal officer)",
  "Awaiting PDRM (left before arrive)"
  "Vehicle crash",
  "Vehicle failure"
];

const _transportDelay = ["Traffic", "Vehicle crash", "Vehicle failure"];



class IncidentReport extends StatefulWidget {
  final IncidentReporting incidentReporting;

  IncidentReport({this.incidentReporting});
  _IncidentState createState() => _IncidentState();
}

class _IncidentState extends State<IncidentReport>     
with AutomaticKeepAliveClientMixin<IncidentReport> {
  @override
  bool get wantKeepAlive => true;
  List<String> listResponse = new List<String>();
  List<String> listScene = new List<String>();
  List<String> listTransport = new List<String>();

  TextEditingController rdOtherController = new TextEditingController();
  TextEditingController sdOtherController = new TextEditingController();
  TextEditingController tdOtherController = new TextEditingController();
  
  List<ChipItem> prepareData = [
    ChipItem(
        id: "response_delay",
        name: "Response Delay",
        listData: _responseDelay,
        value: List<String>()),
    ChipItem(
        id: "scene_delay",
        name: "Scene Delay",
        listData: _sceneDelay,
        value: List<String>()),
    ChipItem(
        id: "transport_delay",
        name: "Transport Delay",
        listData: _transportDelay,
        value: List<String>()),
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
          listResponse = widget.incidentReporting.responseDelay;
        }
        if (f.id == "scene_delay") {
          f.value = widget.incidentReporting.sceneDelay;
          listScene = widget.incidentReporting.sceneDelay;
        }
        if (f.id == "transport_delay") {
          f.value = widget.incidentReporting.transportDelay;
          listTransport = widget.incidentReporting.transportDelay;
        }

        return f;
      }).toList();

      rdOtherController.text = widget.incidentReporting.othersResponse;
      sdOtherController.text = widget.incidentReporting.othersScene;
      tdOtherController.text = widget.incidentReporting.othersTransport;

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
                responseDelay: listResponse,
                othersResponse: rdOtherController.text,
                sceneDelay: listScene,
                othersScene: sdOtherController.text,
                transportDelay: listTransport,
                othersTransport: tdOtherController.text
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
      
            return MyCardMultipleOption(
              id: prepareData[index].id,
              name: prepareData[index].name,
              listData: prepareData[index].listData,
              mycallback: mycallback,
              value: prepareData[index].value,
              controller: prepareData[index].name == "Response Delay"
                          ? rdOtherController
                          : prepareData[index].name == "Scene Delay"
                          ? sdOtherController
                          : prepareData[index].name == "Transport Delay"
                          ? tdOtherController
                          : null

            );
            
          }),
    );
  }
}

class MyCardMultipleOption extends StatelessWidget {
  final id;
  final name;
  final listData;
  final value;
  final Function mycallback;
  final controller;

  MyCardMultipleOption(
      {this.id, this.name, this.listData, this.value, this.mycallback, this.controller});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
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
            name.contains("Response Delay") || name.contains("Scene Delay") || name.contains("Transport Delay")
            ? Container(
              width: MediaQuery.of(context).size.width * 0.5,
              child: TextField(
                style: TextStyle(fontSize: 18),
                decoration: InputDecoration(labelText: "Other"),
                controller: controller,
              ),
            )
            : Container()
          ],
        ),
      ),
    );
  }
}


