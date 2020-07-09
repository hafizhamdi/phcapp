import 'package:flutter/material.dart';
import 'package:phcapp/src/blocs/blocs.dart';
import 'package:phcapp/src/blocs/setting_bloc.dart';
// import 'package:phcapp/src/blocs/cpr_bloc.dart';
import 'package:phcapp/src/database/phc_dao.dart';
import 'package:phcapp/src/models/environment_model.dart';
import 'package:phcapp/src/providers/cpr_provider.dart';
import 'package:phcapp/src/repositories/repositories.dart';
import 'package:phcapp/src/ui/callcard_tabs.dart';
import 'package:phcapp/src/ui/history.dart';
import 'package:phcapp/src/ui/list_callcard.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phcapp/src/ui/login.dart';
import 'package:phcapp/src/ui/tabs/patient/asessments/blocs/intervention_bloc.dart';
import 'package:phcapp/src/ui/tabs/patient/asessments/blocs/medication_bloc.dart';
import 'package:phcapp/src/ui/tabs/patient/asessments/blocs/outcome_bloc.dart';
import 'package:phcapp/src/ui/tabs/patient/asessments/blocs/pat_ass_bloc.dart';
import 'package:phcapp/src/ui/tabs/patient/asessments/blocs/reporting_bloc.dart';
import 'package:phcapp/src/ui/tabs/patient/asessments/blocs/trauma_bloc.dart';
import 'package:phcapp/src/ui/tabs/patient/patient_tab.dart';
import 'package:phcapp/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class App extends StatefulWidget {
  final environment;

  App({this.environment});
  _App createState() => _App();
}

class _App extends State<App> {
  Environment myEnv;

  ThemeProvider themeProvider;
  PhcRepository phcRepository;
  PhcDaoClient phcDaoClient;
  SettingBloc settingBloc;

  @override
  void initState() {
    // SharedPreferences prefs = await SharedPreferences.getInstance();

    myEnv =
        new Environment(id: "dev", name: "Development", ip: "202.171.33.109");
    // bool CheckValue = prefs.containsKey('myenv');

    super.initState();
  }

  @override
  void didChangeDependencies() {
    settingBloc = BlocProvider.of<SettingBloc>(context);

    // settingBloc.add(LoadEnvironment());
    themeProvider = Provider.of<ThemeProvider>(context);

    // print("SEtting State environment");
    // print(settingBloc.state.environment);
    phcRepository = PhcRepository(
        phcApiClient: PhcApiClient(
      httpClient: http.Client(),
      // environment: settingBloc.state.environment ?? myEnv
    )
        // settingBloc.state.environment != null
        //     ? settingBloc.state.environment
        //     : myEnv),
        );

    // phcRepository = PhcRepository(
    phcDaoClient = new PhcDaoClient(
      phcDao: new PhcDao(),
    );

    super.didChangeDependencies();
  }

//   @override
// void dispose() {

//   sett
//     super.dispose();
//   }
  // final phcDao = new PhcDao();

  showUnauthorized() => showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Login failed"),
          content:
              Text("You're not authorized. Please contact IT administrator"),
        );
      });

  @override
  build(BuildContext context) {
    print("BUILD APP START");
    return MultiBlocProvider(
      // BlocProvider(
      providers: [
        BlocProvider(
            create: (context) => PhcBloc(
                phcRepository: new PhcRepository(
                    phcApiClient: new PhcApiClient(
                        httpClient: http.Client(),
                        environment: settingBloc.state.environment)),
                phcDao: phcDaoClient.phcDao)),
        BlocProvider(create: (context) {
          return AuthBloc(
              phcRepository: phcRepository,
              phcDao: phcDaoClient.phcDao); //..add(AppStarted());
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
                phcRepository: new PhcRepository(
                    phcApiClient: new PhcApiClient(
                        httpClient: http.Client(),
                        environment: settingBloc.state.environment)),
                phcDao: phcDaoClient.phcDao)),
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
                // phcRepository: phcRepository,
                // phcDao: ,
                phcRepository: PhcRepository(
                    phcApiClient: new PhcApiClient(
                        httpClient: http.Client(),
                        environment: settingBloc.state.environment)),
                historyBloc: BlocProvider.of<HistoryBloc>(context))),
        BlocProvider(create: (context) => InterBloc()),
        BlocProvider(
          create: (context) => CprBloc(),
        ),
        BlocProvider(
          create: (context) => ResponseBloc(),
        ),
        BlocProvider(
          create: (context) => SceneBloc(),
        ),
        BlocProvider(
          create: (context) => TraumaBloc(),
        ),
        BlocProvider(
          create: (context) => AssPatientBloc(),
        ),
        BlocProvider(
          create: (context) => MedicationBloc(),
        ),
        BlocProvider(
          create: (context) => ReportingBloc(),
        ),
        BlocProvider(
          create: (context) => OutcomeBloc(),
        ),
      ],
      child: ChangeNotifierProvider(
        create: (context) => CPRProvider(),
        child: MaterialApp(
            theme: themeProvider.getThemeData,
            routes: <String, WidgetBuilder>{
              '/login': (BuildContext context) => LoginScreen(),
              '/listCallcards': (BuildContext context) => ListCallcards(),
              '/history': (BuildContext context) => History(),
              // '/patientTab': (BuildContext context) => PatientTab(),
            },
            // home: ListCallcards(phcDao: phcDaoClient.phcDao),
            home: LoginScreen()),
      ),
    );
  }
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment(
                  0.8, 0.0), // 10% of the width, so there are ten blinds.
              colors: [
                const Color(0xFF33ccff),
                const Color(0xFFff99cc)
              ], // whitish to gray
              tileMode: TileMode.mirror, // repeats the gradient over the canvas
            ),
          ),
          child: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                width: double.infinity,
                height: 300,
                child: Image(image: AssetImage('assets/ambulance.png')),
              ),
              Text(
                "PH Care",
                style: TextStyle(
                    fontFamily: "OpenSans",
                    fontWeight: FontWeight.w900,
                    fontSize: 40,
                    letterSpacing: 2.0),
              ),
              Text(
                "Pre Hospital Care",
                style: TextStyle(
                    fontFamily: "Roboto",
                    // fontWeight: FontWeight.bold,
                    fontSize: 25,
                    letterSpacing: 3.0),
              ),
              SizedBox(
                height: 100,
              ),
              Container(
                width: double.infinity,
                height: 100,
                child: Image(image: AssetImage('assets/kkm.png')),
              ),
            ]),
          ),
        ),
      ),
    );
    ;
  }
}
