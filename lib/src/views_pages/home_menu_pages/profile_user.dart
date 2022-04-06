// ignore_for_file: avoid_print

import 'package:app/src/CRUDs/login_crud.dart';
import 'package:app/src/models/login_register_model.dart';
import 'package:app/src/utils/responsive.dart';
import 'package:app/src/views_pages/desing_pages/desings_profile_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:app/src/utils/consts_utils.dart';

class ProfileUser extends StatelessWidget {
  final user = LoginCRUD();
  ProfileUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BoxConstraints boxConstraints =
        const BoxConstraints(maxHeight: 900, maxWidth: 414);
    ScreenUtil.init(boxConstraints, context: context);

    final responsive = Responsive(context);

    final profileInfo = Expanded(
      child: SafeArea(
        child: Stack(
          children: <Widget>[
            const DesingContainerProfileUser(),
            const Positioned(
              top: 20,
              left: 10,
              child: titleProfileUser,
            ),
            Positioned(top: 130.0, right: 200.0, child: circulo),
            Positioned(top: 250.0, right: 350.0, child: circulo),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: responsive.hp(12) * 1.5),
                Container(
                  height: responsive.hp(12) * 1,
                  width: responsive.wp(12) * 2,
                  margin:
                      EdgeInsets.only(top: responsive.dp(2.5) * 1, left: 23),
                  child: Stack(
                    children: <Widget>[
                      CircleAvatar(
                        radius: responsive.dp(6),
                        backgroundImage:
                            const AssetImage('assets/images/avatar.png'),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          height: responsive.hp(4) * 1,
                          width: responsive.hp(4) * 1,
                          decoration: const BoxDecoration(
                            color: colorPrincipal,
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: Icon(
                              LineAwesomeIcons.pen,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: responsive.hp(4) * 0.5),
                Padding(
                  padding: EdgeInsets.only(left: responsive.dp(2.3)),
                  child: Text(
                    'Nicolas Adams',
                    style: TextStyle(
                        fontFamily: 'Comfortaa-Bold',
                        fontSize: responsive.dp(2.5),
                        color: Colors.white),
                  ),
                ),
                SizedBox(height: responsive.hp(5) * 0.1),
                Padding(
                  padding: EdgeInsets.only(left: responsive.dp(2.3)),
                  child: Text(
                    'nicolasadams@gmail.com',
                    style: TextStyle(
                        fontFamily: 'Comfortaa-Light',
                        fontSize: responsive.dp(1.4),
                        color: Colors.white),
                  ),
                ),
              ],
            ),
            const Positioned(
                top: 71.0,
                left: 215.0,
                child: CircleInfoUser(
                  data: '0',
                  text: 'Amigos(a)',
                  icon: LineAwesomeIcons.user_friends,
                )),
            const Positioned(
                top: 185.0,
                left: 260.0,
                child: CircleInfoUser(
                  data: '0',
                  text: 'Pendientes',
                  icon: LineAwesomeIcons.clock,
                )),
            const Positioned(
                top: 310.0,
                left: 215.0,
                child: CircleInfoUser(
                  data: '0',
                  text: 'Activos',
                  icon: LineAwesomeIcons.check_circle,
                )),
          ],
        ),
      ),
    );

    final header = Row(
      children: <Widget>[
        profileInfo,
      ],
    );

    return Builder(
      builder: (context) {
        return Scaffold(
          body: Container(
            //Color de la pantalla
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: <Color>[
                  Color.fromARGB(255, 110, 0, 42),
                  Color.fromARGB(255, 110, 0, 42),
                  Color.fromARGB(255, 255, 255, 255),
                ],
                    begin: FractionalOffset.topCenter,
                    end: FractionalOffset.bottomCenter)),
            child: Column(
              children: <Widget>[
                header,
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.only(top: 1, bottom: 5),
                    children: [_myInfoUser(), _cardViewConfig()],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  _myInfoUser() {
    return FutureBuilder(
      future: user.loadUser(1),
      builder: (_,AsyncSnapshot<LoginRegisterModel> snapshot){
        if (snapshot.hasData) {
          final datos = snapshot.data;
          return _cardViewInfo(datos!);
        }
        return const Center(child: CircularProgressIndicator(strokeWidth: 1,));
      }
      );
  }

  Widget _cardViewInfo(LoginRegisterModel datos) {
    return ExpansionCard(
      title: Container(
        padding: const EdgeInsets.only(top: 5, bottom: 5),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20)),
            color: colorBottonNav),
        child: Column(
          children: const [
            Text(
              "Informacion",
              style: TextStyle(
                fontFamily: 'omfortaa-Bold',
                fontSize: 25,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
            Text(
              "personal",
              style: TextStyle(
                  fontFamily: 'Comfortaa-Light',
                  fontSize: 17,
                  color: Color.fromARGB(255, 255, 255, 255)),
            ),
          ],
        ),
      ),
      children: <Widget>[
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.only(right: 55.0, left: 17.0),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
              color: colorBottonNav),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Nombre: ${datos.nombre}',
                      style: const TextStyle(fontSize: 12,color: Colors.white)),
              Text('Apellidos: ${datos.apellido}',
                      style: const TextStyle(fontSize: 12,color: Colors.white)),
              Text('Email: ${datos.email}',
                      style: const TextStyle(fontSize: 12,color: Colors.white)),
              Text('Pais: ${datos.pais}',
                      style: const TextStyle(fontSize: 12,color: Colors.white)),
              Text('Genero: ${datos.genero}',
                      style: const TextStyle(fontSize: 12,color: Colors.white)),
            ],
          )
        )
      ],
    );
  }

  Widget _cardViewConfig() {
    return ExpansionCard(
      title: Container(
        padding: const EdgeInsets.only(top: 5, bottom: 5),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20)),
            color: colorBottonNav),
        child: Column(
          children: const [
            Text(
              "Opciones",
              style: TextStyle(
                fontFamily: 'omfortaa-Bold',
                fontSize: 25,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
            Text(
              "de usuario",
              style: TextStyle(
                  fontFamily: 'Comfortaa-Light',
                  fontSize: 17,
                  color: Color.fromARGB(255, 255, 255, 255)),
            ),
          ],
        ),
      ),
      children: <Widget>[
        Container(
          alignment: Alignment.topLeft,
          margin: const EdgeInsets.only(right: 55.0, left: 17.0),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
              color: colorBottonNav),
          child: Container(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                        child: ButtonProfile(
                      onPressed: () {},
                      title: 'Actualizar datos',
                      icon: LineAwesomeIcons.user_edit,
                    ))
                  ],
                ),
                const Divider(
                  thickness: 2,
                ),
                Row(
                  children: [
                    Expanded(
                        child: ButtonProfile(
                      onPressed: () {},
                      title: 'Cerrar Sesion',
                      icon: LineAwesomeIcons.arrow_circle_right,
                    ))
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
