import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class mapManeger extends GetxController{
  late MapController mc ;
  late List<LatLng> cords ;

  @override
  onInit() async{
    mc =new MapController();
    await getCords();
    super.onInit();


  }

  Future<void> getCords() async{

     cords = [
      LatLng(36.751669, 3.469903),
      LatLng(36.752121, 3.469988),
      LatLng(36.751520, 3.467131),
      LatLng(36.750633, 3.468428),

    ];




  }
  Future<List<Marker>> getMarkers() async {
    List<Marker> markers = [];

    cords.forEach((element) {
      markers.add(Marker(
          point: element,

          width: 100,
          height: 100,
          child: Icon(Icons.fireplace , size: 100,)) );
    });
    return markers;
  }

  void setCenter(LatLng newCenter){
    mc.move(newCenter, 20);
    update();

  }





}