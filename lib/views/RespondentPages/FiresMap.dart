import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:notificationtreatment/Modules/Styler.dart';
import 'package:notificationtreatment/controlers/RespondentController/MainRespondentController.dart';

import '../../Modules/Fire.dart';

class FireMap extends StatelessWidget {
  const FireMap({super.key});

  @override
  Widget build(BuildContext context) {
    Styler styler = Styler();
    return GetBuilder<MainRespondentController>(
      id: "FireManagement",
      init: MainRespondentController(),
      builder: (controller) {
        controller.setupFireMap();
        return Scaffold(

          body: Row(
            children: [
              GetBuilder<MainRespondentController>(
                id: "FiresMap",
                builder: (controller) {
                  return Stack(
                    children: [

                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        decoration: Styler().orangeBlueBackground(),
                        child: FlutterMap(
                          mapController: controller.mapController,
                          options: controller.mapOptions,
                          children: [
                            TileLayer(
                              urlTemplate: 'https://mt1.google.com/vt/lyrs=y&x={x}&y={y}&z={z}',
                            ),
                            MarkerLayer(
                              markers: [
                                Marker(
                                  point: controller.respondentCenter,
                                  child: Icon(Icons.pin_drop_rounded, color: Styler().primaryColor),
                                )
                              ],
                            ),
                            CircleLayer<Object>(
                              circles: controller.allFiresList == null
                                  ? []
                                  : controller.allFiresList!.map((fire) => CircleMarker(
                                point: LatLng(fire.optimalPositionLat, fire.optimalPositionLong),
                                radius: 80,
                                color: fire.fireStatus == "active"
                                    ? Colors.red.withOpacity(0.6)
                                    : fire.fireStatus == "treated"
                                    ? Colors.green.withOpacity(0.6)
                                    : Colors.yellow.withOpacity(0.6),
                                useRadiusInMeter: true,
                              )).toList(),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(style: styler.elevatedButtonStyle(),
                          onPressed: (){
                        controller.moveMap(controller.respondentCenter);
                          },
                          child: Icon(Icons.pin_drop_rounded))
                    ],
                  );
                },
              ),
              GetBuilder<MainRespondentController>(
                id: "FiresList",
                builder: (controller) {
                  return Container(
                    width: MediaQuery.of(context).size.width * 0.2,
                    color: Styler().lightGreyBackgroundColor,
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8.0),
                          color: Styler().primaryColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Image.asset('assets/logo.png', height: 50,),
                              Text(
                                " Fires ",
                                style: TextStyle(
                                  color: Styler().backgroundColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: controller.allFiresList == null || controller.allFiresList!.isEmpty
                              ? Center(
                            child: Text(
                              "No Fires",
                              style: TextStyle(color: Styler().textColor),
                            ),
                          )
                              : ListView.separated(
                            separatorBuilder: (context, index) => Divider(color: Colors.grey),
                            itemCount: controller.allFiresList!.length,
                            itemBuilder: (context, index) {
                              Fire fire = controller.allFiresList![index];
                              return ListTile(
                                title: Text(
                                  fire.optimalAddr,
                                  style: TextStyle(color: Styler().textColor),
                                ),
                                subtitle: Text(
                                  fire.initialDate.toString(),
                                  style: TextStyle(color: Styler().textColor),
                                ),
                                onTap: () {
                                  controller.moveMap(LatLng(fire.optimalPositionLat, fire.optimalPositionLong));
                                },
                                trailing: Text(
                                  "Status: ${fire.fireStatus}",
                                  style: TextStyle(color: Styler().textColor),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );

  }
}
