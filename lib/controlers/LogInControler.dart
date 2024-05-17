import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notificationtreatment/Modules/DatabaseManeger.dart';

class LogInControler extends GetxController{
late DatabaseManeger db;
bool isConnected=true;
late String username , password;
@override
  void onInit() {
  super.onInit();
    username="";
    password="";
    db=new DatabaseManeger();

  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  Future<void> cnx() async {
    bool t = await db.connectionStatus();

    if(isConnected!=t)isConnected=t;

  }


Future<Map<String , dynamic>>logIn()async {
    return await db.logIn(username,password);
  }






}