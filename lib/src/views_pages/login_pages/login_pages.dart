import 'dart:async';

import 'package:app/src/blocs/register_bloc.dart';
import 'package:flutter/material.dart';
import 'package:app/src/utils/auth_firebase.dart';
import 'package:app/src/utils/functions.dart';
import 'package:app/src/utils/pref_users.dart';
import 'package:app/src/views_pages/login_pages/register_page.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:app/src/CRUDs/login_crud.dart';
import 'package:app/src/providers/provider.dart';
import 'package:app/src/views_pages/desing_pages/material_desing_pages.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginBloc _bloc = LoginBloc();

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final blocLogin = Provider.ofLoginBloc(context);
    return Scaffold(
      body: Stack(
        children: [_crearFondo(context), _loginForm(context)],
      ),
    );
  }
}

Widget _crearFondo(BuildContext context) {
  final size = MediaQuery.of(context).size;
  final fondoMorado = Container(
    height: size.height * 0.5,
    width: double.infinity,
    decoration: const BoxDecoration(
        gradient: LinearGradient(colors: <Color>[
      Color.fromRGBO(144, 12, 63, 1.0),
      Color.fromRGBO(239, 154, 154, 1.0),
    ])),
  );

  final circulo = Container(
    width: 100.0,
    height: 100.0,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: const Color.fromRGBO(255, 255, 255, 0.05)),
  );

  return Stack(
    children: <Widget>[
      fondoMorado,
      Positioned(top: 90.0, left: 30.0, child: circulo),
      Positioned(top: -40.0, right: -30.0, child: circulo),
      Positioned(bottom: -50.0, right: -10.0, child: circulo),
      Positioned(top: 90.0, left: 30.0, child: circulo),
      Positioned(top: -40.0, right: -30.0, child: circulo),
      Positioned(bottom: -50.0, right: -10.0, child: circulo),
      Positioned(top: 150.0, right: 10.0, child: circulo),
      Positioned(bottom: 120.0, right: 20.0, child: circulo),
      Positioned(bottom: -50.0, left: -20.0, child: circulo),
      Container(
        padding: const EdgeInsets.only(top: 80.0),
        child: Column(
          children: const [
            Icon(Icons.person_pin_circle, color: Colors.white, size: 100.0),
            SizedBox(
              height: 10.0,
              width: double.infinity,
            ),
            Text(
              "Iniciar Sesion",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                  fontFamily: 'Comfortaa-Bold'),
            )
          ],
        ),
      )
    ],
  );
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
          height: 170.0,
        )),
        Container(
          width: size.width * 0.85,
          margin: const EdgeInsets.symmetric(vertical: 30.0),
          padding: const EdgeInsets.symmetric(vertical: 50.0),
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
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              children: [
                _crearEmail(blocLogin),
                const SizedBox(
                  height: 40.0,
                ),
                _crearPassword(blocLogin),
                const SizedBox(
                  height: 13.0,
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
                    'olvidaste la contrasena ?', 'Comfortaa-Light', () {}),
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
            "Contrasena",
            snapshot.error?.toString(),
            Icons.password_sharp,
            validaOk(snapshot),
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
            validaOk(snapshot),
            Colors.white,
            Colors.blueAccent,
            bloc.changeEmail,
            () {},
            TextInputType.emailAddress,
            'Comfortaa-Light',
            false);
      });
}

Widget validaOk(AsyncSnapshot snaps) {
  if (snaps.hasError) {
    return const Padding(
      padding: EdgeInsetsDirectional.only(end: 12.0),
      child: Icon(Icons.report_problem_rounded, color: Colors.redAccent),
    );
  } else if (snaps.hasData) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(end: 12.0),
      child: Icon(Icons.check, color: Colors.green[700]),
    );
  } else {
    return const Padding(
      padding: EdgeInsetsDirectional.only(end: 12.0),
      child: Icon(Icons.remove_circle_outlined),
    );
  }
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
  final _pref = PreferenciasUsuario();

  if (bloc.getEmailBlog.isNotEmpty && bloc.getPasswordBlog.isNotEmpty) {
    await loginFirebase(bloc.getEmailBlog, bloc.getPasswordBlog).then((value) {
      if (value['ok'] == true) {
        _pref.token = value['token'];
        fc.showNotifyLoading(() {
          Timer.run(() {
            Navigator.pushReplacementNamed(context, 'home');
          });
        });
      } else {
        fc.showNotifyLoading(
            () => BotToast.showText(text: "Usuario o contrasena incorrecta"));
        //print(value['mensaje']);
      }
    });
  }
}

Widget _crearBotonGoogle(
    LoginBloc blocLogin, BuildContext context, LoginCRUD log) {
  return SizedBox(
    width: double.infinity,
    child: SignInButton(
      Buttons.Google,
      text: "Registrese con Google ",
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50.0),
      ),
      elevation: 5.0,
      onPressed: () {},
    ),
  );
}
