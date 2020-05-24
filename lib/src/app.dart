import 'package:flutter/material.dart';
import 'package:phcapp/src/blocs/blocs.dart';
// import 'package:phcapp/src/blocs/cpr_bloc.dart';
import 'package:phcapp/src/database/phc_dao.dart';
import 'package:phcapp/src/repositories/repositories.dart';
import 'package:phcapp/src/ui/list_callcard.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phcapp/src/ui/login.dart';
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

    // return MultiBlocProvider(
    //     // BlocProvider(
    //     providers: [
    //       BlocProvider(
    //           create: (context) => PhcBloc(
    //               phcRepository: phcRepository,
    //               phcDao: phcDaoClient.phcDao)), //),
    //       BlocProvider(
    //         create: (context) => CallInfoBloc(),
    //       ),
    //       BlocProvider(
    //           create: (context) => TeamBloc(phcDao: phcDaoClient.phcDao)),
    //       BlocProvider(
    //           create: (context) => StaffBloc(
    //               phcRepository: phcRepository, phcDao: phcDaoClient.phcDao)),
    //       BlocProvider(
    //           create: (context) => TimeBloc(phcDao: phcDaoClient.phcDao)),
    //       BlocProvider(
    //           create: (context) => SceneBloc(phcDao: phcDaoClient.phcDao)),

    //       BlocProvider(
    //           create: (context) => PatientBloc(phcDao: phcDaoClient.phcDao)),

    //       BlocProvider(
    //           create: (context) => VitalBloc(phcDao: phcDaoClient.phcDao)),

    //       BlocProvider(
    //           create: (context) => AuthBloc(phcRepository: phcRepository)),

    //       BlocProvider<AuthBloc>(create: (context) {
    //         return AuthBloc(phcRepository: phcRepository)..add(AppStarted());
    //       }),

    //     ],

    // bloc: PhcBloc(),
    return MultiBlocProvider(
        // BlocProvider(
        providers: [
          BlocProvider(
              create: (context) => PhcBloc(
                  phcRepository: phcRepository, phcDao: phcDaoClient.phcDao)),
          BlocProvider<AuthBloc>(create: (context) {
            return AuthBloc(phcRepository: phcRepository)..add(AppStarted());
          }),
          BlocProvider(
              create: (context) =>
                  LoginBloc(authBloc: BlocProvider.of<AuthBloc>(context))),
          BlocProvider(
            create: (context) => CallInfoBloc(),
          ),
          BlocProvider(
              create: (context) => TeamBloc(phcDao: phcDaoClient.phcDao)),
          BlocProvider(
              create: (context) => StaffBloc(
                  phcRepository: phcRepository, phcDao: phcDaoClient.phcDao)),
          BlocProvider(
              create: (context) => TimeBloc(phcDao: phcDaoClient.phcDao)),
          BlocProvider(
              create: (context) => PatientBloc(phcDao: phcDaoClient.phcDao)),
          BlocProvider(
              create: (context) => VitalBloc(phcDao: phcDaoClient.phcDao)),
          BlocProvider(
              create: (context) => HistoryBloc(
                    phcDao: phcDaoClient.phcDao,
                  )),
          BlocProvider(
              create: (context) => CallCardTabBloc(
                  phcDao: phcDaoClient.phcDao,
                  phcRepository: phcRepository,
                  historyBloc: BlocProvider.of<HistoryBloc>(context))),
          BlocProvider(create: (context) => InterBloc()),
          BlocProvider(
            create: (context) => CprBloc(),
          )
        ],
        child: MaterialApp(
            theme: themeProvider.getThemeData,
            // home: ListCallcards(phcDao: phcDaoClient.phcDao),
            home: BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is AuthUnitialized) {
                  return Scaffold(
                      body: Container(
                    width: 500,
                    height: 400,
                    child: Center(
                      child: Image(image: AssetImage('assets/ambulance.png')),
                    ),
                  ));
                } else if (state is AuthAunthenticated) {
                  return ListCallcards();
                } else if (state is AuthInitialized) {
                  return LoginScreen();
                } else if (state is AuthUnaunthenticated) {
                  return LoginScreen();
                } else if (state is AuthLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Container();
              },
            )));
  }
}
