// ignore_for_file: avoid_print

import 'package:app/src/utils/other_widgets.dart';
import 'package:flutter/material.dart';
import 'package:app/src/utils/functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app/src/models/login_register_model.dart';
import 'package:app/src/utils/auth_firebase.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:app/src/blocs/register_bloc.dart';
import 'package:app/src/CRUDs/login_crud.dart';
import 'package:app/src/providers/provider.dart';
import 'package:app/src/views_pages/desing_pages/desings_login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:app/src/utils/consts_utils.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final RegisterBloc _bloc = RegisterBloc();

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final other = OthersWidget();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrate ahora'),
        backgroundColor: colorAppBar,
      ),
      body: Stack(
        children: [other.crearFondo(context), _loginForm(context)],
      ),
    );
  }

  Widget _loginForm(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final blocRegister = Provider.ofRegisterBloc(context);
    final log = LoginCRUD();

    return SingleChildScrollView(
      child: Column(
        children: [
          SafeArea(
              child: Container(
            height: 10.0,
          )),
          Container(
            width: size.width * 0.90,
            margin: const EdgeInsets.symmetric(vertical: 15.0),
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30.0),
                boxShadow: const <BoxShadow>[
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 3.0,
                      offset: Offset(0.0, 5.0),
                      spreadRadius: 3.0)
                ]),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  const Text(
                    'Estas a un solo paso',
                    style: TextStyle(
                        fontSize: 20.0, fontFamily: 'Comfortaa-Light'),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  _crearName(blocRegister),
                  const SizedBox(
                    height: 30.0,
                  ),
                  _crearLastName(blocRegister),
                  const SizedBox(
                    height: 30.0,
                  ),
                  _crearEmail(blocRegister),
                  const SizedBox(
                    height: 30.0,
                  ),
                  _crearFechaNacimiento(blocRegister),
                  const SizedBox(
                    height: 30.0,
                  ),
                  const DesingRadioButton(),
                  const SizedBox(
                    height: 30.0,
                  ),
                  const DesingDropdown(),
                  const SizedBox(
                    height: 30.0,
                  ),
                  _crearPassword(blocRegister),
                  const SizedBox(
                    height: 30.0,
                  ),
                  _crearRepeatPassword(blocRegister),
                  const SizedBox(
                    height: 40.0,
                  ),
                  _crearBoton(blocRegister, context, log)
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 70.0,
          )
        ],
      ),
    );
  }

  Widget _crearName(RegisterBloc bloc) {
    return StreamBuilder(
        stream: bloc.nameStreamReg,
        builder: (context, snapshot) {
          return DesingTextField(
              'example',
              'Nombre',
              snapshot.error?.toString(),
              FontAwesomeIcons.userCircle,
              ValidaEstadoBloc(snaps: snapshot),
              Colors.white,
              Colors.blueAccent,
              bloc.changeNameReg,
              () {}, //OnTap
              TextInputType.text,
              'Comfortaa-Light',
              false);
        });
  }

  Widget _crearLastName(RegisterBloc bloc) {
    return StreamBuilder(
        stream: bloc.lastnameStreamReg,
        builder: (context, snapshot) {
          return DesingTextField(
              'example',
              'Apellido',
              snapshot.error?.toString(),
              Icons.person_outline_outlined,
              ValidaEstadoBloc(snaps: snapshot),
              Colors.white,
              Colors.blueAccent,
              bloc.changeLastNameReg,
              () {}, //OnTap
              TextInputType.text,
              'Comfortaa-Light',
              false);
        });
  }

  Widget _crearEmail(RegisterBloc bloc) {
    return StreamBuilder(
        stream: bloc.emailStreamReg,
        builder: (context, snapshot) {
          return DesingTextField(
              'user@example.com',
              'Email',
              snapshot.error?.toString(),
              FontAwesomeIcons.at,
              ValidaEstadoBloc(snaps: snapshot),
              Colors.white,
              Colors.blueAccent,
              bloc.changeEmailReg,
              () {},
              TextInputType.emailAddress,
              'Comfortaa-Light',
              false);
        });
  }

  Widget _crearFechaNacimiento(RegisterBloc bloc) {
    return StreamBuilder<String>(
        stream: bloc.fechanacimientoStreamReg,
        builder: (context, snapshot) {
          return DesingDatepicker(
            'Fecha de nacimiento',
            'Fecha de nacimiento',
            Icons.date_range_outlined,
            ValidaEstadoBloc(snaps: snapshot),
            Colors.white,
            Colors.blueAccent,
            bloc.changeFechaNacimientoReg,
            () {},
            TextInputType.datetime,
            'Comfortaa-Light',
          );
        });
  }

  Widget _crearRepeatPassword(RegisterBloc bloc) {
    return StreamBuilder<String>(
        stream: bloc.repeatpasswordStreamReg,
        builder: (context, snapshot) {
          return DesingTextField(
              '*******',
              'Repetir Contrase\u00F1a',
              snapshot.error?.toString(),
              Icons.password_sharp,
              ValidaEstadoBloc(snaps: snapshot),
              Colors.white,
              Colors.blueAccent,
              bloc.changeRepeatPassReg,
              () {},
              TextInputType.visiblePassword,
              'Comfortaa-Light',
              true);
        });
  }

  Widget _crearPassword(RegisterBloc bloc) {
    return StreamBuilder<String>(
        stream: bloc.passwordStreamReg,
        builder: (context, snapshot) {
          return DesingTextField(
              '*******',
              'Contrase\u00F1a',
              snapshot.error?.toString(),
              Icons.admin_panel_settings_rounded,
              ValidaEstadoBloc(snaps: snapshot),
              Colors.white,
              Colors.blueAccent,
              bloc.changePasswordReg,
              () {},
              TextInputType.visiblePassword,
              'Comfortaa-Light',
              true);
        });
  }

  Widget _crearBoton(RegisterBloc bloc, BuildContext context, LoginCRUD log) {
    return StreamBuilder(
        stream: bloc.submitValidReg,
        builder: (context, snapshot) {
          return DesingButtonElevation(
              snapshot.hasData
                  ? () => __botonRegistrar(context, bloc, log)
                  : null,
              'Registrar',
              'Comfortaa-Bold',
              20.0,
              10.0);
        });
  }

  __botonRegistrar(
      BuildContext context, RegisterBloc bloc, LoginCRUD createUser) async {
    String fechaToday = FuncionesUtils().selectDateNow(context);
    final buscaDocumento =
        await firestore.collection('users').doc(bloc.getEmailBlocReg).get();

    if (bloc.getPasswordBlocReg == bloc.getRepeatPassBlocReg) {
      // Modelo de datos para insertar usuario en firebase
      final user = LoginRegisterModel(
        nombre: bloc.getNameBlocReg,
        apellido: bloc.getLastNameBlocReg,
        email: bloc.getEmailBlocReg,
        password: bloc.getPasswordBlocReg,
        fechaNacimiento: bloc.getFechaNacimientoBlocReg,
        genero: bloc.getGenderBlocReg,
        pais: bloc.getCountryBlocReg,
        fechaCreacion: fechaToday,
        fechaModificacion: fechaToday,
        fechaInactivacion: '99/99/9999',
        estado: 'A',
      );

      if (!buscaDocumento.exists) {
        await firestore.collection('users').doc(bloc.getEmailBlocReg).set({
          'usu_id': '1',
          'usu_nombre': bloc.getLastNameBlocReg,
          'usu_apellido': bloc.getEmailBlocReg,
          'usu_email': bloc.getEmailBlocReg,
          'usu_password': bloc.getPasswordBlocReg,
          'usu_fechaNacimiento': bloc.getFechaNacimientoBlocReg,
          'usu_genero': bloc.getGenderBlocReg,
          'usu_pais': bloc.getCountryBlocReg,
          'usu_fechaCreacion': fechaToday,
          'usu_fechaModificacion': fechaToday,
          'usu_fechaInactivacion': '99/99/9999',
          'usu_estado': 'A',
        }).then((_) {
          FuncionesUtils().showNotifyLoading(() async {
            
            // Validacion si se esta registardo por Google para agregar las credenciales
            await createUserWithEmailAndPassword(
                    bloc.getEmailBlocReg, bloc.getPasswordBlocReg)
                .then((value) =>
                    print('CreateUserFirebaseOk ' + value.toString()))
                .catchError((error) =>
                    print('CreateUserFirebaseError ' + error.toString()));

            // Se guarda el usuario en sqflite
            await createUser
                .insertUser(user)
                .then((value) => print('CreateUserSqfliteOk'))
                .catchError((error) =>
                    print('CreateUserSqfliteError ' + error.toString()));


            BotToast.showText(text: 'Usuario creado con exito');

            Navigator.pop(context);
          });
        }).catchError((error) {
          FuncionesUtils().showNotifyLoading(() {
            BotToast.showText(text: 'Se presento un error al crear usuario');
          });
        });
      } else {
        BotToast.showText(text: 'El correo ya se encuentra registrado');
      }
    } else {
      BotToast.showText(text: 'Las contrase\u00F1as no coinciden');
    }
  }
}
