import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notificationtreatment/controlers/InterfaceController.dart';
import 'package:side_navigation/side_navigation.dart';

class MainInterface extends StatelessWidget {
  //required Map<String, Object?> userData
  const MainInterface({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InterfaceController>(
        init: InterfaceController(),
        builder: (controller) {
          return Scaffold(

            body: Container(
              child: Stack(

                children: [


                  Container(
                  width: MediaQuery.of(context).size.width
                      ,child: controller.mainScreen),
                  SideNavigationBar(
                    initiallyExpanded: false,
                    theme: SideNavigationBarTheme(
                      backgroundColor: Colors.blue,
                      togglerTheme: SideNavigationBarTogglerTheme.standard(),
                      itemTheme: SideNavigationBarItemTheme.standard(),
                      dividerTheme: SideNavigationBarDividerTheme.standard(),
                    ),
                    header: SideNavigationBarHeader(
                        image: Icon(Icons.face),
                        title: Text("Hi Mr "),
                        subtitle: Text("Respondent")),
                    onTap: (index){
                      controller.changeMainScreen(index);
                    },
                    selectedIndex: 0,
                    items: [
                      SideNavigationBarItem(icon: Icons.map, label: "Map"),
                      SideNavigationBarItem(
                          icon: Icons.query_stats, label: "Stats"),
                      if(true) SideNavigationBarItem(icon: Icons.add, label: "add")
                    ],
                    footer: SideNavigationBarFooter(
                        label: MaterialButton(
                          onPressed: () {controller.changeMainScreen(3);},
                          child: Container(
                            child: Icon(Icons.settings),
                          ),
                        )),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
