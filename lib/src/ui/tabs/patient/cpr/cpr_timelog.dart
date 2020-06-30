import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phcapp/src/providers/cpr_provider.dart';
import 'package:phcapp/src/ui/tabs/patient/cpr/cpr_items.dart';
import 'package:provider/provider.dart';

class CPRTimeLog extends StatefulWidget {
  final index;
  final cprSection;

  CPRTimeLog({this.cprSection, this.index});

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

  getCounter(string) {
    if (string != null) {
      var list = string.split('>');
      if (list[1] != null) {
        return int.parse(list[1]);
      }
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    // final provider = Provider.of<CPRProvider>(context);

    return Scaffold(
      body:
          //     Container(
          //   child: FlatButton(
          //     child: Text("NEXT"),
          //     onPressed: () {
          //       Navigator.push(
          //         context,
          //         CupertinoPageRoute(
          //             builder: (context) => CPRItems(), maintainState: true),
          //       );
          //     },
          //   ),
          // )

          Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Consumer<CPRProvider>(builder: (context, logs, child) {
          if (logs.items.length > 0) {
            return ListView.builder(
              itemCount: logs.items.length,
              itemBuilder: (context, index) {
                TextEditingController controller =
                    TextEditingController(text: logs.items[index]);

                if (!logs.items[index].contains(">")) {
                  return Container(
                      child: Row(children: [
                    Expanded(
                        child: TextField(
                      controller: controller,
                      enabled: false,
                      // enabled: (widget.index != null) ? false : true,
                    )),
                    (widget.index != null)
                        ? Container()
                        : IconButton(
                            onPressed: () {
                              confirmDeleteLog(context, logs, index);
                            },
                            icon: Icon(Icons.delete))
                  ]));
                } else {
                  var counter = getCounter(logs.items[index]);

                  return Container(
                    // alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          // margin: EdgeInsets.all(10),
                          alignment: Alignment.center,
                          width: 60,
                          height: 60,
                          decoration: new BoxDecoration(
                            color: Colors.grey,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            "${counter}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                color: Colors.white.withOpacity(0.8)),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          logs.items[index].replaceAll(">", ""),
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                        ),
                      ],
                    ),
                  );
                }
              },
            );
          }
          return Center(
            child: Container(
              child: Text("No CPR Log recorded. Press Start CPRLOG"),
            ),
          );
        }),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.play_arrow),
        label: Text("START CPRLOG"),
        onPressed: () {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => CPRItems(),
            ),
          );
        },
      ),
      // ),
    );
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
