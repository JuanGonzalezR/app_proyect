import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<String> signInWithGoogle() async {

  UserCredential userCredential;
  String message = '';

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
  userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

  final user = userCredential.user;

  if (user != null) {
    // Code for when authentication is valid 
    //tokenGoogle = user.uid;
    message = 'Welcome ${user.displayName}, your address is ${user.email}';
  }
  
  return message != '' ? message : 'Not authentication';
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
