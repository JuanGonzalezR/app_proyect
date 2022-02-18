import 'dart:async';
import 'package:app/src/blocs/validators.dart';
import 'package:rxdart/rxdart.dart';

class ForgotBloc with Validators {

  //final _prefs = PreferenciasUsuario();

  final _emailForgotController      = BehaviorSubject<String>();
  final _passwordForgotController   = BehaviorSubject<String>();

  Stream<String> get emailForgotStream        => _emailForgotController.stream.transform(validaEmail);
  Stream<String> get passwordForgotStream     => _passwordForgotController.stream.transform(validaPassword);

  Function(String) get changeEmailForgot      => _emailForgotController.sink.add;
  Function(String) get changePasswordForgot   => _passwordForgotController.sink.add;

  Stream<bool> get submitValidForgot          => Rx.combineLatest2(emailForgotStream, passwordForgotStream, (e, p) => true);

  String get getEmailFotgotBloc   => _emailForgotController.value;
  String get getPasswordForgotBloc   => _passwordForgotController.value;

  dispose() {
    _emailForgotController.close();
    _passwordForgotController.close();
  }
}