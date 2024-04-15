
import 'dart:convert';

import 'package:http/http.dart';
import 'package:async/async.dart';

import 'Fire.dart';
class DatabaseManeger {
  late Uri url;

  DatabaseManeger() {
     url = Uri.http("192.168.1.111","api/index.php");
  }
  Future<List<Fire>> getFires() async {
    url = Uri.http("192.168.1.111","api/index.php");
    var response = await post(url, body: {
      "command":"getAllFires"
    });

    List<dynamic> decodedResponse = jsonDecode(response.body);
    List<Fire> listOfMaps = decodedResponse.map((item) {
      return Fire.fromMap(item);
    }).toList();

     return listOfMaps ;


  }



  List<Map<String, Object?>> respondets = [
    {
      "name": "Rezki",
      "username": "void",
      "positionLat": "36.750633",
      "positionLong": "3.468428",
      "isManeger": false
    }
  ];
}
