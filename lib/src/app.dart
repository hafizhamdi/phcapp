import 'package:flutter/material.dart';
import 'package:phcapp/src/ui/callcard_list.dart';
import 'package:phcapp/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  @override
  build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      theme: themeProvider.getThemeData,
      // return MaterialApp(
      //   theme: ThemeData.light(),
      home: CallcardList(),
      // )
    );
  }
}
