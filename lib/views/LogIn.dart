import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notificationtreatment/Modules/Admin.dart';
import 'package:notificationtreatment/Modules/Respondent.dart';
import 'package:notificationtreatment/Modules/Styler.dart';
import 'package:notificationtreatment/views/AdminPages/MainAdminPage.dart';
import 'package:notificationtreatment/controlers/LogInControler.dart';
import 'package:notificationtreatment/views/RespondentPages/MainRespondentInterface.dart';

class LogIn extends StatelessWidget {
  const LogIn({super.key});

  @override
  Widget build(BuildContext context) {
    Styler styler = Styler();
    return GetBuilder<LogInControler>(
        init: LogInControler(),
        builder: (controller) {
          final formkey = GlobalKey<FormState>();

          return Scaffold(

            body: Container(
              decoration:styler.orangeBlueBackground(),
              child: Center(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(vertical: 8,horizontal: 20),
                  child: Container(
                    width: 400.0, // Limit the width
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color:Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Form(
                      key: formkey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //Logo
                          Image.asset('logo.png',
                            height: 400,
                          ),
                          SizedBox(height: 20.0),
                          // Welcome Text
                          Text(
                            'WildFire Desk',
                            style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: Theme.of(context).hintColor),
                          ),
                          SizedBox(height: 80.0),
                          //Username
                          TextFormField(
                            decoration: styler.inputFormTextFieldDecoration("Username"),
                            validator: (value) {
                              if (value!.isEmpty)
                                return "Invalid Username";
                              else
                                controller.username = value;
                            },
                          ),
                          SizedBox(height: 20.0),
                          //Password
                          TextFormField(
                            obscureText: true,
                            decoration: styler.inputFormTextFieldDecoration("Password"),
                            validator: (value) {
                              if (value!.isEmpty)
                                return "Invalid Password";
                              else
                                controller.password = value;
                            },
                          ),
                          SizedBox(height: 20.0),
                          ElevatedButton(
                            onPressed: () async {
                              if (!formkey.currentState!.validate())
                                return null;
                              await controller.cnx();

                              if(!controller.isConnected){
                                styler.showSnackBar("Connection Issues", "No Connection To The Server");


                                return null;
                              }

                              Map<String , dynamic> data = await controller.logIn();
                              if (data["Error"]!=null || data["accountStatus"]=="disabled")
                                styler.showSnackBar("Error Logging in", data["Error"]!=null ? data["Error"] : "Account is disabled");

                              else {
                                if(data["accountType"]=="admin") {
                                  Admin admin=Admin.fromMap(data);
                                  Get.offAll(()=>MainAdminPage(admin));
                                }
                                if(data["accountType"]=="respondent"){
                                  Respondent respondent = Respondent.fromMap(data);
                                  Get.offAll(()=>MainRespondentInterface(respondent));

                                }
                                if(data["accountType"]=="firefighter"){
                                  styler.showSnackBar("Access Denied","Access to Fire Fighter is Only Available throw the Mobile App");


                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).primaryColor,
                              padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            child: Text("Login",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            floatingActionButton: ElevatedButton(
              style: styler.dialogButtonStyle(),

              onPressed: () {
                String val=controller.getIp();
                styler.showDialogUnRemoved(title:"Change Ip address",
                    content:TextFormField(
                      decoration:styler.inputFormTextFieldDecoration("Ip address"),
                      style: TextStyle(color: Get.theme.textTheme.bodyMedium?.color),
                      initialValue: val,
                      onChanged: (value){
                        val=value;
                      },
                    ),
                    actions :[
                      ElevatedButton(
                          style: styler.dialogButtonStyle(),
                          onPressed: ()=>Get.back(),
                          child: Text("Cancel")),
                      ElevatedButton(
                          onPressed: (){
                            bool changed=controller.changeIp(val);
                            if(!changed){
                              Get.snackbar("invalid Ip" ,"Ip Not Valid",
                                  backgroundColor: Theme.of(context).primaryColor,
                                  colorText: Theme.of(context).colorScheme.background,
                                  borderRadius: 10,
                                  margin: EdgeInsets.all(16),
                                  duration: Duration(seconds: 3),
                                  icon: Icon(
                                    Icons.error_outline,
                                    color: Theme.of(context).colorScheme.background,
                                  ),
                                  snackStyle: SnackStyle.FLOATING,
                                  overlayBlur: 0.2,
                                  overlayColor: Colors.black.withOpacity(0.3),
                                  barBlur: 10,
                                  isDismissible: true,
                                  forwardAnimationCurve: Curves.easeOutBack,
                                  reverseAnimationCurve: Curves.easeInBack,

                                  showProgressIndicator: true
                              );
                            }else{
                              Get.back();
                              Get.snackbar("Ip Changed",'',backgroundColor: Theme.of(context).primaryColor,
                                  colorText: Theme.of(context).colorScheme.background,
                                  borderRadius: 10,
                                  margin: EdgeInsets.all(16),
                                  duration: Duration(seconds: 3),
                                  icon: Icon(
                                    Icons.error_outline,
                                    color: Theme.of(context).colorScheme.background,
                                  ),
                                  snackStyle: SnackStyle.FLOATING,
                                  overlayBlur: 0.2,
                                  overlayColor: Colors.black.withOpacity(0.3),
                                  barBlur: 10,
                                  isDismissible: true,
                                  forwardAnimationCurve: Curves.easeOutBack,
                                  reverseAnimationCurve: Curves.easeInBack,

                                  showProgressIndicator: true );


                            }

                          },
                          style: styler.dialogButtonStyle(),
                          child: Text("Submit")),
                    ]
                    );

              },
              child: Text("Change Ip"),


            ),
          );
        });
  }
}
