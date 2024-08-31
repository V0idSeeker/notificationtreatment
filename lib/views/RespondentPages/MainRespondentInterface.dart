import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notificationtreatment/Modules/Styler.dart';
import 'package:notificationtreatment/controlers/RespondentController/MainRespondentController.dart';
import 'package:notificationtreatment/views/RespondentPages/FiresMap.dart';
import 'package:notificationtreatment/views/RespondentPages/ReportManegment.dart';

import '../../Modules/Respondent.dart';
import '../AccountSettings.dart';
import '../LogIn.dart';
import '../Stats.dart';

class MainRespondentInterface extends StatelessWidget {
  Respondent respondent;
  MainRespondentInterface(this.respondent ,{super.key});

  @override
  Widget build(BuildContext context) {
    Styler styler = Styler();
    return GetBuilder<MainRespondentController>(
        init: MainRespondentController(),
        builder: (controller){
          controller.cnx();


          controller.setRespondent(respondent);

          return  Scaffold(

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
                        padding:
                        EdgeInsets.all(controller.index == 0 ? 8.0 : 0.0),
                        child: Icon(Icons.report,color: Colors.blue,),
                      )),

                  label: "Manege Reports"),
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
                        padding:
                        EdgeInsets.all(controller.index == 1 ? 8.0 : 0.0),
                        child: Icon(Icons.local_fire_department_sharp,color: Colors.blue,),
                      )),
                  label: "Consult Fires"),
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
                        padding:
                        EdgeInsets.all(controller.index == 2 ? 8.0 : 0.0),
                        child: Icon(Icons.query_stats,color: Colors.blue,),
                      )),
                   label: "Stats"),
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
                        padding:
                        EdgeInsets.all(controller.index == 3 ? 8.0 : 0.0),
                        child: Icon(Icons.settings,color: Colors.blue,),
                      )),
              label: "Settings",),

              BottomNavigationBarItem(icon: Icon(Icons.logout,color: Colors.blue,), label: "Logout"),
            ],
            onTap: (dest) {


              switch (dest) {
                case 0:
                  if(controller.mainScreen != ReportManagement  )controller.updateInterface("ReportManagement");
                  break ;
                case 1:
                  if(controller.mainScreen != FireMap  )controller.updateInterface("FireMap");
                  break;

                case 2:
                  if(controller.mainScreen != Stats  )controller.updateInterface("Stats");
                  break;
                case 3:
                  if(controller.mainScreen != AccountSettings) controller.updateInterface("AccountSettings");
                  break;
                case 4:
                  Get.offAll(()=>LogIn());
                  break;

              }
            },
          ),
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
                        child:GetBuilder<MainRespondentController>(

              id: "interface",
              builder: (controller) {


                return controller.mainScreen;
              }
          ),
          ),
          ),
          ));
        }

      ,
    )
          );


    });
  }
}
