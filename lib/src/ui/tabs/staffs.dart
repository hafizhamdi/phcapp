import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phcapp/custom/header_section.dart';
import 'package:phcapp/src/blocs/blocs.dart';
import 'package:phcapp/src/models/phc.dart';
import 'package:phcapp/src/models/phc_staff.dart';

class Staffs extends StatefulWidget {
  Staffs();

  _Staffs createState() => _Staffs();
}

class _Staffs extends State<Staffs> {
  StaffBloc staffBloc;
  final controller = TextEditingController();

  List<Staff> _listStaffs;

  String filter;
  TeamBloc teamBloc;

  @override
  void initState() {
    super.initState();
    staffBloc = BlocProvider.of<StaffBloc>(context);

    teamBloc = BlocProvider.of<TeamBloc>(context);
    // ;
    // print("staffBloc");
    // print(staffBloc);
    staffBloc.add(FetchStaff());

    controller.addListener(() {
      setState(() {
        filter = controller.text;
      });
    });
  }

  List<int> listSelected = new List<int>();

  @override
  build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      // appBar: AppBar(
      //   title: Text("Add Response Team"),
      // ),
      body: SafeArea(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20.0),
            ),
          ),
          margin: EdgeInsets.all(10),
          child: BlocConsumer<StaffBloc, StaffState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is StaffFetched) {
                return Column(children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        HeaderSection("Add Response Team"),
                        IconButton(
                          icon: Icon(Icons.check),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ]),
                  SizedBox(
                    height: 20,
                  ),
                  // new Padding(
                  //   padding: new EdgeInsets.only(top: 20.0),
                  // ),
                  Padding(
                      padding: EdgeInsets.all(10),
                      child: TextField(
                        decoration: InputDecoration(
                            // hintText: hintText,
                            labelText: "Search Staff Name",
                            fillColor: Colors.white,
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(40.0),
                              borderSide: new BorderSide(),
                            ),
                            prefixIcon: Icon(Icons.search),
                            suffixIcon: IconButton(
                                onPressed: () => controller.clear(),
                                icon: Icon(Icons.cancel))
                            // )

                            // decoration: new InputDecoration(
                            //   labelText: "Search staff name",
                            //   border:,
                            ),
                        controller: controller,
                      )),
                  new Expanded(
                      child: ListView.builder(
                    itemCount: state.available_staffs.length,
                    itemBuilder: (context, index) {
                      return filter == null || filter == ""
                          ? Container(
                              color: teamBloc.listSelected.contains(index)
                                  ? Colors.pink[200]
                                  : null,
                              child: ListTile(
                                title: Text(state.available_staffs[index].name),
                                subtitle: Text(
                                    state.available_staffs[index].position),
                                trailing: teamBloc.listSelected.contains(index)
                                    ? Icon(Icons.check)
                                    : null,
                                onTap: () {
                                  setState(() {
                                    teamBloc.listSelected.add(index);
                                  });
                                  // print("your location:{$index}");
                                  // print("you pressed me!! " +
                                  //     state.available_staffs[index].name);

                                  BlocProvider.of<TeamBloc>(context).add(
                                      // staffBloc.add(
                                      AddTeam(
                                          staff:
                                              state.available_staffs[index]));
                                  // setState(() {
                                  //  _listStaffs.add(state.available_staffs[index]);
                                  // });
                                },
                              ))
                          : state.available_staffs[index].name
                                  .toLowerCase()
                                  .contains(filter.toLowerCase())
                              ? Container(
                                  color: teamBloc.listSelected.contains(index)
                                      ? Colors.pink[200]
                                      : null,
                                  child: ListTile(
                                    title: Text(
                                        state.available_staffs[index].name),
                                    subtitle: Text(
                                        state.available_staffs[index].position),
                                    trailing:
                                        // IconButton(
                                        // icon:
                                        teamBloc.listSelected.contains(index)
                                            ? Icon(Icons.check)
                                            : null,
                                    // onPressed: () {},
                                    // ),
                                    onTap: () {
                                      // print("your location:{$index}");
                                      // print("you pressed me!! " +
                                      //     state.available_staffs[index].name);

                                  setState(() {
                                    teamBloc.listSelected.add(index);
                                  });

                                      BlocProvider.of<TeamBloc>(context).add(
                                          // staffBloc.add(
                                          AddTeam(
                                              staff: state
                                                  .available_staffs[index]));
                                      // mySelectedList.add(index);
                                    },
                                  ))
                              : new Container();

                      // return
                    },

                    // child: Text("All staffs not selected yet"),
                  ))
                ]);
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }
}
