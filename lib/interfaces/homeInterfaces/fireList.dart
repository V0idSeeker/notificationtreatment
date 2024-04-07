import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:notificationtreatment/controlers/mapManeger.dart';


class fireList extends StatelessWidget {
  const fireList({super.key});

  @override
  Widget build(BuildContext context) {

    return GetBuilder<mapManeger>(
      init: mapManeger(),

        builder:(controller){
          return Container(
            // list from database
            child : ListView.separated(
                    itemCount: controller.cords.length,
                    separatorBuilder: (BuildContext context, int index)=> Divider(),
                    itemBuilder: (BuildContext context, int index) {

                      return ListTile(
                        title: Text("Cords : ${controller.cords[index].latitude} , ${controller.cords[index].longitude}"),
                        onTap: (){
                          controller.setCenter(controller.cords[index]);
                        },
                        trailing: MaterialButton(onPressed: () { ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            duration: Duration(seconds: 1),
                            content: Container(  width: MediaQuery.of(context).size.width/4,
                                alignment: Alignment.center,
                                child: Text('Fire is set as "Distinguished "',textAlign: TextAlign.center,)),
                          ),
                        ); }, child : Text("Delete Fire")),
                      );
                    },




            ),
          ) ;
        });
  }
}
