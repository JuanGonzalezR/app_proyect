import 'dart:async';
import 'package:app/src/blocs/validators.dart';
import 'package:app/src/utils/pref_users.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc with Validators {

  final _prefs = PreferenciasUsuario();

  final _emailController      = BehaviorSubject<String>();
  final _passwordController   = BehaviorSubject<String>();

  Stream<String> get emailStream        => _emailController.stream.transform(validaEmail);
  Stream<String> get passwordStream     => _passwordController.stream.transform(validaPassword);

  Function(String) get changeEmail      => _emailController.sink.add;
  Function(String) get changePassword   => _passwordController.sink.add;

  Stream<bool> get submitValid          => Rx.combineLatest2(emailStream, passwordStream, (e, p) => true);

  String get getEmailBlog   => _emailController.value;
  String get getPasswordBlog   => _passwordController.value;

  dispose() {
    _emailController.close();
    _passwordController.close();
  }
}