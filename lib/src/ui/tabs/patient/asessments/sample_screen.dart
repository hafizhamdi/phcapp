import 'package:flutter/material.dart';

class SampleScreen extends StatefulWidget {
  _SampleScreen createState() => _SampleScreen();
}

class _SampleScreen extends State<SampleScreen> {
  TextEditingController signSymptomController = new TextEditingController();
  TextEditingController allergyController = new TextEditingController();
  TextEditingController medicationController = new TextEditingController();
  TextEditingController pMedicalController = new TextEditingController();
  TextEditingController lastMealController = new TextEditingController();
  TextEditingController injuryController = new TextEditingController();
  TextEditingController riskController = new TextEditingController();

  @override
  void dispose() {
    signSymptomController.dispose();
    allergyController.dispose();
    medicationController.dispose();
    pMedicalController.dispose();
    lastMealController.dispose();
    injuryController.dispose();
    riskController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SAMPLER"),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(
              Icons.save,
              color: Colors.white,
            ),
            label: Text("SAVE", style: TextStyle(color: Colors.white)),
            onPressed: () {},
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
            _buildItem("Sign & Symptom", signSymptomController),
            _buildItem("Allergies", allergyController),
            _buildItem("Medication", medicationController),
            _buildItem("Past medical", pMedicalController),
            _buildItem("Last meal", lastMealController),
            _buildItem("Event leading to injury", injuryController),
            _buildItem("Risk factor", riskController),
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
              maxLines: null,
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
