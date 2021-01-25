import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:crypto/crypto.dart';
import 'package:http/http.dart';
import 'package:phcapp/src/blocs/blocs.dart';
import 'package:phcapp/src/database/phc_dao.dart';
import 'package:phcapp/src/models/phc.dart';
import 'package:phcapp/src/models/plateno.dart';

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

class AppLoggedOut extends AuthState {}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final phcRepository;
  PhcDao phcDao;

  AuthBloc({this.phcRepository, this.phcDao});
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

        final tmpfetchStaffs = List<Staff>.from(
            staffs["available_staffs"].map((x) => Staff.fromJson(x)));

        final plateNo = await phcRepository.getAvailablePlateNo();

        final tmpFetchPlateNo = List<PlateNo>.from(
            plateNo["available_plate_no"].map((x) => PlateNo.fromJson(x)));

        // print(fetchStaffs);
        // print("phcDao");
        // print(phcDao);
        if (phcDao == null) {
          phcDao = new PhcDao();
          final insert = await phcDao.updateStaffs(tmpfetchStaffs);
          final updatePlateNo = await phcDao.updatePlateNo(tmpFetchPlateNo);
        }
        // print(insert);
        // print("insert ok!");
        yield AuthInitialized(staffs: tmpfetchStaffs);
      } catch (_) {
        yield AuthUnitialized();
      }
      // yield AuthUnitialized();
    } else if (event is LoggedIn) {
      yield AuthLoading();

      final staffs = await phcDao.getStaffs();

      fetchStaffs = List<Staff>.from(staffs).toList();
      // print(staffs);

      // print("LOGGEDIN");
      // final currentState = state;
      // print(currentState);
      // print(fetchStaffs);
      final foundUser = fetchStaffs.firstWhere(
          (data) => data.userId.toLowerCase() == event.username.toLowerCase(),
          orElse: () => null);

      if (foundUser != null) {
        // print("user found not null");
        // print(foundUser.toJson());
        // print(foundUser.userId);
        // print(foundUser.password);
        var bytes = utf8.encode(event.password);
        var digest = sha1.convert(bytes);
        var md5 = "$digest";
        var secondCheck = generateMd5(event.password);
        // print(md5);
        var base64 = decodeBase64(foundUser.password);
        // print(base64);
        // sha1.convert(decoded);
        if (base64.trim() == md5.trim()) {
          setAuthorizedUser(foundUser);
          yield AuthAunthenticated();
        } else if (foundUser.password == secondCheck) {
          // print(secondCheck);
          setAuthorizedUser(foundUser);
          yield AuthAunthenticated();
        } else {
          yield AuthUnaunthenticated();
        }
      } else {
        yield AuthUnaunthenticated();
      }
    } else if (event is LoggedOut) {
      // yield AuthLoading();
      yield AppLoggedOut();
    }
  }

  String generateMd5(String password) {
    return md5.convert(utf8.encode(password)).toString();
  }

  String decodeBase64(String password) {
    // print("decodeBase64");
    var decoded = base64Decode(password);
    // print(decoded);
    var str = "";
    decoded.map((f) {
      // print(f.toRadixString(16));
      var tmpstr = "0" + f.toRadixString(16);
      str += tmpstr.substring(tmpstr.length - 2);
      // print(str);
    }).toList();

    // print(str);

    // var result =
    // var tmpBytes = String.(uInt8List);
    // print("$result");
    // uInt8List.map((f) {
    //   print(f);
    //   // print(f.toRadixString(2));
    // });
    // var encoded = utf8.decode(uInt8List);
    // print("encoded");
    // print(encoded);
    return str;
    // base64Decode(password).;
    // base.convert(utf8.encode(password)).toString();
  }
}

//TODO password encrypt/decrypt
// DECRYPT
// TEXT -> BASE64 -> BYTES -> MD5 SHA1 decode
// ENCRYPT
// TEXT -> BYTES -> MD5 SHA1 -> BASE64
