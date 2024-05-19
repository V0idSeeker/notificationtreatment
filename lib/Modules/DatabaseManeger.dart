import 'dart:convert';

import 'package:http/http.dart';

import 'Fire.dart';
import 'Report.dart';

class DatabaseManeger {
  late Uri url;
  static late String ip="192.168.1.111";

  DatabaseManeger() {
    //for local

      url = Uri.http(ip, "api/index.php");


  }

  Future<bool> connectionStatus()async{
    bool f;
    try {
      var response =await  post(url , body: {
        "command": "connectionStatus",
      }).timeout(Duration(milliseconds: 500));
      if (response.statusCode == 200) f= true;
      else f=false;
    }catch(e){
      f=false;
    }

    return f;


  }
  void setIp(String newIp) {
    ip=newIp;
    url = Uri.http(ip,"api/index.php");

  }

  String getIp()=>ip;


  // account section
  Future<Map<String, dynamic>> logIn(String username, String password) async {

    var response = await post(url, body: {
      "username": username,
      "password": password,
      "command": "logIn",
    });
    if (response.statusCode != 200) return {"Error": "Connection error"};
    List<dynamic> decodedResponse = jsonDecode(response.body);

    if(decodedResponse[0]==null) return {"Error": "Invalid information "};
    return decodedResponse[0];
  }
  Future<List> getAllAccounts( String param,String value,String category) async {
    var response = await post(url, body: {
      "param":param,
      "value": value,
      "category": category,
      "command": "getAllAccounts",
    });
    List<dynamic> decodedResponse = jsonDecode(response.body);
    return decodedResponse;
  }
  Future<bool> addAccount(Map<String, dynamic> addAccountData) async{
    addAccountData["command"]="addAccount";
    var response =await post(url, body: addAccountData);
    Map<String , dynamic> decodedResponse = jsonDecode(response.body);

    if(decodedResponse["success"]==true) return true;
    return false ;
  }
  updateAccount(Map<String, dynamic> addAccountData) async {
    addAccountData["command"] ="updateAccount";
    var response = await post(url, body: addAccountData);

    Map<String ,dynamic> decodedResponse = jsonDecode(response.body);
    return decodedResponse["success"]==true;


  }

  //fire section
  Future<List<Fire>> getAllLocalFires(String city) async {
    var response = await post(url, body: {"command": "getAllLocalFires" , "city": city});

    List<dynamic> decodedResponse = jsonDecode(response.body);
    List<Fire> listOfFires = decodedResponse.map((item) {
      return Fire.fromMap(item);
    }).toList();
    return listOfFires;
  }

  //reports section
  Future<List<Report>>getRespondentReports(String city) async {


    var response = await post(url, body: {"command": "getRespondentReports", "city": city });


    List<dynamic> decodedResponse = jsonDecode(response.body);
    List<Report> listOfReports = decodedResponse.map((item) {
      return Report.fromMap(item);
    }).toList();
    return listOfReports;
  }
  Future<bool> updateRespondentReportStatus(int id ,int respondentId , String status)async {


    var response = await post(url, body: {
      "command": "updateRespondentReportStatus",
      "respondentId": respondentId.toString(),
      "reportId": id.toString(),
      "newStatus" : status.toString()
    });

    Map<String ,dynamic> decodedResponse = jsonDecode(response.body);


    return bool.parse(decodedResponse["success"].toString());

  }
  //Fires section
  Future<List<Fire>> getActiveLocalFires(String  city) async {
    var response=await post(url,body: {
      "command": "getActiveLocalFires",
      "city": city
    });
    List<dynamic> decodedResponse = jsonDecode(response.body);
    List<Fire> listOfActiveFires = decodedResponse.map((item) {
      return Fire.fromMap(item);
    }).toList();
    return listOfActiveFires;
  }
  Future<void> addNewFire(Fire fire , int reportId)async{
    Map<String ,dynamic> data=fire.toMap();
    data["command"]="addNewFire";
    data["reportId"]="reportId";

    var response =await post(url ,body:data );

  }
  Future<void> assignToFire(int fireId, Report report ,bool isOptimal)async{
    Map<String ,dynamic> data=report.toMap();
    data["command"]="assignReportToFire";
    data["fireId"]=fireId.toString();
    data["isOptimal"]=isOptimal.toString();
    var response=await post(url ,body:data );

  }

  Future<bool> updateFireStatus (int fireId , int firefighterId , String newStatus)async{
    var response =await post(url ,body:{
      "command": "updateFireStatus",
      "fireId": fireId.toString(),
      "firefighterId": firefighterId.toString(),
      "newStatus" : newStatus.toString()
    });
    Map<String ,dynamic> decodedResponse = jsonDecode(response.body);
    return bool.parse(decodedResponse["success1"].toString()) && bool.parse(decodedResponse["success2"].toString());

  }

//only for user & fighter
  Future<bool> sendReport(Report report) async {
    var request = MultipartRequest('POST', url);
    //attaching data to the request
    report.toMap().forEach((key, value) async {
      request.fields["command"] = "addReport";
      //if its a file
      if (key == "resourcePath" || key == "audioPath") {
        if (value != null)
          request.files.add(
            await MultipartFile.fromPath(
              key,
              value,
            ),
          );
      }
      //if its normal data

      else
        request.fields[key] = value.toString();
    });
    // Add the image file to the request

    try {
      // Send the request
      var streamedResponse = await request.send();

      // Get the response
      var response = await Response.fromStream(streamedResponse);

      // Check if the upload was successful
      if (response.statusCode == 200) {


      } else {
        print('Failed to upload image: ${response.statusCode}');
      }
    } catch (e) {
      print('Error uploading image: $e');
    }

    return true;
  }



//geolocator api section
  latLongToCity(double lat, double long) async {
    var response = await post(url,body: {
      "lat":lat.toString(),
      "long":long.toString(),
      "command":"latLongToCity"

    });
    print(response.body);
    return jsonDecode(response.body);

  }
  cityToLatLang(String city) async {

    var response = await post(url,body: {
      "data":city,
      "command":"cityToLatLang"

    });
    return jsonDecode(response.body);

  }
  infoChecker(String? city , String username , String password ,String id) async {

    var response = await post(url,body: {
      "command":"checkInInfoAvailability",
      "username": username,
      "password": password,
      "accountId":id.toString()
    });
    Map<String ,dynamic> bdresponse = jsonDecode(response.body);
    if(city!=null){

      Map<String ,dynamic> georesponse= await cityToLatLang(city);
      if(georesponse["positionLong"]== null) bdresponse["city"]=null;
      else{
        var t=await latLongToCity(double.parse(georesponse["positionLat"].toString()),double.parse(georesponse["positionLong"].toString()));
        bdresponse["city"]=t["city"];

      }
    }



     return bdresponse;

  }

  deleteAccount(int parse)async {
    var response = await post(url, body: {
      "command": "deleteAccount",
      "id": parse.toString(),
    });
    Map<String ,dynamic> decodedResponse = jsonDecode(response.body);
    return decodedResponse;
  }



}
