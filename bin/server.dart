import 'package:asu_traffic_api/asu_traffic_api.dart' as asu_traffic_api;
import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'src/controllers/asu_traffic_controller.dart';
import 'database.dart';
import 'package:sqljocky/sqljocky.dart';


//build by Ivan Koop

const String api_v = "/api/v1/";
ConnectionPool db_pool;

Future main() async {



  //db connection init
  db_pool = new ConnectionPool(

    host: AsuTrafficDatabase.HOST, 
    port: AsuTrafficDatabase.PORT, 
    user: AsuTrafficDatabase.USER, 
    db: AsuTrafficDatabase.DB, 
    max: AsuTrafficDatabase.MAX
    
  );

  //http server init
  HttpServer server = await HttpServer.bind(
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
  switch(request.uri.pathSegments[2]) {
    case "full":
      AsuTrafficController.onFullData(request, db_pool);
      break;

    case "zone":
      AsuTrafficController.onDataByZone(request, db_pool,request.uri.pathSegments[3]);
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

