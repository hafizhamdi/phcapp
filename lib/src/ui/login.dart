import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:phcapp/src/blocs/blocs.dart';
import 'package:phcapp/src/ui/list_callcard.dart';
import 'package:phcapp/src/ui/settings.dart';
import 'package:phcapp/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen();
  _LoginScreen createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  TextEditingController usernameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  LoginBloc loginBloc;

  bool isUserActive = false;
  bool isPassActive = false;

  final _formKey = GlobalKey<FormState>();

  double _scale;
  AnimationController _controller;

  @override
  void initState() {
    // login button - bouncing animation
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 100,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });

    loginBloc = BlocProvider.of<LoginBloc>(context);

    super.initState();
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
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

  showEmpty() => showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Login Failed"),
          content: Text("Enter your staff userid and password"),
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
    _scale = 1 - _controller.value;
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

  Widget get _animatedButtonUI => Container(
        height: 60,
        width: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          boxShadow: [
            BoxShadow(
              color: Color(0x80000000),
              blurRadius: 10.0,
              offset: Offset(0.0, 0.0),
            ),
          ],
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Color(0xFF3383CD), Colors.green],
          ),
          // color: Color(0xFF11249F),
          // color: Color(0xFFCDDC39),
        ),
        child: Center(
          child: Text(
            'LOGIN',
            style: TextStyle(
              fontSize: 16.0,
              letterSpacing: 3,
              fontWeight: FontWeight.bold,
              // color: Colors.white
            ),
          ),
        ),
      );

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
    final user = usernameController.text;
    final password = passwordController.text;
    Future.delayed(Duration(milliseconds: 500), () {
      if (user.isEmpty || password.isEmpty) {
        showEmpty();
      } else {
        loginBloc.add(LoginButtonPressed(username: user, password: password));
      }
    });
  }

  Widget _loginPage() {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        // height: MediaQuery.of(context).size.height,
        // decoration: BoxDecoration(
        //   gradient: LinearGradient(
        //     begin: Alignment.topRight,
        //     end: Alignment.bottomLeft,
        //     colors: [
        //       Color(0xFF3383CD),
        //       Color(0xFF11249F),
        //     ],
        //   ),
        // ),
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
                      Colors.green
                      // Color(0xFF112BBF),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          // (
                          // child:
                          // Container(
                          //   width: 200,
                          //   child: Image(
                          //       image: AssetImage('assets/ambulanceMY.png')),
                          //   // )
                          // ),
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
                              "HRPB Version 1.22",
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
            Padding(
              padding: EdgeInsets.symmetric(vertical: 50, horizontal: 20),

              // padding: EdgeInsets.all(10),
              //     child: Text(
              //       "Pre Hospital Care App",
              //       style: TextStyle(fontFamily: "Raleway", fontSize: 16),
              //     )),

              // Padding(
              // child: Container(
              // width: 400,
              // child: Form(
              //   key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _textInput("Username", Icons.person, usernameController,
                      false, isUserActive),
                  _textInput("Password", Icons.vpn_key, passwordController,
                      true, isPassActive),
                  SizedBox(
                    height: 10,
                  ),
                  // InkWell(
                  //   child: Container(
                  //     height: 60,
                  //     // width: double.infinity,
                  //     // margin: EdgeInsets.symmetric(vertical: 10),
                  //     // padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  //     constraints: BoxConstraints(maxWidth: 300),
                  //     decoration: BoxDecoration(
                  //       color: Color(0xFF11249F),
                  //       borderRadius: BorderRadius.circular(30.0),

                  //       boxShadow: [
                  //         BoxShadow(
                  //             offset: Offset(0, 4),
                  //             blurRadius: 60,
                  //             color: Colors.black.withOpacity(.1)),
                  //       ],
                  //       // color: Colors.white,
                  //       // borderRadius: BorderRadius.circular(30),
                  //       border: Border.all(
                  //         color: Color(0xFFE5E5E5),
                  //       ),
                  //     ),
                  // child:
                  Center(
                    child: GestureDetector(
                      onTapDown: _onTapDown,
                      onTapUp: _onTapUp,
                      child: Transform.scale(
                        scale: _scale,
                        child: _animatedButtonUI,
                      ),
                    ),
                  )
                  //   Text(
                  //     "LOGIN",
                  //     style: TextStyle(
                  //         color: Colors.white,
                  //         letterSpacing: 3.0,
                  //         fontSize: 16),
                  //   ),
                  // ),
                  //   ),
                  //   onTap: () {
                  //     final user = usernameController.text;
                  //     final password = passwordController.text;

                  //     if (user.isEmpty || password.isEmpty) {
                  //       showEmpty();
                  //     } else {
                  //       loginBloc.add(LoginButtonPressed(
                  //           username: user, password: password));
                  //     }
                  //   },
                  // ),
                  // )
                ],
              ),
            ),

            FlatButton.icon(
              icon: Icon(
                Icons.settings,
                // color: Colors.white,
              ),
              label: Text(
                "Settings",
                // style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Settings()));
              },
              // ,
            ),
            // ]),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            // Stack(
            //   children: <Widget>[
            //     Positioned(
            //       child:
            Container(
              padding: EdgeInsets.symmetric(horizontal: 50),
              // margin: EdgeInsets.only(bottom: 50),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 70,
                      child: Image(image: AssetImage('assets/heart_kkm.png')),
                      // SvgPicture.asset("assets/town.svg"),
                    ),
                    Container(
                      width: 100,
                      child: Image(image: AssetImage('assets/kkm.png')),
                      // SvgPicture.asset("assets/town.svg"),
                    ),
                    Container(
                      width: 70,
                      child: Image(image: AssetImage('assets/mers999.png')),
                      // SvgPicture.asset("assets/town.svg"),
                    ),
                  ]),
            ),
            SizedBox(
              height: 20,
            )

            // ],
            // ),
            // )
            // Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            // ],
            // )
            //   IconButton(
            //   ),
            //   Text("Settings")
            // ])
          ],
        ),
      ),
    );
  }

  Widget _textInput(labelText, icon, controller, obscureText, isActive) {
    final primaryColor =
        Provider.of<ThemeProvider>(context).getThemeData.primaryColor;
    return Container(
      constraints: BoxConstraints(maxWidth: 300),
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      padding: EdgeInsets.symmetric(horizontal: 20),
      height: 60,
      decoration: BoxDecoration(
        // color:
        // isActive ? Colors.yellow[100] :
        // Colors.white,
        border: Border.all(color: Colors.grey),
        // boxShadow: [
        //   BoxShadow(
        //     color: Color(0x80000000),
        //     blurRadius: 5.0,
        //     offset: Offset(0.0, 0.0),
        //   ),
        // ],
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: <Widget>[
          Icon(
            icon,
            color:
                // isActive ? primaryColor :

                Colors.grey[600],
          ),
          SizedBox(width: 20),
          Expanded(
            child: TextField(
              style: TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w700,
                  // color: Colors.,
                  fontSize: 18,
                  letterSpacing: 1.0),
              cursorColor: primaryColor,
              obscureText: obscureText,
              onChanged: (text) {
                if (text.length > 0) {
                  if (obscureText == true) {
                    setState(() {
                      isPassActive = true;
                    });
                  } else {
                    setState(() {
                      isUserActive = true;
                    });
                  }
                } else {
                  if (obscureText == true) {
                    setState(() {
                      isPassActive = false;
                    });
                  } else {
                    setState(() {
                      isUserActive = false;
                    });
                  }
                }
              },
              controller: controller,
              decoration: InputDecoration(
                  focusColor: Color(0xFF512DA8),
                  border: InputBorder.none,
                  hintText: labelText),
            ),
          ),
        ],
      ),
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
