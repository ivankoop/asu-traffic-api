import 'package:asu_traffic_api/asu_traffic_api.dart' as asu_traffic_api;
import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'src/controllers/asu_traffic_controller.dart';

//build by Ivan Koop

const String api_v = "/api/v1/";
AsuTrafficController controller;

Future main() async {

  controller = new AsuTrafficController();

  var server = await HttpServer.bind(
    "127.0.0.1",
    4040,
  );

  print('Listening on localhost:${server.port}');

  await for (var request in server) {
    handleRequest(request);
  }

}

void handleRequest(HttpRequest request) {
  try {
    
    //TODO: implement PUT, DELETE, etc.
    switch(request.method) {
      case "GET":
        handleGet(request);
        break;
      case "POST":
        handlePost(request);
        break;
      default:
        request.response
          ..statusCode = 405
          ..write('Unsupported request: ${request.method}.')
          ..close();
    }

  } catch (e) {
    print('Exception in handleRequest: $e');
  }
  print('Request handled.');
}

//handle get requests
void handleGet(HttpRequest request) {
  final query_params = request.uri.queryParameters;
  
  //TODO: add here all get requests needed
  switch(request.uri.toString()) {
    case api_v + "full":
      controller.onFullData(request,query_params);
      break;

    default:
        request.response
          ..statusCode = 404
          ..write('Not Found: 404')
          ..close();
  }
  
}

//handle posts requests
void handlePost(HttpRequest request) {

  final query_params = request.uri.queryParameters;

  //TODO: add here all post requests needed
  switch(request.uri.toString()) {
    default:
    request.response
      ..statusCode = 200
      ..write('Post aca!')
      ..close();
  }
  
}

