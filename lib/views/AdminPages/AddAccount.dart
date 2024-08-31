import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notificationtreatment/Modules/Styler.dart';
import 'package:notificationtreatment/controlers/AdminControlers/MainAdminController.dart';
import 'package:notificationtreatment/views/AdminPages/BrowsAccounts.dart';

class AddAccount extends StatelessWidget {
  const AddAccount({super.key});

  @override
  Widget build(BuildContext context) {
    Styler styler = Styler();
    return GetBuilder<MainAdminController>(
      init: MainAdminController(),
      id: "AddAccount",
      builder: (controller) {
        final formkey = GlobalKey<FormState>();
        TextEditingController city =
            TextEditingController(text: controller.addAccountData["city"]);
        TextEditingController date = TextEditingController(
            text: controller.addAccountData["birthDate"].toString());
        return Scaffold(
          backgroundColor: styler.themeData.scaffoldBackgroundColor,
          body: Container(
            decoration: styler.orangeBlueBackground(),
            child: Center(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  width: MediaQuery.of(context).size.width / 3,
                  height: MediaQuery.of(context).size.height / 1.5,
                  decoration: styler.containerDecoration(),
                  child: Form(
                    key: formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Add Account",
                          style: styler.themeData.textTheme.headlineMedium,
                        ),
                        TextFormField(
                          initialValue: controller.addAccountData["lastName"],
                          decoration: styler.inputDecoration("Last Name"),
                          validator: (value) {
                            if (value.toString().length == 0)
                              return "This Field Must Be Filled";
                            if (!RegExp(r'^[A-Za-z0-9 \d]+$')
                                .hasMatch(value.toString()))
                              return "Invalid Characters";
                            controller.addAccountData["lastName"] =
                                value.toString();
                            return null;
                          },
                        ),
                        TextFormField(
                          initialValue: controller.addAccountData["firstName"],
                          decoration: styler.inputDecoration("First Name"),
                          validator: (value) {
                            if (value.toString().length == 0)
                              return "This Field Must Be Filled";
                            if (!RegExp(r'^[A-Za-z0-9 \d]+$')
                                .hasMatch(value.toString()))
                              return "Invalid Characters";
                            controller.addAccountData["firstName"] =
                                value.toString();
                            return null;
                          },
                        ),
                        GetBuilder<MainAdminController>(
                          init: MainAdminController(),
                          id: 'birthDatePicker',
                          builder: (controller) {
                            TextEditingController td = TextEditingController(
                                text: controller.addAccountData["birthDate"]);
                            return TextFormField(
                              readOnly: true,
                              controller: td,
                              decoration: styler.inputDecoration("Birth Date"),
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
                                if (value!.isEmpty)
                                  return "This field must be filled";
                                return null;
                              },
                            );
                          },
                        ),
                        TextFormField(
                          controller: city,
                          decoration: styler.inputDecoration("City"),
                          onChanged: (value) {
                            controller.addAccountData["city"] = value;
                          },
                          validator: (value) {
                            if (value.toString().length == 0)
                              return "This Field Must Be Filled";
                            if (!RegExp(r'^[A-Za-z0-9 \d]+$')
                                .hasMatch(value.toString()))
                              return "Invalid Characters";
                            if (!controller.validCity) return "Invalid City";
                            return null;
                          },
                        ),
                        TextFormField(
                          initialValue: controller.addAccountData["username"],
                          decoration: styler.inputDecoration("Username"),
                          onChanged: (value) {
                            controller.addAccountData["username"] =
                                value.toString();
                          },
                          validator: (value) {
                            if (value.toString().length == 0)
                              return "This Field Must Be Filled";
                            if (!RegExp(r'^[A-Za-z0-9 \d]+$')
                                .hasMatch(value.toString()))
                              return "Invalid Characters";
                            if (!controller.validUsername && controller.isAdd)
                              return "This username is already taken";
                            return null;
                          },
                        ),
                        TextFormField(
                          initialValue: controller.addAccountData["password"],
                          obscureText: true,
                          decoration: styler.inputDecoration("Password"),
                          onChanged: (value) {
                            controller.addAccountData["password"] =
                                value.toString();
                          },
                          validator: (value) {
                            if (value.toString().length == 0)
                              return "This Field Must Be Filled";
                            if (!RegExp(r'^[A-Za-z0-9 \d]+$')
                                .hasMatch(value.toString()))
                              return "Invalid Characters";
                            if (!controller.validPassword && controller.isAdd)
                              return "This password is already taken";
                            return null;
                          },
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 5,
                          child: DropdownButtonFormField(
                            value: controller.addAccountData["accountType"]
                                .toString(),
                            onChanged: (String? value) {
                              controller.addAccountData["accountType"] = value;
                            },
                            decoration: styler.dropdownDecoration("Occupation"),
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
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 5,
                          child: DropdownButtonFormField(
                            value: controller.addAccountData["accountStatus"]
                                .toString(),
                            onChanged: (String? value) {
                              controller.addAccountData["accountStatus"] = value;
                            },
                            decoration:
                                styler.dropdownDecoration("Account Status"),
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
                              controller.addAccountData["accountStatus"] = value;
                              return null;
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
                              style: styler.elevatedButtonStyle(),
                              child: Text("Return"),
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                styler.showDialogUnRemoved(title: "Wait", content: LinearProgressIndicator(), actions: []);
                                await controller.checkCity();
                                if (!formkey.currentState!.validate())
                                  return null;
                                Get.back();

                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (context) {
                                    return PopScope(
                                      canPop:false,
                                      child: FutureBuilder(
                                        future: controller.manageAccount(),
                                        builder: (context, snapshot) {

                                          if (snapshot.connectionState == ConnectionState.waiting) {
                                            return AlertDialog(
                                              title: Text("Please wait"),
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  CircularProgressIndicator(),
                                                  SizedBox(height: 16),
                                                  Text("Processing your request...")
                                                ],
                                              ),
                                            );
                                          }
                                          if (snapshot.hasError) {
                                            return AlertDialog(
                                              title: Text("Error"),
                                              content: Text("An error occurred: ${snapshot.error}"),
                                              actions: [
                                                ElevatedButton(
                                                  onPressed: () {
                                                    Get.back(); // Close the dialog
                                                  },
                                                  child: Text("OK"),
                                                  style: styler.elevatedButtonStyle(),
                                                )
                                              ],
                                            );
                                          }
                                          return AlertDialog(
                                            title: Text(snapshot.data!
                                                ? "Success"
                                                : "Failure"),
                                            content: Text(snapshot.data!
                                                ? "Account ${controller.isAdd ? "Added" : "Updated"} successfully"
                                                : "There has been an error"),
                                            actions: [
                                              ElevatedButton(
                                                onPressed: () {
                                                  controller.update(["AccountList"]);
                                                  Get.back(); // Close the dialog
                                                  Get.back(); // Navigate back
                                                },
                                                child: Text("Exit"),
                                                style: styler.elevatedButtonStyle(),
                                              )
                                            ],
                                          );
                                        },
                                      ),
                                    );
                                  },
                                );
                              },
                              style: styler.elevatedButtonStyle(),
                              child: Text(
                                  "${controller.isAdd ? "Add" : "Update"} Account"),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
