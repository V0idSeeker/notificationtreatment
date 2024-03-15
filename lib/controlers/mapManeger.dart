import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class mapManeger extends ChangeNotifier{
  late MapController mc =new MapController();

 // List<Marker> cords=[] ;

  Future<List<LatLng>> getCords() async{

    List<LatLng> cords = [
      LatLng(36.751669, 3.469903),
      LatLng(36.752121, 3.469988),
      LatLng(36.751520, 3.467131),
      LatLng(36.750633, 3.468428),

    ];


    return cords ;

  }
  Future<List<Marker>> getMarkers() async {
    List<Marker> markers = [];
    List<LatLng> cords = await getCords();
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
    notifyListeners();

  }





}