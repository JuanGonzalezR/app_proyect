import 'package:flutter/material.dart';
import 'package:app/src/utils/consts_utils.dart' as cons;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
 }
class _HomePageState extends State<HomePage> {

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