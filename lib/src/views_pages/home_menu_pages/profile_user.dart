import 'package:app/src/views_pages/desing_pages/desings_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:app/src/utils/consts_utils.dart';

class ProfileUser extends StatelessWidget {
  const ProfileUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BoxConstraints boxConstraints =
        const BoxConstraints(maxHeight: 900, maxWidth: 414);
    ScreenUtil.init(boxConstraints, context: context);
    final size = MediaQuery.of(context).size;
    double x = 0.4;
    double y = 0.2;
    double z = 0.4;

    final _container = Container(
          transform: Matrix4(
            1,
            0,
            0,
            0,
            0,
            1,
            0,
            0,
            0,
            0,
            1,
            0,
            0,
            0,
            0,
            1,
          )
            ..rotateX(x)
            ..rotateY(y)
            ..rotateZ(z),
          height: size.height * 0.4,
          width: double.infinity,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(100),
                  topRight: Radius.circular(100)),
              gradient: LinearGradient(colors: <Color>[
                Color.fromARGB(255, 104, 0, 40),
                Color.fromARGB(255, 197, 100, 100),
              ])),
        );

    final fondo = Column(
      children: [
        _container,
        const SizedBox(height: 90,)
      ],
    );

    final circulo = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color: const Color.fromARGB(28, 255, 255, 255)),
    );

    final _infoUser = Container(
      width: kSpacingUnit.w * 10,
      height: kSpacingUnit.w * 10,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.0),
          color: const Color.fromARGB(255, 110, 0, 42)
          ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: const [
            Icon(LineAwesomeIcons.person_entering_booth,color: Colors.white70,),
            Divider(
              thickness: 1,
              color: Color.fromARGB(66, 255, 255, 255),
            ),
            Text('0', style: TextStyle(color: Colors.white70)),
            Divider(
              thickness: 1,
              color: Color.fromARGB(66, 255, 255, 255),
            ),
            Text('Amigo(s)', style: TextStyle(color: Colors.white70))
          ],
        ),
      ),
    );

    final profileInfo = Expanded(
      child: Stack(
        children: <Widget>[
          fondo,
          Positioned(top: 130.0, right: 200.0, child: circulo),
          Positioned(top: 250.0, right: 350.0, child: circulo),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: kSpacingUnit.w * 7),
              Container(
                height: kSpacingUnit.w * 10,
                width: kSpacingUnit.w * 10,
                margin: EdgeInsets.only(top: kSpacingUnit.w * 1, left: 20),
                child: Stack(
                  children: <Widget>[
                    CircleAvatar(
                      radius: kSpacingUnit.w * 5,
                      backgroundImage:
                          const AssetImage('assets/images/avatar.png'),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        height: kSpacingUnit.w * 2.5,
                        width: kSpacingUnit.w * 2.5,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          heightFactor: kSpacingUnit.w * 1.5,
                          widthFactor: kSpacingUnit.w * 1.5,
                          child: Icon(
                            LineAwesomeIcons.pen,
                            color: kDarkPrimaryColor,
                            size: ScreenUtil().setSp(kSpacingUnit.w * 1.5),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: kSpacingUnit.w * 2),
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  'Nicolas Adams',
                  style: TextStyle(
                      fontFamily: 'Comfortaa-Bold',
                      fontSize: 25.0,
                      color: Colors.white),
                ),
              ),
              SizedBox(height: kSpacingUnit.w * 0.5),
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  'nicolasadams@gmail.com',
                  style: TextStyle(
                      fontFamily: 'Comfortaa-Light',
                      fontSize: 15.0,
                      color: Colors.white),
                ),
              ),
              SizedBox(height: kSpacingUnit.w * 3),
              const SizedBox(
                width: 20.0,
              ),
                               
            ],
          ),
          Positioned(top: 65.0, right: 70.0, child: _infoUser), 
          Positioned(top: 175.0, right: 15.0, child: _infoUser), 
          Positioned(top: 280.0, right: 70.0, child: _infoUser), 
        ],
        
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
              gradient: LinearGradient(colors: <Color>[
                Color.fromARGB(255, 110, 0, 42),
                Color.fromARGB(255, 110, 0, 42),
                Color.fromARGB(255, 255, 255, 255),
              ],
            begin: FractionalOffset.topCenter,
            end: FractionalOffset.bottomCenter
          )
            ),
            child: Column(
              children: <Widget>[
                header,
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20.0),
                    children: [
                      _cardView1(),
                    ],
                  ),
                )
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            elevation: 0,
            child: const Icon(
              LineAwesomeIcons.power_off,
              color: Colors.white,
            ),
            backgroundColor: colorSecundario,
          ),
        );
      },
    );
  }

  Widget _cardView1() {
    return ExpansionCard(
      gif: 'assets/images/uno.jpg',
      title: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: colorBottonNav),
        child: Column(
          children: const [
            Text(
              "Informacion",
              style: TextStyle(
                fontFamily: 'Comfortaa',
                fontSize: 30,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
            Text(
              "Sub",
              style: TextStyle(
                  fontFamily: 'Comfortaa', fontSize: 20, color: Color.fromARGB(255, 255, 255, 255)),
            ),
          ],
        ),
      ),
      children: <Widget>[
        Container(
          alignment: Alignment.topLeft,
          margin: const EdgeInsets.only(right: 20.0, left: 10.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color.fromARGB(246, 255, 255, 255)),
          child: Column(
            children: const [
              Text('Mi primera lineaa'),
              Text('Mi segunada lineaa'),
              Text('Mi tercera lineaa'),
              Text('Mi cuarta lineaa'),
            ],
          ),
        )
      ],
    );
  }
}
