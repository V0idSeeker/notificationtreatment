import 'package:flutter/material.dart';

class HomeControler extends ChangeNotifier{
  HomeControler(Map<String , Object?>data){
    this.userName=data["name"].toString();
    this.district=data["District"].toString();
  }
  late String userName, district;



}