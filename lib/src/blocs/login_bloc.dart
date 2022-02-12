import 'dart:async';
import 'package:app/src/blocs/validators.dart';
import 'package:app/src/utils/pref_users.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;
import 'package:app/src/utils/consts_utils.dart';
import 'dart:convert';

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

  //Funcion para realizar login de cuenta en Firebase
  Future<Map<String,dynamic>> loginFirebase(String email,String password) async {
    final authData = {
      'email'   :email,
      'password':password,
      'returnSecureToken':true
    };

    final resp = await http.post(
      Uri.parse('https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=${constante.tokenFirebase}'),
      body: json.encode( authData )
      );

      Map<String,dynamic> decodeResp = json.decode(resp.body);

      //print(decodeResp);

      if (decodeResp.containsKey('idToken')) {

        //Se guarda el usuario en las preferencias
        _prefs.token = decodeResp['idToken'];

        return {'ok':true,'token':decodeResp['idToken']};
      }else{
        return {'ok':false,'mensaje': decodeResp['error']['message']};
      }
  }  
  dispose() {
    _emailController.close();
    _passwordController.close();
  }
}