// ignore_for_file: avoid_print

import 'dart:async';

import 'package:app/src/utils/functions.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:app/src/utils/consts_utils.dart';
import 'dart:convert';

final auth = FirebaseAuth.instance;

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
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((_) async {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
      }
    }).catchError((_) {});
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

changePassword (String email)async{
  auth.sendPasswordResetEmail(email: email)
  .then((_) {
    BotToast.showText(text: "Se envio cambio de contrase\u00F1a, favor revisa tu correo",duration: const Duration(seconds: 4));
  })
  .catchError((e){
        BotToast.showText(text: "Error al enviar cambio de contrase\u00F1a, intentalo de nuevo",duration: const Duration(seconds: 4));
        print("Error 1 "+e.toString());
  })
  .onError((error, stackTrace) {
        BotToast.showText(text: "Error al enviar cambio de contrase\u00F1a, intentalo de nuevo ",duration: const Duration(seconds: 4));
        print("Error 2 "+error.toString());
  })
  ;
}

signInWithEmailAndPassword(BuildContext context,String email, String password, FuncionesUtils fc) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((_) async {

        await auth.currentUser?.reload();
        User? user = auth.currentUser;

        //print("User: ${user?.getIdToken()}, check: $user");

        if (user != null && user.emailVerified) {
          //_pref.token = value['token'];
          fc.showNotifyLoading(() {
            Timer.run(() {
              Navigator.pushReplacementNamed(context, 'home');
            });
          });
        } else {
            //await user.sendEmailVerification();
            BotToast.showText(
              text: "Usuario no verificado, favor revisa tu correo",
              duration: const Duration(seconds: 4));
          
        }
      
    });
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      fc.showNotifyLoading(() =>
            BotToast.showText(text: "El correo electronico no se encuentra registrado"));
    } else if (e.code == 'wrong-password') {
      fc.showNotifyLoading(() =>
            BotToast.showText(text: "Usuario o contrase\u00F1a incorrecta"));
    }
  }
}

valideChanges(String changesfor) {
  User? user = FirebaseAuth.instance.currentUser;
  if (changesfor == 'auth') {
    // Changes in the authentication of user
    FirebaseAuth.instance.authStateChanges().listen((_) {
      if (user != null && user.emailVerified) {
        
      } else {
        
      }
    });
  } else if (changesfor == 'token') {
    // Changes in the token of user
    FirebaseAuth.instance.idTokenChanges().listen((_) {
      if (user != null && user.emailVerified) {
        
      } else {
        
      }
    });
  } else {
    // Changes in the user
    FirebaseAuth.instance.userChanges().listen((_) {
      if (user != null && user.emailVerified) {
        
      } else {
        
      }
    });
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
          'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$tokenFirebase'),
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
