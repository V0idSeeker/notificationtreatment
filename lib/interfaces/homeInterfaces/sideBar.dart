import 'package:flutter/material.dart';



class sideBar extends StatelessWidget {
  late String username , district;

  sideBar( {super.key , required this.username , required this.district});

  @override
  Widget build(BuildContext context) {


      return Column(
        children: [
          Icon(Icons.fireplace_outlined , size: MediaQuery.of(context).size.width*1/9,),
          Divider(),
          Text("Name :"+ username),
          Divider(),
          Text("Wilaya :"+ district)

        ],
      );

  }
}
