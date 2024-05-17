import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:notificationtreatment/controlers/RespondentController/MainRespondentController.dart';

import '../../Modules/Fire.dart';

class FireMap extends StatelessWidget {
  const FireMap({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainRespondentController>(
        id: "FireManagement",
        builder: (controller) {
          controller.setupFireMap();
          return Container(
            height: MediaQuery.of(context).size.height,
            child: Row(
              children: [
                GetBuilder<MainRespondentController>(
                    id: "FiresMap",
                    builder: (controller) {
                      return Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: FlutterMap(
                          mapController: controller.mapController,
                          options: controller.mapOptions,
                          children: [
                            TileLayer(
                              urlTemplate:
                                  'https://mt1.google.com/vt/lyrs=y&x={x}&y={y}&z={z}',
                            ),
                            GetBuilder<MainRespondentController>(
                                id: "respondentPosition",
                                builder: (controller) {
                                  return MarkerLayer(markers: [
                                    Marker(
                                        point: controller.respondentCenter,
                                        child: Icon(Icons.pin_drop_rounded))
                                  ]);
                                }),
                            CircleLayer(
                              circles: controller.allFiresList == null
                                  ? []
                                  : controller.allFiresList!
                                      .map((e) => CircleMarker(
                                          point: LatLng(e.optimalPositionLat,
                                              e.optimalPositionLong),
                                          radius: 80,
                                          color: e.fireStatus == "active"
                                              ? Colors.red.withOpacity(0.6)
                                              : e.fireStatus=="treated"?Colors.green.withOpacity(0.6):
                                           Colors.yellow.withOpacity(0.6),
                                          useRadiusInMeter: true))
                                      .toList(),
                            )
                          ],
                        ),
                      );
                    }),
                GetBuilder<MainRespondentController>(
                    id: "FiresList",
                    builder: (controller) {
                      return Container(
                        width: MediaQuery.of(context).size.width * 0.2,
                        child: Column(children: [
                          Center(child: Text("Fires")),
                          Container(
                            height:
                            MediaQuery.of(context).size.height * 0.8,
                            child: controller.allFiresList== null ||
                                controller.allFiresList!.isEmpty
                                ? Text("No Fires")
                                : ListView.separated(
                                separatorBuilder: (context, index) =>
                                    Divider(color: Colors.grey,),
                                itemCount:
                                controller.allFiresList!.length,
                                itemBuilder: (context, index) {
                                  Fire rep =
                                  controller.allFiresList![index];
                                  return ListTile(
                                    title: Text(rep.optimalAddr),
                                    subtitle: Text(
                                        rep.initialDate.toString()),
                                    onTap: () {
                                      controller.moveMap(LatLng(
                                          rep.optimalPositionLat,
                                          rep.optimalPositionLong));
                                    },trailing: Text("Status :${rep.fireStatus}"),


                                  );
                                }),
                          )
                        ]),
                      );
                    }),
              ],
            ),
          );
        });
  }
}
