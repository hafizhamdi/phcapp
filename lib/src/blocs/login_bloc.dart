import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart';
import 'package:phcapp/src/blocs/blocs.dart';
import 'package:phcapp/src/database/phc_dao.dart';
import 'package:phcapp/src/models/phc.dart';
import 'package:bloc/bloc.dart';
import 'package:phcapp/src/models/phc_staff.dart';
import 'package:phcapp/src/repositories/repositories.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

abstract class LoginEvent extends Equatable {
  LoginEvent();
}

class LoginButtonPressed extends LoginEvent {
  final String username;
  final String password;

  LoginButtonPressed({this.username, this.password});

  @override
  List<Object> get props => [username, password];
}

class LogoutButtonPressed extends LoginEvent {
  LogoutButtonPressed();

  @override
  List<Object> get props => [];
}

abstract class LoginState extends Equatable {
  LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginFailure extends LoginState {}

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  // final PhcDao phcDao;
  // final PhcRepository phcRepository;

  final AuthBloc authBloc;
  Staff _user;
  List<Staff> availableStaffs = new List<Staff>();

  setAuthorizedUser(Staff user) => _user = user;

  Staff get getAuthorizedUser => _user;

  LoginBloc({this.authBloc});

  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoading();
      if (event.username == "" || event.password == "") {
        print("login error");
        yield LoginFailure();
        yield LoginInitial();
      } else {
        authBloc
            .add(LoggedIn(username: event.username, password: event.password));
      }
    } else if (event is LogoutButtonPressed) {
      authBloc.add(LoggedOut());
    }
  }
}
