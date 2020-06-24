import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:phcapp/src/blocs/blocs.dart';
import 'package:phcapp/src/blocs/setting_bloc.dart';
import 'package:phcapp/src/repositories/phc_repository.dart';
import 'package:phcapp/src/repositories/repositories.dart';
import 'package:phcapp/theme/theme_provider.dart';
import 'package:provider/provider.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  _Settings createState() => _Settings();
}

class _Settings extends State<Settings> {
  bool _devSelect = false;
  bool _uatSelect = false;
  SettingBloc settingBloc;
  // AuthBloc authBloc;

  @override
  void didChangeDependencies() {
    settingBloc = BlocProvider.of<SettingBloc>(context);
    // authBloc = BlocProvider.of<AuthBloc>(context);

    setState(() {
      if (settingBloc.state.environment != null) {
        _devSelect = settingBloc.state.environment.id == "dev" ?? false;
        _uatSelect = settingBloc.state.environment.id == "uat" ?? false;
      }
    });

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Settings"),
        ),
        body: Container(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
            child: ListView(
              children: <Widget>[
                // Text(settingBloc.state.toggleEnv != null
                //     ? "DATA:" + settingBloc.state.toggleEnv
                //     : ""),
                Text(
                  "Environment setting",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                MyBuildList(
                    title: "Development",
                    icon: Icons.android,
                    child: toggleDev(context)),
                MyBuildList(
                    title: "UAT",
                    icon: Icons.mobile_screen_share,
                    child: toggleUAT(context)),
                MyBuildList(
                  title: "Sync data",
                  icon: Icons.sync,
                  child: updateButton(),
                  subtitle: settingBloc.state.lastSynced,
                ),
                SizedBox(
                  height: 50,
                ),
                Text(
                  "General",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                MyBuildList(
                    title: "Dark mode",
                    icon: Icons.brightness_4,
                    child: toggleButton(context)),
                MyBuildList(
                  title: "App version",
                  icon: Icons.info,
                  child: appChild(),
                ),
              ],
            )));
  }

  appChild() => Text("1.8.06.20");

  toggleButton(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Switch(
        value: themeProvider.isDarkTheme,
        onChanged: (val) {
          themeProvider.setThemeData = val;
        });
  }

  toggleDev(BuildContext context) {
    // final themeProvider = Provider.of<ThemeProvider>(context);
    return Switch(
        value: _devSelect,
        onChanged: (val) {
          // val ??
          setState(() {
            _devSelect = val;
            _uatSelect = !val;
          });

          settingBloc
              .add(ToggleEnvironment(toggleEnv: _devSelect ? "dev" : "uat"));
        });
  }

  toggleUAT(BuildContext context) {
    // final themeProvider = Provider.of<ThemeProvider>(context);
    return Switch(
        value: _uatSelect,
        onChanged: (val) {
          setState(() {
            _devSelect = !val;
            _uatSelect = val;
          });

          settingBloc
              .add(ToggleEnvironment(toggleEnv: _uatSelect ? "uat" : "dev"));
        });
  }

  updateButton() {
    return FlatButton(
      color: Colors.blue,
      child: Text("Sync Now"),
      onPressed: () {
        var date = DateFormat("HH:mm:ss aaa").format(DateTime.now());

        // PhcRepository phcRepository = PhcRepository(
        //     phcApiClient: PhcApiClient(
        //         httpClient: http.Client(),
        //         environment: settingBloc.state.environment ?? myEnv)
        //     // settingBloc.state.environment != null
        new AuthBloc(
          phcRepository: PhcRepository(
            phcApiClient: PhcApiClient(
                httpClient: http.Client(),
                environment: settingBloc.state.environment),
          ),
        )..add(AppStarted());

        // authBloc.add(AppStarted());
        setState(() {
          settingBloc.add(PressSyncButton(lastSynced: "Last sync at $date"));
        });
      },
    );
  }
}

class MyBuildList extends StatelessWidget {
  final title;
  final icon;
  final child;
  final subtitle;

  MyBuildList({this.title, this.icon, this.child, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(right: 10), child: Icon(icon)),
                  Text(title)
                ],
              ),
              child
            ],
          ),
          subtitle != null
              ? Container(
                  padding: EdgeInsets.only(left: 34),
                  child: Text(
                    subtitle,
                    style: TextStyle(color: Colors.grey),
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
