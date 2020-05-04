import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:crypto/crypto.dart';
import 'package:http/http.dart';
import 'package:phcapp/src/blocs/blocs.dart';
import 'package:phcapp/src/models/phc.dart';

abstract class AuthEvent extends Equatable {
  AuthEvent();
}

class LoggedIn extends AuthEvent {
  final username;
  final password;
  LoggedIn({this.username, this.password});

  @override
  List<Object> get props => [username, password];

  @override
  String toString() {
    return "user login:" + username + password;
  }
}

class LoggedOut extends AuthEvent {}

class AppStarted extends AuthEvent {}

abstract class AuthState extends Equatable {
  AuthState();
}

// class AppStarted extends AuthState {}
class AuthInitialized extends AuthState {
  final List<Staff> staffs;
  AuthInitialized({this.staffs});

  @override
  List<Object> get props => [staffs];
 
  @override
  String toString() {
    return "bilangan staffs yang ada:" + staffs.length.toString();
  }
}

class AuthUnitialized extends AuthState {}

class AuthAunthenticated extends AuthState {}

class AuthUnaunthenticated extends AuthState {}

class AuthLoading extends AuthState {}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final phcRepository;
  AuthBloc({this.phcRepository});
  List<Staff> fetchStaffs = new List<Staff>();
  Staff _user;

  @override
  AuthState get initialState => AuthUnitialized();

  setAuthorizedUser(Staff user) => _user = user;

  Staff get getAuthorizedUser => _user;

  String generateMd5Password(String password) {
    return md5.convert(utf8.encode(password)).toString();
  }

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AppStarted) {
      yield AuthLoading();

      try {
        final staffs = await phcRepository.getAvailableStaffs();

        fetchStaffs = List<Staff>.from(
            staffs["available_staffs"].map((x) => Staff.fromJson(x)));
        yield AuthInitialized(staffs: fetchStaffs);
      } catch (_) {
        yield AuthUnitialized();
      }
    } else if (event is LoggedIn) {
      yield AuthLoading();

      final currentState = state;
      print(currentState);
      print(fetchStaffs);
      final foundUser = fetchStaffs.singleWhere(
          (data) => data.userid.toLowerCase() == event.username.toLowerCase());

      if (foundUser != null) {
        print(foundUser.password);
        final String md5 = generateMd5(event.password);
        print(md5);
        if (foundUser.password == md5) {
          setAuthorizedUser(foundUser);
          yield AuthAunthenticated();
        } else {
          yield AuthUnaunthenticated();
        }
      } else {
        yield AuthUnaunthenticated();
      }
    } else if (event is LoggedOut) {
      yield AuthUnaunthenticated();
    }
  }

  String generateMd5(String password) {
    return md5.convert(utf8.encode(password)).toString();
  }
}
