import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:notificationtreatment/views/AccountSettings.dart';
import 'package:notificationtreatment/views/ManegeAccounts.dart';
import 'package:notificationtreatment/views/ReportsInterface.dart';
import 'package:notificationtreatment/views/StatsInterface.dart';

class InterfaceController extends GetxController{
  late Widget mainScreen;

  @override
  void onInit() {
    mainScreen=ReportsInterface();
    super.onInit();
  }
  changeMainScreen(int index){
    switch(index){
      case 0:{
        if(mainScreen is ReportsInterface) return ;
        mainScreen = ReportsInterface();
        break;
      }
      case 1:{
        if(mainScreen is StatsInterface) return ;
        mainScreen = new StatsInterface();
        break;
      }
      case 2:{
        if(mainScreen is ManegeAccounts) return ;
        mainScreen = new ManegeAccounts();
        break;
      }
      case 3:{
        if(mainScreen is AccountSettings) return ;
        mainScreen = new AccountSettings();
        break;
      }
    }

    update();

  }



}