import 'dart:async';
import 'package:app/src/blocs/validators.dart';
import 'package:rxdart/rxdart.dart';

class RegisterBloc with Validators {

  final _nameControllerRegister   = BehaviorSubject<String>();
  final _lastnameControllerRegister   = BehaviorSubject<String>();
  final _fechaNacimientoControllerRegister   = BehaviorSubject<String>();
  final _repeatpasswordControllerRegister   = BehaviorSubject<String>();
  final _passwordControllerRegister   = BehaviorSubject<String>();
  final _emailControllerRegister      = BehaviorSubject<String>();

  Stream<String> get nameStreamReg       => _nameControllerRegister.stream.transform(validaUserNames);
  Stream<String> get lastnameStreamReg       => _lastnameControllerRegister.stream.transform(validaUserNames);
  Stream<String> get emailStreamReg       => _emailControllerRegister.stream.transform(validaEmail);
  Stream<String> get passwordStreamReg     => _passwordControllerRegister.stream.transform(validaPasswordRegister);
  Stream<String> get repeatpasswordStreamReg     => _repeatpasswordControllerRegister.stream.transform(validaPasswordRegister);
  Stream<String> get fechanacimientoStreamReg     => _fechaNacimientoControllerRegister.stream.transform(validaUserNames);

  Function(String) get changeNameReg     => _nameControllerRegister.sink.add;
  Function(String) get changeLastNameReg     => _lastnameControllerRegister.sink.add;
  Function(String) get changeFechaNacimientoReg     => _fechaNacimientoControllerRegister.sink.add;
  Function(String) get changeRepeatPassReg     => _repeatpasswordControllerRegister.sink.add;
  Function(String) get changeEmailReg     => _emailControllerRegister.sink.add;
  Function(String) get changePasswordReg   => _passwordControllerRegister.sink.add;

  Stream<bool> get submitValidReg       => Rx.combineLatest2(emailStreamReg, passwordStreamReg, (e, p) => true);

  String get getNameBlocReg  => _emailControllerRegister.value;
  String get getLastNameBlocReg  => _lastnameControllerRegister.value;
  String get getFechaNacimientoBlocReg  => _fechaNacimientoControllerRegister.value;
  String get getRepeatPassBlocReg  => _repeatpasswordControllerRegister.value;
  String get getEmailBlocReg  => _emailControllerRegister.value;
  String get getPasswordBlocReg  => _passwordControllerRegister.value;
  
  dispose() {
    _emailControllerRegister.close();
    _passwordControllerRegister.close();
  }
}