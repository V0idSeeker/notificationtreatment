import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:notificationtreatment/controlers/mapManeger.dart';
import 'package:provider/provider.dart';

class fireList extends StatelessWidget {
  const fireList({super.key});

  @override
  Widget build(BuildContext context) {

    return Container(
      // list from database
      child : FutureBuilder(
        future: context.watch<mapManeger>().getCords() ,
        builder: (context , snapshot) {
          if(snapshot.connectionState==ConnectionState.waiting) return CircularProgressIndicator();
          return ListView.separated(
            itemCount: snapshot.data!.length,
            separatorBuilder: (BuildContext context, int index)=> Divider(),
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text("Cords : ${snapshot.data![index].latitude} , ${snapshot.data![index].longitude}"),
                onTap: (){
                  context.read<mapManeger>().setCenter(snapshot.data![index]);
                },
              );
            },


          );
        }
      ),
    ) ;
  }
}
