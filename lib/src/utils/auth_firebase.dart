// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:app/src/utils/consts_utils.dart';
import 'dart:convert';

Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}

createUserWithEmailAndPassword(String email, String password) async {
  try {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('La contrase\u00F1a proporcionada es demasiado debil.');
    } else if (e.code == 'email-already-in-use') {
      print('La cuenta ya existe para ese correo electronico.');
    }
  } catch (e) {
    print(e);
  }
}

signInWithEmailAndPassword(String email, String password) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
    }
  }
}

sendVerification() async {
  User? user = FirebaseAuth.instance.currentUser;

  if (user != null && !user.emailVerified) {
    await user.sendEmailVerification();
  }
}

//Funcion para realizar login de cuenta en Firebase
Future<Map<String, dynamic>> loginFirebase(
    String email, String password) async {
  final authData = {
    'email': email,
    'password': password,
    'returnSecureToken': true
  };

  final resp = await http.post(
      Uri.parse(
          'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=${constante.tokenFirebase}'),
      body: json.encode(authData));

  Map<String, dynamic> decodeResp = json.decode(resp.body);

  //print(decodeResp);

  if (decodeResp.containsKey('idToken')) {
    //Se guarda el token en las preferencias para iniciar hasta el
    //_prefs.token = decodeResp['idToken'];

    return {'ok': true, 'token': decodeResp['idToken']};
  } else {
    return {'ok': false, 'mensaje': decodeResp['error']['message']};
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
