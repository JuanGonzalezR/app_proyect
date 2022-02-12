import 'dart:convert';

LoginRegisterModel loginRegisterFromJson(String str) => LoginRegisterModel.fromJson(json.decode(str));
String loginRegisterToJson(LoginRegisterModel data) => json.encode(data.toJsonUser());

class LoginRegisterModel {
    LoginRegisterModel({
        this.id,
        this.nombre,
        this.apellido,
        this.email,
        this.password,
        this.fechaNacimiento,
        this.genero,
        this.pais,
        this.fechaCreacion,
        this.fechaModificacion,
        this.fechaInactivacion,
        this.estado,
    });

    int ?id;
    String ?nombre;
    String ?apellido;
    String ?email;
    String ?password;
    String ?fechaNacimiento;
    String ?genero;
    String ?pais;
    String ?fechaCreacion;
    String ?fechaModificacion;
    String ?fechaInactivacion;
    String ?estado;

    factory LoginRegisterModel.fromJson(Map<String, dynamic> json) => LoginRegisterModel(
        id: json["usu_id"],
        nombre: json["usu_nombre"],
        apellido: json["usu_apellido"],
        email: json["usu_email"],
        password: json["usu_password"],
        fechaNacimiento: json["usu_fechaNacimiento"],
        genero: json["usu_genero"],
        pais: json["usu_pais"],
        fechaCreacion: json["usu_fechaCreacion"],
        fechaModificacion: json["usu_fechaModificacion"],
        fechaInactivacion: json["usu_fechaInactivacion"],
        estado: json["usu_estado"],
    );

    Map<String, dynamic> toJsonUser() => {
        "usu_id": id,
        "usu_nombre": nombre,
        "usu_apellido": apellido,
        "usu_email": email,
        "usu_password": password,
        "usu_fechaNacimiento": fechaNacimiento,
        "usu_genero": genero,
        "usu_pais": pais,
        "usu_fechaCreacion": fechaCreacion,
        "usu_fechaModificacion": fechaModificacion,
        "usu_fechaInactivacion": fechaInactivacion,
        "usu_estado": estado,
    };
}
