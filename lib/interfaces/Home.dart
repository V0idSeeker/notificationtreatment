import 'package:flutter/material.dart';
import 'package:notificationtreatment/interfaces/homeInterfaces/fireList.dart';
import 'package:notificationtreatment/interfaces/homeInterfaces/fireMap.dart';
import 'package:notificationtreatment/interfaces/homeInterfaces/sideBar.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(


      body: Row(
        children: [
          Container(
            color: Colors.red,
            width: MediaQuery.of(context).size.width*1/8,
            height: MediaQuery.of(context).size.height,
            child: sideBar()
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
              child: fireList(  )
          ),
        ],
      )
    );
  }
}
