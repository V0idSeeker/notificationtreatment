import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'mapManeger.dart';

class HomeControler extends GetxController{
  HomeControler(Map<String , Object?>data){
    this.userName=data["name"].toString();
    this.district=data["District"].toString();
  }
  GetxController mapmaneger = mapManeger();
  late String userName, district;



}