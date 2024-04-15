
import 'dart:convert';

import 'package:http/http.dart';
import 'package:async/async.dart';
import 'package:notificationtreatment/Modules/Respondent.dart';

import 'Fire.dart';
class DatabaseManeger {
  late Uri url;

  DatabaseManeger() {
     url = Uri.http("192.168.1.111","api/index.php");
  }
  Future<List<Fire>> getFires() async {
    var response = await post(url, body: {
      "command":"getAllFires"
    });

    List<dynamic> decodedResponse = jsonDecode(response.body);
    List<Fire> listOfFires = decodedResponse.map((item) {
      return Fire.fromMap(item);
    }).toList();

     return listOfFires;

  }
  Future<List<Respondent>> getAllRespondents()async{

    var response = await post(url, body: {
      "command":"getAllRespondents"
    });
    print(response.body);
    List<dynamic> decodedResponse = jsonDecode(response.body);
    List<Respondent> listOfRespondents = decodedResponse.map((item) {
      return Respondent.fromMap(item);
    }).toList();
return listOfRespondents;
  }



  List<Map<String, Object?>> respondets = [
    {
      "name": "Rezki",
      "username": "void",
      "password":"void",
      "positionLat": "36.750633",
      "positionLong": "3.468428",
      "isManeger": false
    }
  ];
}
