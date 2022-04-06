import 'dart:async';
import 'package:app/src/views_pages/login_session_pages/forgot_pass.dart';
import 'package:app/src/views_pages/login_session_pages/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:app/src/utils/auth_firebase.dart';
import 'package:app/src/utils/functions.dart';
import 'package:app/src/CRUDs/login_crud.dart';
import 'package:app/src/providers/provider.dart';
import 'package:app/src/views_pages/desing_pages/desings_login.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';



class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginBloc _bloc = LoginBloc();
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    if (auth.currentUser != null) {
      auth.currentUser?.reload();
    }
    super.initState();
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [crearFondo(context), _loginForm(context)],
      ),
    );
  }
}

Widget _loginForm(BuildContext context) {
  final size = MediaQuery.of(context).size;
  final blocLogin = Provider.ofLoginBloc(context);
  final fc = FuncionesUtils();
  //final _prefs = PreferenciasUsuario();
  final log = LoginCRUD();

  return SingleChildScrollView(
    child: Column(
      children: [
        SafeArea(
            child: Container(
          height: 190.0,
        )),
        Container(
          width: size.width * 0.90,
          margin: const EdgeInsets.symmetric(vertical: 30.0),
          padding: const EdgeInsets.symmetric(vertical: 30.0),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: const <BoxShadow>[
                BoxShadow(
                    color: Colors.black26,
                    blurRadius: 3.0,
                    offset: Offset(0.0, 5.0),
                    spreadRadius: 3.0)
              ]),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 19.0),
            child: Column(
              children: [
                _crearEmail(blocLogin),
                const SizedBox(
                  height: 20.0,
                ),
                _crearPassword(blocLogin),
                const SizedBox(
                  height: 10.0,
                ),
                const RecordarPass(),
                const SizedBox(
                  height: 20.0,
                ),
                _crearBoton(blocLogin, context, log, fc),
                const SizedBox(
                  height: 10.0,
                ),
                DesingButtonOutline(() {
                  Navigator.push<void>(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => const RegisterPage(),
                    ),
                  );
                }, 'Quiero registrarme', 'Comfortaa-Bold'),
                const SizedBox(
                  height: 10.0,
                ),
                _crearBotonGoogle(blocLogin, context, log),
                const SizedBox(
                  height: 10.0,
                ),
                DesingTextButton(
                    'olvidaste la contrase\u00F1a ?', 'Comfortaa-Light', () {
                  Navigator.push<void>(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => const ForgotPassword(),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _crearPassword(LoginBloc bloc) {
  return StreamBuilder<String>(
      stream: bloc.passwordStream,
      builder: (context, snapshot) {
        return DesingTextField(
            "*******",
            "Contrase\u00F1a",
            snapshot.error?.toString(),
            Icons.password_sharp,
            ValidaEstadoBloc(snaps: snapshot),
            Colors.white,
            Colors.blueAccent,
            bloc.changePassword,
            () {},
            TextInputType.visiblePassword,
            'Comfortaa-Light',
            true);
      });
}

Widget _crearEmail(LoginBloc bloc) {
  return StreamBuilder(
      stream: bloc.emailStream,
      builder: (context, snapshot) {
        return DesingTextField(
            "user@example.com",
            "Email",
            snapshot.error?.toString(),
            FontAwesomeIcons.at,
            ValidaEstadoBloc(snaps: snapshot),
            Colors.white,
            Colors.blueAccent,
            bloc.changeEmail,
            () {},
            TextInputType.emailAddress,
            'Comfortaa-Light',
            false);
      });
}

Widget _crearBoton(
    LoginBloc bloc, BuildContext context, LoginCRUD log, FuncionesUtils fc) {
  return StreamBuilder(
      stream: bloc.submitValid,
      builder: (context, snapshot) {
        return DesingButtonElevation(
            snapshot.hasData ? () => _botonLogin(context, bloc, fc) : null,
            "Ingresar",
            'Comfortaa-Bold',
            20.0,
            10.0);
      });
}

Future _botonLogin(
    BuildContext context, LoginBloc bloc, FuncionesUtils fc) async {
  //final _pref = PreferenciasUsuario();

  if (bloc.getEmailBloc.isNotEmpty && bloc.getPasswordBloc.isNotEmpty) {
    signInWithEmailAndPassword(context,bloc.getEmailBloc,bloc.getPasswordBloc,fc);
  }
}

Widget _crearBotonGoogle(
    LoginBloc blocLogin, BuildContext context, LoginCRUD log) {
  return SizedBox(
    width: double.infinity,
    child: SignInButton(
      Buttons.Google,
      text: "Registrate Google ",
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50.0),
      ),
      elevation: 5.0,
      onPressed: () {},
    ),
  );
}
