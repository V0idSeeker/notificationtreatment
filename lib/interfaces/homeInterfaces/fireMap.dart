import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:notificationtreatment/controlers/mapManeger.dart';


// ignore: todo
// 💡 Consider installing the official 'flutter_map_cancellable_tile_provider' plugin for improved
// 💡 performance on the web.
// 💡 See https://pub.dev/packages/flutter_map_cancellable_tile_provider for more info.
class fireMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {






    return GetBuilder<mapManeger>(
        init:mapManeger() ,
        builder: (controller){


      return Scaffold(
          body: FlutterMap(
            mapController: controller.mc,
            options: MapOptions(
              initialCenter:
              LatLng(36.750633, 3.468428),
              zoom: 20,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://mt1.google.com/vt/lyrs=y&x={x}&y={y}&z={z}',
              ),
              FutureBuilder(future: controller.getMarkers(), builder: (context, snapshot){
                if(snapshot.hasError) print(snapshot.error.toString());
                if (snapshot.connectionState==ConnectionState.waiting ||snapshot.hasError ) return MarkerLayer(markers: []);
                return MarkerLayer(markers: snapshot.data!);

              })
            ],
          ));
    });
  }

}
