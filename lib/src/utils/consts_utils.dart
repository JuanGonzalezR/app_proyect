class _Constantes {
  final String tituloAppBar = "Mi Aplicacion";
  final String btnIniciarSesion = "Iniciar Sesion";
  final String recordarContra = "Recordar contrasena";
  final String createTables = 'CREATE TABLE user(usu_id INTEGER PRIMARY KEY AUTOINCREMENT,usu_nombre TEXT,usu_apellido TEXT,usu_email TEXT,usu_password TEXT,usu_fechaNacimiento TEXT,usu_genero TEXT,usu_pais TEXT,usu_fechaCreacion TEXT,usu_fechaModificacion TEXT,usu_fechaInactivacion TEXT,usu_estado TEXT)';

  _Constantes();
}

_Constantes constante = _Constantes();