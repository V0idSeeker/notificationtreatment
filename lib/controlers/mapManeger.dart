import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:notificationtreatment/Modules/DatabaseManeger.dart';

import '../Modules/Fire.dart';

class MapManeger extends GetxController{
   MapController mapController= MapController() ;
  List<LatLng> cords =[] ;
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





    await getCords();
    mapController.move(LatLng(double.parse(db.respondets[0]["positionLat"].toString()),double.parse(db.respondets[0]["positionLong"].toString())), 15);
    update();





  }

  Future<void> getCords() async{
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