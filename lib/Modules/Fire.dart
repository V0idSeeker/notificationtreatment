import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';


class Fire {
  late double longitude , latitude ;
  late String flag="proccecing";
  late DateTime flagDate;
  Uint8List? image;
  Uint8List? audiobits;




  Fire(double long,double lat,String flag ,DateTime fireDate ) {
    this.latitude=lat;
    this.longitude=long;
    this.flag=flag;
    this.flagDate=fireDate;


  }

  void setImage8(Uint8List img) {
    image = img;
  }

  Image getImage( ) {
    return Image.memory(image!);

  }
  void setAudio(Uint8List? audio)=>this.audiobits=audio ;




  Fire.fromMap(Map<String, dynamic> map ){
    this.longitude=double.parse(map["locationLong"].toString());
    this.latitude=double.parse(map["locationLat"].toString());
    this.flag=map["flag"].toString();
    this.flagDate=DateTime.parse(map["flagDate"].toString());

    /*if(map["audio"]!=null){
  List<String>  a=map["audio"].toString().replaceAll('[', '').replaceAll(']', '').split(',');
  this.audiobits=Uint8List.fromList(a.map((e) => int.parse(e)).toList());
 }else this.audiobits=null;
*/
    this.audiobits=null;
  //  List<String>  p=map["image"].toString().replaceAll('[', '').replaceAll(']', '').split(',');
   // this.image=Uint8List.fromList(p.map((e) => int.parse(e)).toList());
  }






@override
  String toString() {

    return """
    [ Longtitude :$longitude , Latitude :$latitude ,  flag :$flag ,
    ]
    """;
  }

}