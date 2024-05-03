import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notificationtreatment/controlers/AccountSettingsController.dart';
import 'package:notificationtreatment/views/LogIn.dart';

class AccountSettings extends StatelessWidget {
  Map<String,dynamic> passedParams;
  AccountSettings(this.passedParams, {super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountSettingsController>(
        id:"SettingsPage",
        init: AccountSettingsController(passedParams),
        builder: (controller){
          final formkey = GlobalKey<FormState>();
          return SingleChildScrollView(
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width / 3,
                height: MediaQuery.of(context).size.height / 1.5,
                child: Form(
                  key: formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      Text("Settings :", ),

                      TextFormField(
                        readOnly: true,
                        initialValue: controller.accountInfo["lastName"],
                        decoration: InputDecoration(
                          labelText: "Last Name:",
                          border: OutlineInputBorder(
                            // Border for the TextFormField
                            borderSide: BorderSide(
                                color: Colors.grey), // Border color
                            borderRadius: BorderRadius.circular(
                                8.0), // Optional: Border radius
                          ),
                        ),

                      ),
                      TextFormField(
                        readOnly: true,
                        initialValue: controller.accountInfo["firstName"],
                        decoration: InputDecoration(
                          labelText: "First Name:",
                          border: OutlineInputBorder(
                            // Border for the TextFormField
                            borderSide: BorderSide(
                                color: Colors.grey), // Border color
                            borderRadius: BorderRadius.circular(
                                8.0), // Optional: Border radius
                          ),
                        ),
                      ),
                      TextFormField(
                        readOnly: true,
                        initialValue: "${controller.accountInfo["birthDate"].toString().substring(0,10)}",
                        decoration: InputDecoration(
                          labelText: "Birth Date",
                          border: OutlineInputBorder(
                            // Border for the TextFormField
                            borderSide: BorderSide(
                                color: Colors.grey), // Border color
                            borderRadius: BorderRadius.circular(
                                8.0), // Optional: Border radius
                          ),
                        ),
                      ),
                      TextFormField(
                        readOnly: true,
                        initialValue: controller.accountInfo["city"],
                        decoration: InputDecoration(
                          labelText: "City:",
                          border: OutlineInputBorder(
                            // Border for the TextFormField
                            borderSide: BorderSide(
                                color: Colors.grey), // Border color
                            borderRadius: BorderRadius.circular(
                                8.0), // Optional: Border radius
                          ),
                        ),

                      ),
                      TextFormField(
                        initialValue: controller.accountInfo["username"],
                        decoration: InputDecoration(
                          labelText: "UserName:",
                          border: OutlineInputBorder(
                            // Border for the TextFormField
                            borderSide: BorderSide(
                                color: Colors.grey), // Border color
                            borderRadius: BorderRadius.circular(
                                8.0), // Optional: Border radius
                          ),
                        ),
                        onChanged: (value) {
                          controller.accountInfo["username"] =
                              value.toString();
                        },
                        validator: (value) {
                          if (value.toString().length == 0)
                            return "This Field Must Be Filled";
                          if (!RegExp(r'^[A-Za-z0-9 \d]+$')
                              .hasMatch(value.toString()))
                            return "Invalid Charechters";
                          if(!controller.validUsername) return "This username is already taken";
                        },
                      ),
                      TextFormField(
                        initialValue: controller.accountInfo["password"],
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: "Password:",
                          border: OutlineInputBorder(
                            // Border for the TextFormField
                            borderSide: BorderSide(
                                color: Colors.grey), // Border color
                            borderRadius: BorderRadius.circular(
                                8.0), // Optional: Border radius
                          ),
                        ),
                        onChanged: (value) {
                          controller.accountInfo["password"] =
                              value.toString();
                        },
                        validator: (value) {
                          if (value.toString().length == 0)
                            return "This Field Must Be Filled";
                          if (!RegExp(r'^[A-Za-z0-9 \d]+$')
                              .hasMatch(value.toString()))
                            return "Invalid Charechters";
                          if(!controller.validPassword) return "This password is already taken";
                        },
                      ),



                          Center(
                            child: ElevatedButton(
                              onPressed: () async {
                                await controller.checkCity();
                                if (!formkey.currentState!.validate())
                                  return null;
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return FutureBuilder(
                                          future: controller.updateSettings(),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting)
                                              return AlertDialog(
                                                content:
                                                CircularProgressIndicator(),
                                              );
                                            if (snapshot.hasError)
                                              return AlertDialog(
                                                content: Text(
                                                    "error: ${snapshot.error}"),
                                              );
                                            if(snapshot.data==false) return AlertDialog(
                                              title: Text("There Have Been An Error "),
                                              actions: [
                                                ElevatedButton(onPressed: ()=>Get.back(), child: Text("Close"))
                                              ],

                                            );
                                            return AlertDialog(
                                              title: Text( "Account Settings Updated "  ),
                                              content: Text("You will have to log in again "),
                                              actions: [
                                                ElevatedButton(onPressed: (){Get.offAll(()=>LogIn());}, child: Text("Close"))
                                              ],
                                            );
                                          });
                                    });
                              },
                              child: Text("Update Settings "),
                            ),
                          )


                    ],
                  ),
                ),
              ),
            ),
          );


        });
  }
}
