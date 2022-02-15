import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:app/src/utils/consts_utils.dart';
import 'dart:convert';

Future<UserCredential> signInWithGoogle() async {

  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}

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

        //Se guarda el token en las preferencias para iniciar hasta el home
        //_prefs.token = decodeResp['idToken'];

        return {'ok':true,'token':decodeResp['idToken']};
      }else{
        return {'ok':false,'mensaje': decodeResp['error']['message']};
      }
  }

void _signOut() async {
  FirebaseAuth _auth = FirebaseAuth.instance;
  await _auth.signOut();
}

Future signOut() async {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final User? user = _auth.currentUser;

  if (user == null) {
    // Message of alert
    return;
  }
  _signOut();

  // Show message of sign out

}
