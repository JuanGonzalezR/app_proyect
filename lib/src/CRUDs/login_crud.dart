import 'package:flutter/material.dart';
import 'package:app/src/models/login_register_model.dart';
import 'package:app/src/services/db_helper.dart';
import 'package:sqflite/sqflite.dart';
export 'package:app/src/CRUDs/login_crud.dart';


class LoginCRUD extends ChangeNotifier{
  final dbase = DBHelper();
  
  // Estas funciones se encargan se insertar el usuario en la base de datos movil
  Future<void> insertUser(LoginRegisterModel loginModel) async {
  final Database? db = await dbase.database;
  await db!.insert(
    'user', 
    loginModel.toJsonUser(),
    conflictAlgorithm: ConflictAlgorithm.replace
    );
  }
  insertNewUser(LoginRegisterModel loginRegisterModel) async {
    await insertUser(
      loginRegisterModel
    );
  } 
  //Fin insert de usuario----------------------------------------------------------------

  Future<void> updateUser (LoginRegisterModel loginModel) async{
    final Database? db = await dbase.database;
    await db!.update(
      'user', 
      loginModel.toJsonUser(),
      where: "usu_id = ?",
      whereArgs: [loginModel.id]
      );
      notifyListeners();
  }

  Future<void> deleteUser(int id) async{
    final Database? db=await dbase.database;
    await db!.delete(
      'user',
      where: "id = ?",
      whereArgs: [id]
    );
  }

//Estas funciones se encargan de obtener los usuarios en la base de datos y mostrarlos en una tarjeta
Future<List<LoginRegisterModel>> loadUsers(int i) async {
  final Database? db = await dbase.database;
  final List<Map<String,dynamic>> maps = await db!.query('user', where: 'usu_id = ?', whereArgs:[i], limit: 1);
  return List.generate(maps.length, (i){
      return LoginRegisterModel(
        id      : maps[i]['usu_id'],
        nombre  : maps[i]['usu_nombre'],
        apellido: maps[i]['usu_apellido'],
        email   : maps[i]['usu_email'],
        fechaNacimiento: maps[i]['usu_fechaNacimiento'], 
        genero: maps[i]['usu_genero'], 
        pais: maps[i]['usu_pais'], 
      );
    }
  );
}

Future<LoginRegisterModel> loadUser(int i) async {
  final Database? db = await dbase.database;
  final List<Map<String,dynamic>> maps = await db!.query('user', where: 'usu_id = ?', whereArgs:[i], limit: 1);
  
  if (maps.isNotEmpty) {
    return LoginRegisterModel.fromJson(maps.first);
  }else{
    throw Exception("Not found");
  }
}

Container buildItem (LoginRegisterModel login){
  return Container(
      height: 150.0,
      margin: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 5.0),
      child: Stack(
        children: [
          card(login)
        ],
      ),
    );
}
GestureDetector card(LoginRegisterModel login) {
    return GestureDetector(
      child: Container(
        height: 124.0,
        decoration: BoxDecoration(
          color: const Color(0xFF333366),
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.black38,
              blurRadius: 5.0,
              offset: Offset(0.0,5.0)
            )
          ]
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Text('${login.id}',style: const TextStyle(fontSize: 24,color: Colors.white,)),
                  Container(margin: const EdgeInsets.only(left: 10.0),),
                  Text('${login.nombre}',style: const TextStyle(fontSize: 24,color: Colors.white,)),
                  Container(margin: const EdgeInsets.only(left: 5.0),),
                  Text('${login.apellido}',style: const TextStyle(fontSize: 24,color: Colors.white)),
                    ],
                  ),
                  
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${login.email}',style: const TextStyle(fontSize: 14,color: Colors.white,)),
                      Container(margin: const EdgeInsets.only(bottom: 5.0),),
                      Text('${login.fechaNacimiento}',style: const TextStyle(fontSize: 14,color: Colors.white,)),
                      Container(margin: const EdgeInsets.only(bottom: 5.0),),
                      Text('${login.genero}',style: const TextStyle(fontSize: 14,color: Colors.white)),
                      Container(margin: const EdgeInsets.only(bottom: 5.0),),
                      Text('${login.pais}',style: const TextStyle(fontSize: 14,color: Colors.white)),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
//Fin obtener usuarios SQFlite---------------------------------------------------------------------

}