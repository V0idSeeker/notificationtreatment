import 'dart:convert';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:notificationtreatment/Modules/DatabaseManeger.dart';

class ManegeAccountsController extends GetxController{
DatabaseManeger db =DatabaseManeger();
Map<String , dynamic>data={};
@override
  void onInit() async {
    db= DatabaseManeger();
    super.onInit();
  }
  addUser()async{
  String? result =await db.addUser(data);
  return result;
  }




}