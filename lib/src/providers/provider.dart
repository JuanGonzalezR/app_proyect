import 'package:app/src/blocs/forgot_pass_bloc.dart';
import 'package:app/src/blocs/register_bloc.dart';
import 'package:flutter/material.dart';

import 'package:app/src/blocs/login_bloc.dart';
export 'package:app/src/blocs/login_bloc.dart';

class Provider extends InheritedWidget {
  
  final loginBloc = LoginBloc();
  final registerBloc = RegisterBloc();
  final forgotBloc = ForgotBloc();

   Provider({Key? key, required Widget child}) : super(key: key, child: child);
   
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static LoginBloc ofLoginBloc (BuildContext context) =>(context.dependOnInheritedWidgetOfExactType<Provider>() as Provider).loginBloc;
  static RegisterBloc ofRegisterBloc (BuildContext context) =>(context.dependOnInheritedWidgetOfExactType<Provider>() as Provider).registerBloc;
  static ForgotBloc ofForgotBloc (BuildContext context) =>(context.dependOnInheritedWidgetOfExactType<Provider>() as Provider).forgotBloc;


}