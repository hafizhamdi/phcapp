import 'package:flutter/material.dart';

class OtherInformation extends StatefulWidget {
  _OtherInformation createState() => _OtherInformation();
}

class _OtherInformation extends State<OtherInformation> {
  TextEditingController extraController = new TextEditingController();

  @override
  void dispose() {
    extraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            _buildItem("Extra remark", extraController),
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
