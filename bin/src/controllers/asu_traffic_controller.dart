import 'dart:async';
import 'dart:io';
import 'package:sqljocky/sqljocky.dart';

//build by Ivan Koop

class AsuTrafficController {

  static void onFullData(HttpRequest request, Map<String, String> query_params, ConnectionPool db_pool) {
    
    request.response
      ..statusCode = 200
      ..write('get dentro de controller!')
      ..close();
  }

}