import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:notificationtreatment/Modules/DatabaseManeger.dart';

import '../Modules/Fire.dart';
import '../Modules/Respondent.dart';

class MapManeger extends GetxController{
   MapController mapController= MapController() ;
    List<Fire> fires =[] ;
  List<LatLng> cords =[] ;
  late LatLng currentRespondent;
  late MapOptions mapOptions;
  late DatabaseManeger db;
  late BuildContext cont;
  double listWidth=0;


  @override
  onInit() async{

    await setUp();
   super.onInit();

  }

   setUp()async {
     db=await DatabaseManeger();
     fires=await db.getFires();
     //List<Respondent> respondents= await db.getAllRespondents();
     currentRespondent=LatLng(0, 0);
     //mapController.move(LatLng(respondents[0].positionLat,respondents[0].positionLong), 18);


  }

  Future<List<LatLng>> setupMap()async{
    if(fires.length==0) await setUp();
    mapOptions=MapOptions(initialCenter: currentRespondent , initialZoom: 18);


    return [];
    //return  this.fires.map((e) => LatLng(e.latitude, e.longitude)).toList();



  }




  void setCenter(LatLng newCenter){
    mapController.move(newCenter, 20);
    update();

  }

  void showList(){
    if(listWidth==0) listWidth=MediaQuery.of(cont).size.width/10;
   else if(listWidth > MediaQuery.of(cont).size.width/10)
     listWidth=MediaQuery.of(cont).size.width/10;
    else listWidth=MediaQuery.of(cont).size.width/8;

      update(["list"]);
  }





}