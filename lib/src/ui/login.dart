import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
          content: Text("Your username and/or password did not match"),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
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
        body: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthAunthenticated) {
              Navigator.of(context).pushNamed('/listCallcards');
            } else if (state is AuthUnaunthenticated) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/login', (Route<dynamic> route) => false);
            }
            // else if( state is AuthUnitialized){
            //   //     showUnauthorized();

            // }
          },
          builder: (context, state) {
            // if (state is AuthUnitialized) {

            // if (state is AuthAunthenticated) {
            //   // return ListCallcards();
            //   // }
            //   // else if (state is AuthInitialized) {
            //   //   return LoginScreen();
            //   // } else if (state is AuthUnitialized) {
            //   //   return LoginScreen();
            // } else if (state is AuthUnaunthenticated) {
            //   // showUnauthorized();
            //   // return LoginScreen();
            // }
            //  else if (state is AuthLoading) {
            //   return Center(
            //     child: CircularProgressIndicator(),
            //   );
            // }
            // return
            // return Container();
            return _loginPage();
            // );
          },
        ),
        // BlocConsumer<LoginBloc, LoginState>(
        //   listener: (context, state) {
        //     if (state is LoginFailure) {
        //       showError();
        //     }
        //     // else if(state is Login)
        //     // if (state is LoginUnauthorized) {
        //     //   showUnauthorized();
        //     // } else if (state is LoginLoading) {
        //     //   loginBloc.add(AppStart());
        //     // } else if (state is AppStarted) {
        //     // } else if (state is LoginError) {
        //     //   showError();
        //     // } else if (state is LoggedIn) {
        //     //   Navigator.push(
        //     //       context, MaterialPageRoute(builder: (context) => ListCallcards()));
        //     // }
        //   },
        //   builder: (context, state) {
        //     return
        //         // Center(child:
        //         _loginPage();
        //     // );
        //   },
        // ),
      ),
    );
  }

  Widget _loginPage() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          ClipPath(
            clipper: MyClipper(),
            child: Container(
              padding: EdgeInsets.only(
                left: 20, top: 50,
                // bottom: 100
                //  right: 20
              ),
              height: 350,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Color(0xFF3383CD),
                    Color(0xFF11249F),
                  ],
                ),
                // image: DecorationImage(
                //   image: AssetImage("assets/images/authentication.svg"),
                // ),
              ),
              child: Stack(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Positioned(
                      // top: 10,
                      // bottom: 0.1,
                      // left: 100,
                      // right: 0,
                      child: Container(
                        width: double.infinity,
                        child:
                            Image(image: AssetImage('assets/medicineMY.png')),
                        // SvgPicture.asset("assets/medicine.svg"),
                      ),
                    ),
                    Positioned(
                        child: Column(
                      children: <Widget>[
                        // (
                        // child:
                        Container(
                          width: 200,
                          child: Image(
                              image: AssetImage('assets/ambulanceMY.png')),
                          // )
                        ),
                        // SizedBox(
                        //   height: 40,
                        // ),
                        Container(
                          // right: 70,
                          child: Text(
                            "PH Care",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 50,
                                fontFamily: "Raleway"),
                          ),
                        ),
                        Container(
                          // right: 70,
                          // top: 60,
                          child: Text(
                            "HRPB Version 1.18",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              // fontFamily: "Raleway"
                            ),
                          ),
                        ),
                      ],
                    ))
                  ]),
            ),
            // ),
          ),

          // SizedBox(
          //   height: 50,
          // ),
          // Container(
          //     width: 200,
          //     height: 100,
          //     child: Image(image: AssetImage('assets/phcare.png'))),
          // Padding(
          //     padding: EdgeInsets.all(10),
          //     child: Text(
          //       "Pre Hospital Care App",
          //       style: TextStyle(fontFamily: "Raleway", fontSize: 16),
          //     )),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
            // child: Container(
            // width: 400,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _textInput("Username", Icons.person, usernameController, false),
                _textInput("Password", Icons.vpn_key, passwordController, true),
                FlatButton(
                  child: Container(
                    height: 60,
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    constraints: BoxConstraints(maxWidth: 300),
                    decoration: BoxDecoration(
                      color: Color(0xFF11249F),
                      borderRadius: BorderRadius.circular(30.0),

                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 4),
                            blurRadius: 60,
                            color: Colors.black.withOpacity(.1)),
                      ],
                      // color: Colors.white,
                      // borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: Color(0xFFE5E5E5),
                      ),
                    ),
                    child: Center(
                        child: Text(
                      "LOGIN",
                      style: TextStyle(
                          color: Colors.white,
                          letterSpacing: 3.0,
                          fontSize: 16),
                    )),
                  ),
                  onPressed: () {
                    final user = usernameController.text;
                    final password = passwordController.text;

                    loginBloc.add(
                        LoginButtonPressed(username: user, password: password));
                  },
                ),
                // )
              ],
            ),
            // )
          ),

          FlatButton.icon(
            icon: Icon(Icons.settings),
            label: Text("Settings"),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Settings()));
            },
            // ,
          )
          // Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          //   IconButton(
          //   ),
          //   Text("Settings")
          // ])
        ],
      ),
    );
  }

  Widget _textInput(labelText, icon, controller, obscureText) {
    return Container(
      constraints: BoxConstraints(maxWidth: 300),
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              offset: Offset(0, 4),
              blurRadius: 50,
              color: Colors.black.withOpacity(.1)),
        ],
        // color: Colors.lightBlue.withOpacity(.20),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          // color: Color(0xFFE5E5E5)
          color: Colors.grey,
        ),
      ),
      child: Row(
        children: <Widget>[
          Icon(icon),
          SizedBox(width: 20),
          Expanded(
              child: TextField(
                  obscureText: obscureText,
                  // keyboardType: inputType,
                  controller: controller,
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: labelText))),
        ],
      ),
      // return Container(
      //   // width: 500,
      //   // width: 400,
      //   // constraints: BoxConstraints(maxWidth: 500),
      //   // child: Padding(
      //   //     padding: EdgeInsets.all(16),
      //   child: Row(children: [
      //     Icon(icon),
      //     // SizedBox(width: 20),
      //     TextFormField(
      //       obscureText: obscureText,
      //       // keyboardType: keyboardType,
      //       controller: controller,
      //       decoration: InputDecoration(
      //         labelText: labelText,
      //         fillColor: Colors.white,
      //         border: new OutlineInputBorder(
      //           borderRadius: new BorderRadius.circular(50.0),
      //           borderSide: new BorderSide(),
      //         ),
      //       ),
      //     ),
      //   ]),

      // )
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 80);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
