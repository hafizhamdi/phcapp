import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phcapp/src/widgets/my_single_option.dart';

class MyCardSingleOption extends StatelessWidget {
  final id;
  final name;
  final listData;
  final value;
  final Function mycallback;

  MyCardSingleOption(
      {this.id, this.name, this.listData, this.value, this.mycallback});

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
            MySingleOptions(
              id: id,
              listDataset: listData,
              initialData: value,
              callback: mycallback,
            ),
          ],
        ),
      ),
    );
  }
}
