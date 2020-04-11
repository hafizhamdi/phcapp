import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// import 'package:phcapp/callcard_detail.dart';
import 'package:phcapp/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import 'src/app.dart';

void main() {
  // runApp(App());
  runApp(ChangeNotifierProvider(
      create: (_) => ThemeProvider(isLightTheme: true), child: App()));
}

// class PhcApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     final themeProvider = Provider.of<ThemeProvider>(context);

//     return MaterialApp(
//       theme: themeProvider.getThemeData,
//       initialRoute: '/',
//       routes: {
//         '/': (context) => CallCardList(),
//         '/callcarddetail': (context) => CallCardDetail()
//       },
//     );
//     // home: );
//   }
// }

// class CallCardList extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final themeProvider = Provider.of<ThemeProvider>(context);
//     // TODO: implement build
//     return Scaffold(
//         appBar: AppBar(
//           // backgroundColor: Colors.purple,
//           title: Center(
//             child: Text("Call Cards",
//                 style: TextStyle(fontFamily: "Raleway", fontSize: 20)),
//           ),
//           leading: Container(
//               child: Switch(
//             value: themeProvider.isLightTheme,
//             onChanged: (val) {
//               themeProvider.setThemeData = val;
//             },
//           )),
//         ),
//         body: ListView.separated(
//           separatorBuilder: (context, index) => Divider(
//             color: Colors.grey,
//           ),
//           itemCount: 2,
//           itemBuilder: (context, index) => ListTile(
//             title: Text("392020011"),
//             subtitle: Text("26/03/2020, 2:59 PM"),
//             leading: Icon(Icons.headset_mic),
//             trailing: Icon(Icons.arrow_forward_ios),
//             onTap: () {
//               Navigator.pushNamed(context, "/callcarddetail");
//             },
//           ),
//         ));
//   }
// }
