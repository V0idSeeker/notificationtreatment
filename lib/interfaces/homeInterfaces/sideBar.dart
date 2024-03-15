import 'package:flutter/material.dart';
import 'package:notificationtreatment/controlers/HomeControler.dart';
import 'package:provider/provider.dart';

class sideBar extends StatelessWidget {
  const sideBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controler= Provider.of<HomeControler>(context) ;

    return Column(
      children: [
        Icon(Icons.fireplace_outlined , size: MediaQuery.of(context).size.width*1/9,),
        Divider(),
        Text("Name :"+ controler.userName),
        Divider(),
        Text("Wilaya :"+ controler.wilaya)
        
      ],
    );
  }
}
