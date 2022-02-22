import 'package:app/src/blocs/forgot_pass_bloc.dart';
import 'package:app/src/providers/provider.dart';
import 'package:app/src/utils/auth_firebase.dart';
import 'package:app/src/views_pages/desing_pages/desings_login.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:app/src/utils/functions.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';



class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _bloc = ForgotBloc();
  String valida = 'NO';
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [crearFondoForgot(context), _loginForm(context)],
    ));
  }

  Widget _loginForm(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final blocForgot = Provider.ofForgotBloc(context);
    final fc = FuncionesUtils();
    //final _prefs = PreferenciasUsuario();

    return SingleChildScrollView(
      child: Column(
        children: [
          SafeArea(
              child: Container(
            height: 200.0,
          )),
          Container(
            width: size.width * 0.9,
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
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                children: [
                  _encabezado(),
                  const SizedBox(
                    height: 40.0,
                  ),
                  _crearEmail(blocForgot),
                  const SizedBox(
                    height: 20.0,
                  ),                  
                  valida == 'SI' ? _crearNewPass(blocForgot) : Container(),
                  const SizedBox(
                    height: 50.0,
                  ),
                  _crearBoton(blocForgot, context, fc),
                  const SizedBox(
                    height: 10.0,
                  ),
                  _crearBotonClose(context)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _crearEmail(ForgotBloc blocForgot) {
    return StreamBuilder(
      stream: blocForgot.emailForgotStream,
      builder: (context, snapshot) {
        return DesingTextField(
            "user@example.com",
            "Email",
            snapshot.error?.toString(),
            FontAwesomeIcons.at,
            ValidaEstadoBloc(snaps: snapshot),
            Colors.white,
            Colors.blueAccent,
            blocForgot.changeEmailForgot,
            () {},
            TextInputType.emailAddress,
            'Comfortaa-Light',
            false);
      },
    );
  }

  Widget _crearNewPass(ForgotBloc blocForgot) {
    return StreamBuilder(
      stream: blocForgot.passwordForgotStream,
      builder: (context, snapshot) {
        return DesingTextField(
            "*********",
            "Nueva contrase\u00F1a",
            snapshot.error?.toString(),
            FontAwesomeIcons.lock,
            ValidaEstadoBloc(snaps: snapshot),
            Colors.white,
            Colors.blueAccent,
            blocForgot.changePasswordForgot,
            () {},
            TextInputType.emailAddress,
            'Comfortaa-Light',
            true);
      },
    );
  }

  Widget _encabezado() {
    return Column(
      children: const [
        Text(
          'A tu correo llegara una nueva contrase\u00F1a.',
          style: TextStyle(fontSize: 15.0),
        )
      ],
    );
  }

  Widget _crearBoton(
      ForgotBloc blocForgot, BuildContext context, FuncionesUtils fc) {
    return StreamBuilder(
        stream: blocForgot.submitValidForgot,
        builder: (context, snapshot) {
          return DesingButtonElevation(
            () => _botonLogin(context, blocForgot, fc),
              "Enviar",
              'Comfortaa-Bold',
              20.0,
              10.0);
        });
  }

  Widget _crearBotonClose(BuildContext context) {
    return DesingButtonElevation(
        () => Navigator.pop(context), "Salir", 'Comfortaa-Bold', 20.0, 10.0);
  }

  _botonLogin(BuildContext context, ForgotBloc blocForgot, FuncionesUtils fc) async {

    if (blocForgot.getEmailFotgotBloc.isNotEmpty) {
      FuncionesUtils().showNotifyLoading(() async {
            await changePassword(blocForgot.getEmailFotgotBloc);
            await auth.currentUser?.reload();
            valida = 'SI';
          });
    }else{
      BotToast.showText(text: "Ingresa tu correo electronico",duration: const Duration(seconds: 4));

    }
    
  }
}
