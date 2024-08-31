import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:notificationtreatment/Modules/Styler.dart';

import 'package:notificationtreatment/views/LogIn.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Styler styler= Styler();
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      double minWidth = 1280;
      double minHeight = 1000;
      return  GetMaterialApp(



                title: 'WildFire Desk',
                theme: styler.themeData,
                home: SingleChildScrollView(
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
                    child:SingleChildScrollView(
                      child: Container(
                        width: minWidth,
                        height: minHeight,
                        child:MyHomePage(),),
            ) ,
          ),
        )
              )
            ;

    },);
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {


      return LogIn();
    }

  }

