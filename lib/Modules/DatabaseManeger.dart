
import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart';
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
    List<dynamic> decodedResponse = jsonDecode(response.body);
    List<Respondent> listOfRespondents = decodedResponse.map((item) {
      return Respondent.fromMap(item);
    }).toList();
return listOfRespondents;
  }

Future<String?> addUser(Map<String , dynamic> data)async{
    //respondets and manegers
  Uri urf = Uri.http("192.168.1.111","api/index.php");
    data["command"]="addRespondent";

  var response = await post(urf, body:data );
  int? affectedLines=int.tryParse(response.body);
  if(affectedLines==null) return response.body;
  else return null;
}


}
