import 'dart:async';

class Validators{

  var validaEmail=StreamTransformer<String,String>.fromHandlers(
    handleData: (String email,EventSink<String> sink)
    {
    Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern.toString());
    if(regExp.hasMatch(email)){
      sink.add(email);
    }else{
      sink.addError("Email invalido");
    }
  });

  var validaPassword=StreamTransformer<String,String>.fromHandlers(
    handleData: (String password,EventSink<String> sink)
    {
    String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = RegExp(pattern);
    if(regExp.hasMatch(password)){
      sink.add(password);
    }else{
      sink.addError('Contrasena incorrecta');
    }
  });

  var validaPasswordRegister=StreamTransformer<String,String>.fromHandlers(
    handleData: (String password,EventSink<String> sink)
    {
    String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*.~]).{8,}$';
    RegExp regExp = RegExp(pattern);
    if(regExp.hasMatch(password)){
      sink.add(password);
    }else{
      sink.addError('''Debe contener mayuscula, 
minusculas, numeros y caracter''');
    }
  });

  var validaUserNames=StreamTransformer<String,String>.fromHandlers(
    handleData: (String names,EventSink<String> sink)
    {
    if(names.length < 35){
      sink.add(names);
    }else{
      sink.addError("Demasiado extenso");
    }
  });

  var validaCountry=StreamTransformer<String,String>.fromHandlers(
    handleData: (String country,EventSink<String> sink)
    {
    if(country.isNotEmpty){
      sink.add(country);
    }else{
      sink.add('Seleccionar pais');
    }
  });

  var validaGender=StreamTransformer<String,String>.fromHandlers(
    handleData: (String gender,EventSink<String> sink)
    {
    String valor = gender.substring(17);
    if(gender.isNotEmpty){
      sink.add(valor);
    }else{
      sink.add('masculino');
    }
  });

}