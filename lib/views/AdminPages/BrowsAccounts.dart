import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notificationtreatment/controlers/AdminControlers/MainAdminController.dart';
import 'package:notificationtreatment/views/AdminPages/AddAccount.dart';

class BrowsAccounts extends StatelessWidget {
  const BrowsAccounts({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainAdminController>(
        init: MainAdminController(),
        id: "browsPage",
        builder: (controller) {

          return Container(
            padding: EdgeInsets.all(8),
            alignment: Alignment.topCenter,
            child: Container(
                alignment: Alignment.topCenter,
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          // searsh top
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 8,
                              child: DropdownButtonFormField(
                                decoration:
                                    InputDecoration(label: Text("Category :")),
                                value: "all",
                                items: [
                                  DropdownMenuItem(
                                      value: "all",
                                      child: Text("All accounts")),
                                  DropdownMenuItem(
                                      value: "admin",
                                      child: Text("Administrators")),
                                  DropdownMenuItem(
                                      value: "firefighter",
                                      child: Text("Fire Fighters")),
                                  DropdownMenuItem(
                                      value: "respondent",
                                      child: Text("Respondents"))
                                ],
                                onChanged: (String? value) {
                                  controller.updateSearch(controller.searchParam, controller.searchValue, value.toString());

                                },
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 5,
                              child: TextFormField(
                                decoration:
                                    InputDecoration(label: Text("SearchBar")),
                                onChanged: (value) {
                                  if (!RegExp(r'^\s+$').hasMatch(value))
                                  controller.updateSearch(controller.searchParam, value, controller.searchCategory);
                                },
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 8,
                              child: DropdownButtonFormField(

                                decoration: InputDecoration(
                                    label: Text("Search Param:")),
                                value: "lastName",
                                items: [
                                  DropdownMenuItem(
                                      value: "lastName",
                                      child: Text("Last Name")),
                                  DropdownMenuItem(
                                      value: "city", child: Text("City")),
                                ],
                                onChanged: (String? value) {
                                  controller.updateSearch(value.toString(), controller.searchValue, controller.searchCategory);
                                },
                              ),
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  controller.resetAddData();
                                  controller.isAdd=true;
                                  Get.to(()=>AddAccount());},
                                child: Text("Add New Account"))
                          ],
                        ),
                      ),
                      GetBuilder<MainAdminController>(
                        id:"AccountList",
                        builder: (controller) {
                          return Container(
                            width: MediaQuery.of(context).size.width*0.8,
                            child: FutureBuilder(future: controller.getAccounts(), builder: (context, snapshot){
                              if(snapshot.connectionState==ConnectionState.waiting)return Center(child: CircularProgressIndicator(),);
                              if(snapshot.hasError) return Center(child: Text("error: ${snapshot.error}"),);
                              if(snapshot.data?.length==0) return Center(child: Text("No Accounts "));
                              return Column(
                                children: [
                                  Container(
                                    height: MediaQuery.of(context).size.height/20,
                                    child: Row(
                                      children: [Expanded(child: Text("First Name")),VerticalDivider(), Expanded(child: Text("Last Name")) ,VerticalDivider(),Expanded(child: Text("City")) ,VerticalDivider(), Expanded(child: Text("Account Type" )),VerticalDivider(), Expanded(child: Text("Edit")),VerticalDivider(), Expanded(child: Text("Delete"))] , ),
                                  ),
                                  Divider(),
                                  Container(
                                    height: MediaQuery.of(context).size.height/1.3,
                                    child: ListView.separated( separatorBuilder: (context , index )=>Divider(),
                                        itemCount: snapshot.data!.length ,
                                        itemBuilder:(context , index ){
                                      dynamic row=snapshot.data![index];
                                      return Row(
                                        //ToDo: make sure if long text no overlap
                                        children: [

                                          Expanded(child: Text(row["lastName"])),VerticalDivider(),
                                          Expanded(child: Text(row["firstName"])),
                                          VerticalDivider(),
                                          Expanded(child: Text(row["city"])),VerticalDivider(),
                                          Expanded(child: Text(row["accountType"])),VerticalDivider(),
                                          Expanded(child: ElevatedButton(onPressed: (){
                                            controller.addAccountData=row;
                                            controller.isAdd=false;
                                            Get.to(()=>AddAccount());

                                          }, child: Icon(Icons.edit))),VerticalDivider(),
                                          Expanded(child: ElevatedButton(onPressed: (){
                                            if(row["personId"]==controller.admin.personId.toString())
                                              showDialog(context: (context), builder: (context){

                                                return AlertDialog(
                                                  title: Text("Error"),
                                                  content: Text("personal can't delete his own account"),
                                                  actions: [
                                                    ElevatedButton(onPressed: (){Get.back();}, child: Text("Close"))
                                                  ],
                                                );
                                              });
                                            else showDialog(context: context, builder: (context){

                                              return AlertDialog(
                                                title: Text("Are you sure ?"),
                                                content: Text("${row["lastName"]} ${row["firstName"]} account will be deleted "),
                                                actions: [
                                                  ElevatedButton(onPressed: ()=>Get.back(), child: Text("Cancel")),
                                                  ElevatedButton(onPressed: ()async{
                                                    Get.back();
                                                    await controller.deleteAccount(row["personId"]);
                                                    Get.snackbar("Account Deleted", "${row["lastName"]} ${row["firstName"]} has been deleted");
                                                    controller.update(["AccountList"]);

                                                  }, child: Text("Delete")),],
                                              );

                                            });


                                          }, child: Icon(Icons.delete))),
                                        ],
                                      );

                                        }),
                                  ),
                                ],
                              );


                            }),
                          );
                        }
                      )
                    ])),
          );
        });
  }
}
