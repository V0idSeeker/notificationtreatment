import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:notificationtreatment/controlers/AdminControlers/MainAdminController.dart';
import 'package:notificationtreatment/views/AccountSettings.dart';
import 'package:notificationtreatment/views/AdminPages/BrowsAccounts.dart';
import 'package:notificationtreatment/views/Stats.dart';
import 'package:notificationtreatment/views/LogIn.dart';

import '../../Modules/Admin.dart';

class MainAdminPage extends StatelessWidget {
  Admin admin;
  MainAdminPage(
    this.admin, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainAdminController>(
        init: MainAdminController(),
        builder: (controller) {
          controller.setAdmin(admin);
          return Scaffold(
            bottomNavigationBar: BottomNavigationBar(

              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.manage_accounts,color: Colors.blue,),
                    label: "Manege Accounts"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.query_stats ,color: Colors.blue,), label: "Stats"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings,color: Colors.blue,), label: "Settings"),
                BottomNavigationBarItem(icon: Icon(Icons.logout,color: Colors.blue,), label: "Logout"),
              ],
              onTap: (dest) {
                switch (dest) {
                  case 0:
                    if(controller.mainScreen != BrowsAccounts  )controller.updateInterface("BrowsAccounts");
                    break ;
                  case 1:
                    if(controller.mainScreen != Stats  )controller.updateInterface("Stats");
                    break;
                  case 2:
                    if(controller.mainScreen != AccountSettings) controller.updateInterface("AccountSettings");
                    break;
                  case 3:
                    Get.off(()=>LogIn());
                    break;

                }
              },
            ),
            body: GetBuilder<MainAdminController>(
              id: "interface",
              builder: (controller) {
                return controller.mainScreen;
              }
            ),
          );
        });
  }
}
