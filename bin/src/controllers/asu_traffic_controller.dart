import 'dart:async';
import 'dart:io';

//build by Ivan Koop

class AsuTrafficController {

  AsuTrafficController();

  onFullData(HttpRequest request, Map<String, String> query_params) {
    print("on full data aca");

    request.response
      ..statusCode = 200
      ..write('get dentro de controller!')
      ..close();

  }
  
}