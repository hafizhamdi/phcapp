import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phcapp/simple_delegate.dart';
import 'package:phcapp/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import 'src/app.dart';

void main() {
  // runApp(App());
  BlocSupervisor.delegate = SimpleBlocDelegate();

  runApp(ChangeNotifierProvider(
      create: (_) => ThemeProvider(isLightTheme: true), child: App()));
}
