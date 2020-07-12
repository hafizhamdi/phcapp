import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phcapp/src/models/phc.dart';
import 'package:phcapp/src/ui/tabs/patient/asessments/blocs/otherinfo_bloc.dart';

class OtherInformation extends StatefulWidget {
  final OtherAssessment otherAssessment;

  OtherInformation({this.otherAssessment});
  _OtherInformation createState() => _OtherInformation();
}

class _OtherInformation extends State<OtherInformation> {
  TextEditingController extraController = new TextEditingController();

  @override
  void initState() {
    if (widget.otherAssessment != null) {
      extraController.text = widget.otherAssessment.extraNote;
    }

    super.initState();
  }

  @override
  void dispose() {
    extraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final otherBloc = BlocProvider.of<OtherBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Other Information"),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(
              Icons.save,
              color: Colors.white,
            ),
            label: Text("SAVE", style: TextStyle(color: Colors.white)),
            onPressed: () {
              otherBloc.add(UpdateOther(
                  otherAssessment: OtherAssessment(
                      timestamp: DateTime.now(),
                      extraNote: extraController.text)));

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
      padding: EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            _buildItem("Extra note", extraController),
          ],
        ),
      ),
    );
  }

  _buildItem(labelText, controller) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        // mainAxisAlignment: Main,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Expanded(
          //   child:
          Container(
            padding: EdgeInsets.only(top: 20, right: 10),
            width: 100,
            child: Text(labelText),
            // ),
          ),
          Expanded(
            child: TextFormField(
              keyboardType: TextInputType.multiline,
              maxLines: 15,
              textCapitalization: TextCapitalization.characters,
              // expands: true,
              controller: controller,
              decoration: InputDecoration(
                // counterText: true,
                hintText: "Enter " + labelText,
                // labelText: labelText,
                fillColor: Colors.white,
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(10.0),
                  borderSide: new BorderSide(),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
