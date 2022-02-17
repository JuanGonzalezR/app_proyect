import 'dart:async';
import 'package:app/src/blocs/validators.dart';
import 'package:rxdart/rxdart.dart';

class RegisterBloc with Validators {
  final _nameControllerRegister = BehaviorSubject<String>();
  final _lastnameControllerRegister = BehaviorSubject<String>();
  final _fechaNacimientoControllerRegister = BehaviorSubject<String>();
  final _repeatpasswordControllerRegister = BehaviorSubject<String>();
  final _passwordControllerRegister = BehaviorSubject<String>();
  final _emailControllerRegister = BehaviorSubject<String>();
  final _countryControllerRegister = BehaviorSubject<String>();
  final _genderControllerRegister = BehaviorSubject<String>();

  Stream<String> get nameStreamReg => _nameControllerRegister.stream.transform(validaUserNames);
  Stream<String> get lastnameStreamReg => _lastnameControllerRegister.stream.transform(validaUserNames);
  Stream<String> get emailStreamReg => _emailControllerRegister.stream.transform(validaEmail);
  Stream<String> get passwordStreamReg => _passwordControllerRegister.stream.transform(validaPasswordRegister);
  Stream<String> get repeatpasswordStreamReg => _repeatpasswordControllerRegister.stream.transform(validaPasswordRegister);
  Stream<String> get fechanacimientoStreamReg => _fechaNacimientoControllerRegister.stream.transform(validaUserNames);
  Stream<String> get countryStreamReg => _countryControllerRegister.stream.transform(validaCountry);
  Stream<String> get genderStreamReg => _genderControllerRegister.stream.transform(validaGender);

  Function(String) get changeNameReg => _nameControllerRegister.sink.add;
  Function(String) get changeLastNameReg => _lastnameControllerRegister.sink.add;
  Function(String) get changeFechaNacimientoReg => _fechaNacimientoControllerRegister.sink.add;
  Function(String) get changeRepeatPassReg => _repeatpasswordControllerRegister.sink.add;
  Function(String) get changeEmailReg => _emailControllerRegister.sink.add;
  Function(String) get changePasswordReg => _passwordControllerRegister.sink.add;
  Function(String) get changeCountryReg => _countryControllerRegister.sink.add;
  Function(String) get changeGenderReg => _genderControllerRegister.sink.add;

  Stream<bool> get submitValidReg =>
  Rx.combineLatest7(nameStreamReg, lastnameStreamReg, emailStreamReg, passwordStreamReg, repeatpasswordStreamReg, fechanacimientoStreamReg, countryStreamReg, (a, b, c, d, e, f, g) => true);

  String get getNameBlocReg => _emailControllerRegister.value;
  String get getLastNameBlocReg => _lastnameControllerRegister.value;
  String get getFechaNacimientoBlocReg => _fechaNacimientoControllerRegister.value;
  String get getRepeatPassBlocReg => _repeatpasswordControllerRegister.value;
  String get getEmailBlocReg => _emailControllerRegister.value;
  String get getPasswordBlocReg => _passwordControllerRegister.value;
  String get getCountryBlocReg => _countryControllerRegister.value;
  String get getGenderBlocReg => _genderControllerRegister.value;

  dispose() {
    _nameControllerRegister.close;
    _lastnameControllerRegister.close;
    _fechaNacimientoControllerRegister.close;
    _repeatpasswordControllerRegister.close;
    _passwordControllerRegister.close;
    _emailControllerRegister.close;
    _countryControllerRegister.close;
    _genderControllerRegister.close;
  }
}
