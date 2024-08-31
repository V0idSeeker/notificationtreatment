import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:notificationtreatment/Modules/Styler.dart';
import 'package:notificationtreatment/controlers/AdminControlers/MainAdminController.dart';
import 'package:notificationtreatment/views/AccountSettings.dart';
import 'package:notificationtreatment/views/AdminPages/BrowsAccounts.dart';
import 'package:notificationtreatment/views/Stats.dart';
import 'package:notificationtreatment/views/LogIn.dart';

import '../../Modules/Admin.dart';

class MainAdminPage extends StatelessWidget {
  Admin admin;
  final styler = Styler();
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
          controller.cnx();
          return Scaffold(
              bottomNavigationBar: styler.bottomNavigationBar(
                  currentIndex: controller.index,
                  items: [
                    BottomNavigationBarItem(
                        icon: Container(
                            decoration: BoxDecoration(
                              color: controller.index == 0
                                  ? Colors.grey.shade200
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: controller.index == 0
                                  ? [
                                      BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 10,
                                        offset: Offset(0, 4),
                                      ),
                                    ]
                                  : [],
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(
                                  controller.index == 0 ? 8.0 : 0.0),
                              child: Icon(
                                Icons.manage_accounts,
                                color: Colors.blue,
                              ),
                            )),
                        label: "Manege Accounts"),
                    BottomNavigationBarItem(
                        icon: Container(
                            decoration: BoxDecoration(
                              color: controller.index == 1
                                  ? Colors.grey.shade200
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: controller.index == 1
                                  ? [
                                      BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 10,
                                        offset: Offset(0, 4),
                                      ),
                                    ]
                                  : [],
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(
                                  controller.index == 1 ? 8.0 : 0.0),
                              child: Icon(
                                Icons.query_stats,
                                color: Colors.blue,
                              ),
                            )),
                        label: "Stats"),
                    BottomNavigationBarItem(
                        icon: Container(
                            decoration: BoxDecoration(
                              color: controller.index == 2
                                  ? Colors.grey.shade200
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: controller.index == 2
                                  ? [
                                      BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 10,
                                        offset: Offset(0, 4),
                                      ),
                                    ]
                                  : [],
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(
                                  controller.index == 2 ? 8.0 : 0.0),
                              child: Icon(
                                Icons.settings,
                                color: Colors.blue,
                              ),
                            )),
                        label: "Settings"),
                    BottomNavigationBarItem(
                        icon: Container(
                            decoration: BoxDecoration(
                              color: controller.index == 3
                                  ? Colors.grey.shade200
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: controller.index == 3
                                  ? [
                                      BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 10,
                                        offset: Offset(0, 4),
                                      ),
                                    ]
                                  : [],
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(
                                  controller.index == 3 ? 8.0 : 0.0),
                              child: Icon(
                                Icons.logout,
                                color: Colors.blue,
                              ),
                            )),
                        label: "Logout"),
                  ],
                  onTap: (dest) {
                    switch (dest) {
                      case 0:
                        if (controller.mainScreen != BrowsAccounts)
                          controller.updateInterface("BrowsAccounts");
                        break;
                      case 1:
                        if (controller.mainScreen != Stats)
                          controller.updateInterface("Stats");
                        break;
                      case 2:
                        if (controller.mainScreen != AccountSettings)
                          controller.updateInterface("AccountSettings");
                        break;
                      case 3:
                        Get.offAll(() => LogIn());
                        break;
                    }
                  }),
              body: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  double minWidth = 1280;
                  double minHeight = 1000;
                  return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: minWidth > constraints.maxWidth
                              ? minWidth
                              : constraints.maxWidth,
                          minHeight: minHeight > constraints.maxHeight
                              ? minHeight
                              : constraints.maxHeight,
                        ),
                        child: SingleChildScrollView(
                          child: Container(
                            width: minWidth,
                            height: minHeight,
                            child: GetBuilder<MainAdminController>(
                              id: "interface",
                              builder: (controller) {
                                if (controller.isConnected)
                                  return controller.mainScreen;
                                Get.snackbar(
                                    "Connection Error ", "Lost Connection");
                                Get.off(() => LogIn());
                                return Container();
                              },
                            ),
                          ),
                        ),
                      ));
                }

                ,
              ));
        });
  }
}
