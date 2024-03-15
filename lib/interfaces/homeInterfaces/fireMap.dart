import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:notificationtreatment/controlers/mapManeger.dart';
import 'package:provider/provider.dart';

// ignore: todo
// 💡 Consider installing the official 'flutter_map_cancellable_tile_provider' plugin for improved
// 💡 performance on the web.
// 💡 See https://pub.dev/packages/flutter_map_cancellable_tile_provider for more info.
class fireMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mapcontroler=context.watch<mapManeger>();
    MapController mc=mapcontroler.mc;



    return Scaffold(
        body: FlutterMap(
          mapController: mc,
         options: MapOptions(
        initialCenter:
        LatLng(36.750633, 3.468428),
        zoom: 20,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://mt1.google.com/vt/lyrs=y&x={x}&y={y}&z={z}',
        ),
        FutureBuilder(future: mapcontroler.getMarkers(), builder: (context, snapshot){
          if(snapshot.hasError) print(snapshot.error.toString());
          if (snapshot.connectionState==ConnectionState.waiting ||snapshot.hasError ) return MarkerLayer(markers: []);
          return MarkerLayer(markers: snapshot.data!);

        })
      ],
    ));
  }

}
