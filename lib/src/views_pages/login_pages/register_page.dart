import 'package:flutter/material.dart';
import 'package:app/src/blocs/register_bloc.dart';
import 'package:app/src/views_pages/login_pages/login_pages.dart';
import 'package:app/src/views_pages/login_pages/other_widgets.dart';
import 'package:app/src/CRUDs/login_crud.dart';
import 'package:app/src/providers/provider.dart';
import 'package:app/src/views_pages/desing_pages/material_desing_pages.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final other = OthersWidget();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Registrate ahora"),
        backgroundColor: const Color.fromRGBO(144, 12, 63, 1.0),
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
              "example",
              "Nombre",
              snapshot.error?.toString(),
              FontAwesomeIcons.userCircle,
              validaOk(snapshot),
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
              "example",
              "Apellido",
              snapshot.error?.toString(),
              Icons.person_outline_outlined,
              validaOk(snapshot),
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
              "user@example.com",
              "Email",
              snapshot.error?.toString(),
              FontAwesomeIcons.at,
              validaOk(snapshot),
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
            "Fecha de nacimiento",
            "Fecha de nacimiento",
            Icons.date_range_outlined,
            validaOk(snapshot),
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
              "*******",
              "Repetir Contrasena",
              snapshot.error?.toString(),
              Icons.password_sharp,
              validaOk(snapshot),
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
              "*******",
              "Contrasena",
              snapshot.error?.toString(),
              Icons.admin_panel_settings_rounded,
              validaOk(snapshot),
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
          return DesingButtonElevation(() => __botonRegistrar(context,bloc),
              "Registrar", 'Comfortaa-Bold', 20.0, 10.0);
        });
  }

  __botonRegistrar(BuildContext context, RegisterBloc bloc) {
    Future<Map<String, dynamic>> datos = bloc.newUserFirebase('juang@gmail.com', 'juapa1234*');
    datos.then((value) => print(value['mensaje']));
    //print(utl.FuncionesUtils().selectDateNow(context));
  }
}
