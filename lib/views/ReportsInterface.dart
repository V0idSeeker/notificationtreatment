import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:notificationtreatment/controlers/MapManeger.dart';

class ReportsInterface extends StatelessWidget {
  const ReportsInterface({super.key});

  @override
  Widget build(BuildContext context) {

    return GetBuilder<MapManeger>(
      id: "ReportsInterface",
        init: MapManeger(),
        builder: (controller) {
        controller.cont=context;
        controller.listWidth=MediaQuery.of(context).size.width/10;
          return Stack(
            children: [
             FlutterMap(
                        mapController: controller.mapController,
                        options: MapOptions(initialZoom: 10,initialCenter: LatLng(36.750633,3.468428)),
                 children: [
                      TileLayer(
                        urlTemplate:
                            'https://mt1.google.com/vt/lyrs=y&x={x}&y={y}&z={z}',),
                       GetBuilder<MapManeger>(
                         init: MapManeger(),
                           id: "CircleLayer",
                           builder:(controller) {
                             print(controller.cords.length);
                           return CircleLayer(circles: controller.cords.map((e) => CircleMarker(point: e,  radius: 50 , color: Colors.red.withOpacity(0.4))).toList(),);
                         }
                       )

                    ]
                  ),


              GetBuilder<MapManeger>(
                id: "list",
                init: MapManeger(),

                builder: (controller) {

                  var icon  ;
                  if(controller.listWidth<MediaQuery.of(context).size.width/8) icon=Icons.arrow_back ;
                  else icon = Icons.arrow_forward;


                  return Positioned(
                    right: 0,
                    child: AnimatedContainer(
                        duration: Duration(milliseconds: 50),
                        color: Colors.red,
                        height: MediaQuery.of(context).size.height,
                        width: controller.listWidth,
                        child:Column(
                          children: [
                            Expanded(child: Container(color: Colors.blue,)),
                            MaterialButton(
                                onPressed: (){
                                  controller.showList();

                                },
                             child:Icon(icon)

                             ),



                          ],

                        ),

                    ),
                  );
                }
              ),
            ],
          );
        });
  }
}
