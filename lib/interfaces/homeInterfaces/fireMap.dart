import 'package:atlas/atlas.dart';
import 'package:flutter/material.dart';

class fireMap extends StatelessWidget {
  final  _initialCameraPosition =CameraPosition(
    target: LatLng(
      latitude: 36.710259,
      longitude: 3.175201,
    ),
    zoom: 12,
  );
  final _markers = Set<Marker>.from([
    Marker(
      id: 'marker-1',
      position: LatLng(

        latitude: 36.710259,
        longitude: 3.175201,
      ),
      icon: MarkerIcon(
        assetName: 'assets/marker.png',
      ),
      anchor: Anchor(
        x: 0.5,
        y: 1.0,
      ),
      onTap: () {
        print('tapped marker-1');
      },
    )
  ]);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Atlas(
        initialCameraPosition: _initialCameraPosition,
        markers: _markers,
      ),
    );
  }
}
