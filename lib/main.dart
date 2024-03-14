import 'package:flutter/material.dart';
import 'package:notificationtreatment/controlers/LogInControler.dart';
import 'package:notificationtreatment/interfaces/LogIn.dart';
import 'package:provider/provider.dart';

import 'controlers/HomeControler.dart';
import 'interfaces/Home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [

      ChangeNotifierProvider(create: (context)=> LogInControler()),
      ChangeNotifierProvider(create: (context)=> HomeControler())
    ],
    builder: (context,child){
      return LogIn();
    }
    );
  }
}
