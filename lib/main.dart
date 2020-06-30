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
  // runApp(App());
  BlocSupervisor.delegate = SimpleBlocDelegate();

  SettingBloc settingBloc; //BlocProvider.of(context).add(LoadEnvironment());

  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(isDarkTheme: false),
      child: BlocProvider<SettingBloc>(
        create: (context) =>
            SettingBloc(phcDao: new PhcDao())..add(LoadEnvironment()),
        child: App(
          // environment: settingBloc.state.environment,
        ),
        // child: BlocBu, SettingState>(
        //   bloc: settingBloc,
        //   builder: (context, state) {
        //     settingBloc = BlocProvider.of(context);
        //     if (state is EmptySetting) {
        //       settingBloc.add(LoadEnvironment());
        //     }
        //     if (state is LoadedSetting) {
        //       return App(environment: state.environment);
        //     }
        //     return App(
        //       environment: state.environment,
        //     );
        //   },
      ),
    ),
    // ),
  );
}
