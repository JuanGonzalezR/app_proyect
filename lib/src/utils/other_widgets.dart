import 'package:flutter/material.dart';
class OthersWidget {
  
  Widget crearFondo(BuildContext context) {
  final size = MediaQuery.of(context).size;
  final fondoMorado = Container(
    height: size.height * 1,
    width: double.infinity,
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          Color.fromRGBO(144, 12, 63, 1.0),
          Color.fromRGBO(239, 154, 154, 1.0),
        ]
      )
    ),
  );

  final circulo = Container(
    width: 100.0,
    height: 100.0,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(100.0),
      color: const Color.fromRGBO(255, 255, 255, 0.05)
    ),
  );

  return Stack(
    children: <Widget> [
      fondoMorado,
      Positioned(top: 90.0,left: 30.0,child: circulo),
      Positioned(top: -40.0,right: -30.0,child: circulo),
      Positioned(bottom: -50.0,right: -10.0,child: circulo),
      Positioned(bottom: 120.0,right: 20.0,child: circulo),
      Positioned(bottom: -50.0,left: -20.0,child: circulo),
    ],
  );
}

}
