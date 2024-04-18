import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:notificationtreatment/controlers/MapManeger.dart';

import '../Modules/Fire.dart';

class ReportsInterface extends StatelessWidget {
  const ReportsInterface({super.key});

  @override
  Widget build(BuildContext context) {

    return  Stack(
            children: [
              GetBuilder<MapManeger>(
                id: "Map",
                  init: MapManeger(),
                  builder:(controller){


                return FutureBuilder(
                  future: controller.setupMap(),
                  builder: (context,snapshot) {
                    if(snapshot.connectionState==ConnectionState.waiting) return Center(child: CircularProgressIndicator(),);
                    if(snapshot.hasError )return Center(child: Text(snapshot.error.toString()),);
                    return FlutterMap(
                        mapController: controller.mapController,
                        options: controller.mapOptions,
                        children: [
                          TileLayer(
                            urlTemplate:
                            'https://mt1.google.com/vt/lyrs=y&x={x}&y={y}&z={z}',),



                                 CircleLayer(circles: snapshot.data!.map((e) => CircleMarker(point: e,  radius: 50 , color: Colors.red.withOpacity(0.4))).toList(),)

                        ]
                    );
                  }
                );


              }),



              GetBuilder<MapManeger>(
                id: "list",
                init: MapManeger(),

                builder: (controller) {

                  controller.cont=context;
                  if(controller.listWidth==0)controller.showList();

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
                            Expanded(child: ListView.separated(
                                separatorBuilder: (context , index)=>Divider(),
                                itemCount: controller.fires.length,
                                itemBuilder: (context,index){
                                  Fire cord =controller.fires[index];

                                  return ListTile(
                                    title:Text(cord.flag) ,
                                    onTap: (){
                                      controller.setCenter(LatLng(cord.latitude, cord.longitude));
                                    },

                                  );
                                }
                            ),),
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
  }
}
