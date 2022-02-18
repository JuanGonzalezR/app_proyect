import 'package:app/src/utils/pref_users.dart';
import 'package:flutter/material.dart';
import 'package:app/src/utils/consts_utils.dart' as cons;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
 }
class _HomePageState extends State<HomePage> {
  final _pref = PreferenciasUsuario();

  @override
  void initState() {
    print(_pref.token);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance
        ?.addPostFrameCallback((_) => setState(() {}));
   return Scaffold(
     appBar: AppBar(title: const Text('Home Page'),backgroundColor: cons.constante.colorAppBar,),
     body: Container()
   );
  }

}