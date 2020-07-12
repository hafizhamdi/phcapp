import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phcapp/src/models/phc.dart';
import 'package:phcapp/src/ui/tabs/patient/asessments/blocs/sampler_bloc.dart';

class SampleScreen extends StatefulWidget {
  final SamplerAssessment samplerAssessment;

  SampleScreen({this.samplerAssessment});
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
  void initState() {
    if (widget.samplerAssessment != null) {
      signSymptomController.text = widget.samplerAssessment.signSymptom;
      allergyController.text = widget.samplerAssessment.allergies;
      medicationController.text = widget.samplerAssessment.medication;
      pMedicalController.text = widget.samplerAssessment.pastMedical;
      lastMealController.text = widget.samplerAssessment.lastMeal;
      injuryController.text = widget.samplerAssessment.eventLeadingInjuries;
      riskController.text = widget.samplerAssessment.riskFactor;
    }

    super.initState();
  }

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
    final samplerBloc = BlocProvider.of<SamplerBloc>(context);
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
              onPressed: () {
                samplerBloc.add(
                  UpdateSampler(
                    samplerAssessment: new SamplerAssessment(
                        timestamp: DateTime.now(),
                        signSymptom: signSymptomController.text,
                        allergies: allergyController.text,
                        medication: medicationController.text,
                        pastMedical: pMedicalController.text,
                        lastMeal: lastMealController.text,
                        eventLeadingInjuries: injuryController.text,
                        riskFactor: riskController.text),
                  ),
                );

                Navigator.pop(context);
              },
            )
          ],
        ),
        body: _buildBody());
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
            child: Container(
              // padding: EdgeInsets.all(40),
              // width: MediaQuery.of(context).size.width,
              // height: 200,
              child: TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: 5,
                // expands: true,
                controller: controller,
                decoration: InputDecoration(
                  // contentPadding: EdgeInsets.symmetric(vertical: 30),
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
            ),
          )
        ],
      ),
    );
  }
}
