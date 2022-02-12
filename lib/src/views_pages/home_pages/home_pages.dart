import 'package:app/src/models/login_register_model.dart';
import 'package:flutter/material.dart';
import 'package:app/src/CRUDs/login_crud.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
 }
class _HomePageState extends State<HomePage> {

  final login = LoginCRUD();
  Widget _users= const SizedBox();
  final user = LoginRegisterModel(
    id                : 1,
      nombre          : 'Juan',
      apellido        : 'Actualizado',
      email           : 'jp@gmail.com',
      password        : 'assasasas',
      fechaNacimiento : '12/12/2022',
      genero          : 'Masculino',
      pais            : 'Colombia',
      fechaCreacion   : '12/12/2022',
      fechaModificacion : '12/12/2022',
      fechaInactivacion : '12/12/2022',
      estado            : 'A',
    );

  _HomePageState(){
    //userList("");
  }

  @override
  Widget build(BuildContext context) {
    
   return Scaffold(
     appBar: AppBar(title: const Text('Home Page')),
     body: ListView(
       children: [
         _users
       ],
     ),
   );
  }

  Future userList (String search) async {
    List<LoginRegisterModel> listaUser= await login.loadUsers(4);
    setState((){
      if (listaUser.isNotEmpty) {
        if (search == "") {
          _users = Column(
            children: listaUser.map((e) => login.buildItem(e)).toList()
          );
        }
      } else {
      }
    });
  }
}