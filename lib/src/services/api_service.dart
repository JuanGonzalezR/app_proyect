import 'dart:convert';

import 'package:http/http.dart' as http;

import 'ent_api.dart';

String _key = '97dcfdfae9ccd3d1c8e672543e2eb27672f7f7fe';
String _url = 'https://api.nomics.com/v1/currencies/ticker?key=$_key&ids=BTC,ETH,XRP&interval=1d,30d&convert=EUR&platform-currency=ETH&per-page=100&page=1';


  Future<List<EntLogin>> getInfo() async {
    List<EntLogin> list = [];
    Uri uri = Uri.parse(_url);
    var response = await http.get(uri);

    print("This is uri: $uri");
    print("This is bodyBytes: ${response.statusCode}");

    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final rps = entLoginFromJson(body);

      for (var val in rps) {
        list.add(val);
      }
      print(list.isEmpty);
      return list;
    }

    return list;


  }

