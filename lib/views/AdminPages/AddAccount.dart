import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:notificationtreatment/controlers/AdminControlers/MainAdminController.dart';
import 'package:notificationtreatment/views/AdminPages/BrowsAccounts.dart';

class AddAccount extends StatelessWidget {
  const AddAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainAdminController>(
        init: MainAdminController(),
        id: "AddAccount",
        builder: (controller) {
          final formkey = GlobalKey<FormState>();
          TextEditingController city = new TextEditingController(text:controller.addAccountData["city"]),
              date = new TextEditingController(
                  text: controller.addAccountData["birthDate"].toString());
          return Scaffold(
            body: SingleChildScrollView(
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width / 3,
                  height: MediaQuery.of(context).size.height / 1.5,
                  child: Form(
                    key: formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Add Account"),

                        TextFormField(
                          initialValue: controller.addAccountData["lastName"],
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
                          validator: (value) {
                            if (value.toString().length == 0)
                              return "This Field Must Be Filled";
                            if (!RegExp(r'^[A-Za-z0-9 \d]+$')
                                .hasMatch(value.toString()))
                              return "Invalid Charechters";
                            controller.addAccountData["lastName"] =
                                value.toString();
                          },
                        ),
                        TextFormField(
                          initialValue: controller.addAccountData["firstName"],
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
                          validator: (value) {
                            if (value.toString().length == 0)
                              return "This Field Must Be Filled";
                            if (!RegExp(r'^[A-Za-z0-9 \d]+$')
                                .hasMatch(value.toString()))
                              return "Invalid Charechters";
                            controller.addAccountData["firstName"] =
                                value.toString();
                          },
                        ),
                        GetBuilder<MainAdminController>(
                            init: MainAdminController(),
                            id: 'birthDatePicker',
                            builder: (controller) {
                              TextEditingController td =
                                  new TextEditingController(
                                      text: controller
                                          .addAccountData["birthDate"]);
                              return TextFormField(
                                readOnly: true,
                                controller: td,
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
                                onTap: () async {
                                  DateTime? birthDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1950),
                                    lastDate: DateTime(2500),
                                  );
                                  if (birthDate != null) {
                                    controller.addAccountData["birthDate"] =
                                        "${birthDate.year}-${birthDate.month < 10 ? "0" : ""}${birthDate.month}-${birthDate.day < 10 ? "0" : ""}${birthDate.day}";

                                    controller.update(['birthDatePicker']);
                                  }
                                },
                                validator: (value) {
                                  if(value!.isEmpty) return "This field must be filled" ;
                                },
                              );
                            }),
                        TextFormField(
                          controller: city,
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
                          onChanged: (value) {

                            controller.addAccountData["city"] = value;
                          },
                          validator: (value) {
                            if (value.toString().length == 0)
                              return "This Field Must Be Filled";
                            if (!RegExp(r'^[A-Za-z0-9 \d]+$')
                                .hasMatch(value.toString()))
                              return "Invalid Charechters";
                            if (!controller.validCity) return "Invalid City";
                          },
                        ),
                        TextFormField(
                          initialValue: controller.addAccountData["username"],
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
                            controller.addAccountData["username"] =
                                value.toString();
                          },
                          validator: (value) {
                            if (value.toString().length == 0)
                              return "This Field Must Be Filled";
                            if (!RegExp(r'^[A-Za-z0-9 \d]+$')
                                .hasMatch(value.toString()))
                              return "Invalid Charechters";
                            if(!controller.validUsername && controller.isAdd) return "This username is already taken";
                          },
                        ),
                        TextFormField(
                          initialValue: controller.addAccountData["password"],
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
                            controller.addAccountData["password"] =
                                value.toString();
                          },
                          validator: (value) {
                            if (value.toString().length == 0)
                              return "This Field Must Be Filled";
                            if (!RegExp(r'^[A-Za-z0-9 \d]+$')
                                .hasMatch(value.toString()))
                              return "Invalid Charechters";
                            if(!controller.validPassword && controller.isAdd) return "This password is already taken";
                          },
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 5,
                          child: DropdownButtonFormField(
                            value:controller.addAccountData["accountType"].toString(),
                            onChanged: (String? value) {},
                            decoration:
                                InputDecoration(label: Text("Occupation :")),
                            items: [
                              DropdownMenuItem(
                                child: Text("Administrator"),
                                value: 'admin',
                              ),
                              DropdownMenuItem(
                                child: Text("Fire Fighter"),
                                value: 'firefighter',
                              ),
                              DropdownMenuItem(
                                child: Text("Respondent"),
                                value: 'respondent',
                              )
                            ],
                            validator: (value) {
                              controller.addAccountData["accountType"] = value;
                            },
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 5,
                          child: DropdownButtonFormField(
                            value:controller.addAccountData["accountStatus"].toString(),
                            onChanged: (String? value) {},
                            decoration: InputDecoration(
                                label: Text("Account Status :")),
                            items: [
                              DropdownMenuItem(
                                child: Text("Enabled"),
                                value: 'enabled',
                              ),
                              DropdownMenuItem(
                                child: Text("Disabled"),
                                value: 'disabled',
                              ),
                            ],
                            validator: (value) {
                              controller.addAccountData["accountStatus"] =
                                  value;
                            },
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: Text("Return "),
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                await controller.checkCity();
                                if (!formkey.currentState!.validate())
                                  return null;
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return FutureBuilder(
                                          future: controller.manageAccount(),
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
                                            return AlertDialog(
                                              title: Text(
                                                  snapshot.data!? "Account ${ controller.isAdd? "Added" : "Updated"} successfully" :"There have been an error  "  ),
                                              actions: [
                                                ElevatedButton(onPressed: (){controller.update(["AccountList"]);Get.back();Get.back();}, child: Text("Exit"))
                                              ],
                                            );
                                          });
                                    });
                              },
                              child: Text("${ controller.isAdd? "Add" : "Update"} Account "),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}


