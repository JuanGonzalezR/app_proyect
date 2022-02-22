import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

  const String tituloAppBar = "Mi Aplicacion";
  const String btnIniciarSesion = "Iniciar Sesion";
  const String recordarContra = "Recordar contrase\u00F1a";
  const String tokenFirebase= 'AIzaSyBA93cHPFvu8VAyWuSaBcjW0sTkn_QOy_E';
  const Color colorSecundario = Color.fromRGBO(229, 115, 115, 1.0); 
  const Color colorPrincipal = Color.fromRGBO(239, 154, 154, 1.0);
  const Color colorBottonNav = Color.fromARGB(255, 107, 11, 46);
  const Color colorBottonNavSelec =  Color.fromARGB(255, 173, 74, 110);
  const Color colorAppBar = Color.fromRGBO(144, 12, 63, 1.0);
  const String letraUnicode = '\u00F1'; // ene
  const String createTables = 'CREATE TABLE user(usu_id INTEGER PRIMARY KEY AUTOINCREMENT,usu_nombre TEXT,usu_apellido TEXT,usu_email TEXT,usu_password TEXT,usu_fechaNacimiento TEXT,usu_genero TEXT,usu_pais TEXT,usu_fechaCreacion TEXT,usu_fechaModificacion TEXT,usu_fechaInactivacion TEXT,usu_estado TEXT)';
  
  const kSpacingUnit = 10;

  const kDarkPrimaryColor =  Color(0xFF212121);
  const kDarkSecondaryColor =  Color(0xFF373737);
  const kLightPrimaryColor =  Color(0xFFFFFFFF);
  const kLightSecondaryColor =  Color(0xFFF3F7FB);
  const kAccentColor =  Color(0xFFFFC107);

final kTitleTextStyle = TextStyle(
  fontSize: ScreenUtil().setSp(kSpacingUnit.w * 1.7),
  fontWeight: FontWeight.w600,
);

final kCaptionTextStyle = TextStyle(
  fontSize: ScreenUtil().setSp(kSpacingUnit.w * 1.3),
  fontWeight: FontWeight.w100,
);

final kButtonTextStyle = TextStyle(
  fontSize: ScreenUtil().setSp(kSpacingUnit.w * 1.5),
  fontWeight: FontWeight.w400,
  color: kDarkPrimaryColor,
);

final kDarkTheme = ThemeData(
  brightness: Brightness.dark,
  fontFamily: 'SFProText',
  primaryColor: kDarkPrimaryColor,
  canvasColor: kDarkPrimaryColor,
  backgroundColor: kDarkSecondaryColor,
  iconTheme: ThemeData.dark().iconTheme.copyWith(
        color: kLightSecondaryColor,
      ),
  textTheme: ThemeData.dark().textTheme.apply(
        fontFamily: 'SFProText',
        bodyColor: kLightSecondaryColor,
        displayColor: kLightSecondaryColor,
      ), colorScheme: ColorScheme.fromSwatch().copyWith(secondary: kAccentColor),
);

final kLightTheme = ThemeData(
  brightness: Brightness.light,
  fontFamily: 'SFProText',
  primaryColor: kLightPrimaryColor,
  canvasColor: kLightPrimaryColor,
  backgroundColor: kLightSecondaryColor,
  iconTheme: ThemeData.light().iconTheme.copyWith(
        color: kDarkSecondaryColor,
      ),
  textTheme: ThemeData.light().textTheme.apply(
        fontFamily: 'SFProText',
        bodyColor: kDarkSecondaryColor,
        displayColor: kDarkSecondaryColor,
      ), colorScheme: ColorScheme.fromSwatch().copyWith(secondary: kAccentColor),
);