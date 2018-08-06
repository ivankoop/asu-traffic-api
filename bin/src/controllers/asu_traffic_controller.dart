import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:sqljocky/sqljocky.dart';

//build by Ivan Koop

class AsuTrafficController {

  static onFullData(HttpRequest request, ConnectionPool db_pool) async {

    //TODO: handle sql errors
    final results = await db_pool.query('select * from duration_info order by id desc');
    final list = await results.toList();
    final List<Map> response_list = new List();

    for(var row in list) {
      final map_data = new Map();
      map_data["id"] = row[0];
      map_data["location"] = row[2];
      map_data["created_at"] = row[3].toString();
      map_data["value"] = JSON.decode(row[1].toString());
      response_list.add(map_data);
    }

    final json_data = JSON.encode(response_list);

    request.response
      ..statusCode = 200
      ..headers.add('Content-Type','application/json')
      ..write(json_data)
      ..close();
    
  }

  static onDataByZone(HttpRequest request, ConnectionPool db_pool, String zone) async {

    //TODO: handle sql errors
    final results = await db_pool.query('select * from duration_info where name="${zone}" order by id desc');
    final list = await results.toList();
    final List<Map> response_list = new List();
 
    for(var row in list) {
      final map_data = new Map();
      map_data["id"] = row[0];
      map_data["location"] = row[2];
      map_data["created_at"] = row[3].toString();
      map_data["value"] = JSON.decode(row[1].toString());
      response_list.add(map_data);
    }

    final json_data = JSON.encode(response_list);

    request.response
      ..statusCode = 200
      ..headers.add('Content-Type','application/json')
      ..write(json_data)
      ..close();

  }

}