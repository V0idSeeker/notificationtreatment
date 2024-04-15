import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:notificationtreatment/Modules/DatabaseManeger.dart';

import '../Modules/Fire.dart';
import '../Modules/Respondent.dart';

class MapManeger extends GetxController{
   MapController mapController= MapController() ;
  List<LatLng> cords =[] ;
  late LatLng currentRespondent;
  late MapOptions mapOptions;
  late DatabaseManeger db;
  late BuildContext cont;
  double listWidth=0;


  @override
  onInit() async{


   super.onInit();
   await setupMap();
  }

  Future<void> setupMap()async{
    db=await DatabaseManeger();
    cords=[];
    List<Fire> fires=await db.getFires();
    fires.forEach((element) {
      cords.add(LatLng(element.latitude, element.longitude));
    });
    List<Respondent> respondents= await db.getAllRespondents();
    currentRespondent=LatLng( respondents[0].positionLat ,respondents[0].positionLong);

    mapController.move(LatLng(respondents[0].positionLat,respondents[0].positionLong), 18);
    update();

  }

  Future<void> getFires() async{
    return;
      if(cords.isNotEmpty) return;
    cords=[];
    List<Fire> fires=await db.getFires();
      fires.forEach((element) {
       cords.add(LatLng(element.latitude, element.longitude));
     });
      print(cords.toString());
      update(["CircleLayer"]);

  }


  void setCenter(LatLng newCenter){
    mapController.move(newCenter, 20);
    update();

  }

  void showList(){
    if(listWidth==0)  listWidth=MediaQuery.of(cont).size.width/10;
   else if(listWidth> MediaQuery.of(cont).size.width/10)
     listWidth=MediaQuery.of(cont).size.width/10;
    else listWidth=MediaQuery.of(cont).size.width/8;

      update(['list']);
  }





}