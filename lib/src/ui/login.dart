import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phcapp/src/blocs/blocs.dart';
import 'package:phcapp/src/ui/list_callcard.dart';
import 'package:phcapp/src/ui/settings.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen();
  _LoginScreen createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  TextEditingController usernameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  LoginBloc loginBloc;

  @override
  void initState() {
    loginBloc = BlocProvider.of<LoginBloc>(context);

    super.initState();
  }

  showError() => showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Login Failed"),
          content: Text("Your username and/or password do not match"),
        );
      });

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
  Widget build(BuildContext context) {
    loginBloc = BlocProvider.of<LoginBloc>(context);
    return SafeArea(
        child: Scaffold(
            body:
                BlocConsumer<LoginBloc, LoginState>(listener: (context, state) {
      if (state is LoginFailure) {
        showError();
      }
      // else if(state is Login)
      // if (state is LoginUnauthorized) {
      //   showUnauthorized();
      // } else if (state is LoginLoading) {
      //   loginBloc.add(AppStart());
      // } else if (state is AppStarted) {
      // } else if (state is LoginError) {
      //   showError();
      // } else if (state is LoggedIn) {
      //   Navigator.push(
      //       context, MaterialPageRoute(builder: (context) => ListCallcards()));
      // }
    }, builder: (context, state) {
      return _loginPage();
    })));
  }

  Widget _loginPage() {
    return SingleChildScrollView(
        child: Column(
      children: <Widget>[
        Row(children: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Settings()));
            },
          ),
          Text("Settings")
        ]),
        Container(
            width: 200,
            height: 100,
            child: Image(image: AssetImage('phcare.png'))),
        Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              "Pre Hospital Care App",
              style: TextStyle(fontFamily: "Raleway", fontSize: 16),
            )),
        Padding(
            padding: EdgeInsets.symmetric(vertical: 70, horizontal: 20),
            child: Container(
              width: 400,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _textInput("Username", usernameController, false),
                    _textInput("Password", passwordController, true),
                    Padding(
                        padding: EdgeInsets.all(10),
                        child: FlatButton(
                          child: Container(
                            height: 50,
                            width: 500,
                            decoration: BoxDecoration(
                                color: Colors.pinkAccent,
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                                child: Text(
                              "LOGIN",
                            )),
                          ),
                          onPressed: () {
                            final user = usernameController.text;
                            final password = passwordController.text;

                            loginBloc.add(LoginButtonPressed(
                                username: user, password: password));
                          },
                        ))
                  ]),
            ))
      ],
    ));
  }

  Widget _textInput(labelText, controller, obscureText) {
    return Container(
        // width: 500,
        width: 500,
        child: Padding(
            padding: EdgeInsets.all(16),
            child: TextFormField(
                obscureText: obscureText,
                // keyboardType: keyboardType,
                controller: controller,
                decoration: InputDecoration(
                    labelText: labelText,
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                      borderSide: new BorderSide(),
                    )))));
  }
}
