import 'package:flutter/material.dart';
import 'package:phcapp/src/providers/cpr_provider.dart';
import 'package:provider/provider.dart';

class CPRTimeLog extends StatefulWidget {
  final cprSection;

  CPRTimeLog({this.cprSection});

  _CPRTimeLog createState() => _CPRTimeLog();
}

class _CPRTimeLog extends State<CPRTimeLog>
    with AutomaticKeepAliveClientMixin<CPRTimeLog> {
  @override
  bool get wantKeepAlive => true;

  // @override
  // void didChangeDependencies() {
  //   final cprProvider = Provider.of<CPRProvider>(context);
  //   if (widget.cprSection != null) {
  //     cprProvider.setLogs(widget.cprSection.logs);
  //   }

  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(20),
        child: Consumer<CPRProvider>(builder: (context, logs, child) {
          return ListView.builder(
            itemCount: logs.items.length,
            itemBuilder: (context, index) {
              TextEditingController controller =
                  TextEditingController(text: logs.items[index]);
              return Container(
                  child: Row(children: [
                Expanded(child: TextField(controller: controller)),
                IconButton(
                    onPressed: () {
                      confirmDeleteLog(context, logs, index);
                    },
                    icon: Icon(Icons.delete))
              ]));
            },
          );
        }));
  }

  confirmDeleteLog(context, logs, index) {
    // final provider = Provider.of<CPRProvider>(context);
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Delete log"),
            content: Text("Are you want to delete this log?"),
            actions: <Widget>[
              RaisedButton(
                // color: Colors.lightGreen,
                child: Text(
                  "CANCEL",
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              RaisedButton(
                color: Colors.lightGreen,
                child: Text(
                  "CONFIRM DELETE",
                ),
                onPressed: () {
                  logs.removeLog(index);

                  Navigator.pop(context);
                },
              ),
            ],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
          );
        });
  }
}
