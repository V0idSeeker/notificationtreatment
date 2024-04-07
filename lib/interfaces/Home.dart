import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notificationtreatment/controlers/HomeControler.dart';

import 'package:notificationtreatment/interfaces/homeInterfaces/fireList.dart';
import 'package:notificationtreatment/interfaces/homeInterfaces/fireMap.dart';
import 'package:notificationtreatment/interfaces/homeInterfaces/sideBar.dart';


class Home extends StatelessWidget {
   late Map<String , Object?> userData ;
   Home(  {super.key , required this.userData});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeControler>(
      init: HomeControler(userData) ,
        builder: (controller){
          //return Home();
          return  Scaffold(


              body: Row(
                children: [
                  Container(
                      color: Colors.red,
                      width: MediaQuery.of(context).size.width*1/8,
                      height: MediaQuery.of(context).size.height,
                      child: sideBar(username: controller.userName,district: controller.district,)
                  ),
                  Container(
                    color: Colors.grey,
                    width: MediaQuery.of(context).size.width*5/8,
                    height: MediaQuery.of(context).size.height,
                    child: fireMap(),
                  ),

                  Container(
                      color: Colors.blue,
                      width: MediaQuery.of(context).size.width*2/8,
                      height: MediaQuery.of(context).size.height,
                      child: fireList()
                  ),
                ],
              )
          );
        }
    );


  }
}
