import 'package:flutter/material.dart';
import 'package:phcapp/src/blocs/blocs.dart';
import 'package:phcapp/src/database/phc_dao.dart';
import 'package:phcapp/src/repositories/repositories.dart';
import 'package:phcapp/src/ui/list_callcard.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phcapp/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class App extends StatelessWidget {
  final PhcRepository phcRepository =
      PhcRepository(phcApiClient: PhcApiClient(httpClient: http.Client()));

  final PhcDaoClient phcDaoClient = new PhcDaoClient(phcDao: new PhcDao());
  // final phcDao = new PhcDao();

  @override
  build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MultiBlocProvider(
        // BlocProvider(
        providers: [
          BlocProvider(
              create: (context) => PhcBloc(
                  phcRepository: phcRepository,
                  phcDao: phcDaoClient.phcDao)), //),
          BlocProvider(
            create: (context) => CallInfoBloc(phcDao: phcDaoClient.phcDao),
          ),
          BlocProvider(
              create: (context) => TeamBloc(phcDao: phcDaoClient.phcDao)),
          BlocProvider(
              create: (context) => StaffBloc(
                  phcRepository: phcRepository, phcDao: phcDaoClient.phcDao)),
          BlocProvider(
              create: (context) => TimeBloc(phcDao: phcDaoClient.phcDao)),
          BlocProvider(
              create: (context) => SceneBloc(phcDao: phcDaoClient.phcDao)),

          BlocProvider(
              create: (context) => PatientBloc(phcDao: phcDaoClient.phcDao))
        ],

        // bloc: PhcBloc(),
        child: MaterialApp(
          theme: themeProvider.getThemeData,
          home: ListCallcards(phcDao: phcDaoClient.phcDao),
        ));
  }
}
