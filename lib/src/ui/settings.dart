import 'package:flutter/material.dart';
import 'package:phcapp/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Settings"),
        ),
        body: Container(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                _buildList(
                    "Dark mode", Icons.brightness_4, toggleButton(context)),
                _buildList("App version", Icons.info, appChild()),
              ],
            )));
  }

  appChild() => Text("1.6.06.20");

  toggleButton(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Switch(
        value: themeProvider.isDarkTheme,
        onChanged: (val) {
          themeProvider.setThemeData = val;
        });

    // return Switch(
    //       value: true,
    //       onChanged: (toggled) {},
    //     );
  }

  _buildList(title, icon, child) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: <Widget>[
                Padding(padding: EdgeInsets.only(right: 10), child: Icon(icon)),
                Text(title)
              ],
            ),
            child
          ],
        ));
  }
}
