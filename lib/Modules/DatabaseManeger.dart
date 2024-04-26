
import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:latlong2/latlong.dart';
import 'package:notificationtreatment/Modules/Report.dart';
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
 /* Future<List<Respondent>> getAllRespondents()async{
    //change

    var response = await post(url, body: {
      "command":"getAllRespondents"
    });
    List<dynamic> decodedResponse = jsonDecode(response.body);
    List<Respondent> listOfRespondents = decodedResponse.map((item) {
      return Respondent.fromMap(item);
    }).toList();
return listOfRespondents;
  }*/

Future<String?> addUser(Map<String , dynamic> data)async{
    //respondets and manegers
  Uri urf = Uri.http("192.168.1.111","api/index.php");
    data["command"]="addRespondent";

  var response = await post(urf, body:data );
  int? affectedLines=int.tryParse(response.body);
  if(affectedLines==null) return response.body;
  else return null;
}
getReport()async {
  Uri urf = Uri.http("192.168.1.111","api/test.php");
  var response = await post(urf, body:{
    "command":"getReport"
  } );
  List<dynamic> decodedResponse = jsonDecode(response.body);
  List<Report> listOfReports = decodedResponse.map((item) {
    return Report.fromMap(item);
  }).toList();
  return listOfReports;



}

cityToLatLong(String city)async{
  Uri geo = Uri.http("geocode.xyz",city,{
    "geoit":"json",
    "auth":"166663479639058122701x87830"
  });
  var response = await get(geo);
  dynamic decodedResponse = jsonDecode(response.body);
  double lat=double.parse(decodedResponse["latt"]);
  double long=double.parse(decodedResponse["longt"]);

  print("long : $long , lat : $lat");

}

latLongToCity(double lat , double long)async{
  Uri geo = Uri.http("geocode.xyz","${lat},$long",{
    "geoit":"json",
    "auth":"166663479639058122701x87830"
  });
  var response = await get(geo);
  dynamic decodedResponse = jsonDecode(response.body);
  String city=decodedResponse["city"];

  print("city :$city");



}




}
