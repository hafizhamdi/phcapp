import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phcapp/simple_delegate.dart';
import 'package:phcapp/src/blocs/setting_bloc.dart';
import 'package:phcapp/src/database/phc_dao.dart';
import 'package:phcapp/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import 'src/app.dart';

void main() {
  // This use to debug bloc state output
  BlocSupervisor.delegate = SimpleBlocDelegate();

  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(isDarkTheme: false),
      child: BlocProvider<SettingBloc>(
        // Initialize environment setted
        create: (context) =>
            SettingBloc(phcDao: new PhcDao())..add(LoadEnvironment()),
        child: App(),
      ),
    ),
  );
}
