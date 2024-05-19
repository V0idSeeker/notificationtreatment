
import 'dart:async';

import 'package:get/get.dart';
import 'package:notificationtreatment/Modules/DatabaseManeger.dart';
import 'package:notificationtreatment/Modules/Styler.dart';
import 'package:notificationtreatment/views/AdminPages/BrowsAccounts.dart';
import "package:flutter/material.dart";
import '../../Modules/Admin.dart';
import '../../views/AccountSettings.dart';
import '../../views/LogIn.dart';
import '../../views/Stats.dart';

class MainAdminController extends GetxController{
  late DatabaseManeger db ;
late Widget mainScreen;
Styler styler= Styler();
  int index=0;
late String searchParam , searchValue , searchCategory;
bool validCity=false , validUsername =false , validPassword =false , isAdd=false , isConnected=true;
late Admin admin;
Map<String , dynamic> addAccountData={};

@override
  void onInit() {
  db = DatabaseManeger();
  searchValue="";searchCategory="all";searchParam="lastName";
  addAccountData={
    "firstName":"",
    "lastName":"",
    "username":"",
    "birthDate":"Not Selected",
    "password":"",
    "city":"",
    "accountStatus":"enabled",
    "accountType":"admin"
  };

  mainScreen = BrowsAccounts();
    super.onInit();
  }

  Future<void> cnx() async {
    bool t = await db.connectionStatus();

    if (isConnected != t) isConnected = t;
    Timer.periodic(Duration(milliseconds: 400), (Timer timer) async {
      t = await db.connectionStatus();


      if (isConnected != t) {
        print("change");
        isConnected = t;
        if (!isConnected) {
          timer.cancel();
          styler.showSnackBar("You have been disconnected", "Connection issue");
          Get.offAll(() => LogIn());
        }
      }
    });
  }
  setAdmin(Admin admin){
    this.admin=admin;
  }


  resetAddData(){
    addAccountData={
      "firstName":"",
      "lastName":"",
      "username":"",
      "birthDate":"Not Selected",
      "password":"",
      "city":"",
      "accountStatus":"enabled",
      "accountType":"admin"
    };
  }



  updateSearch(String searchParam,String searchValue,String searchCategory){
  if(searchParam==this.searchParam && searchValue==this.searchValue && searchCategory==this.searchCategory) return null;
  this.searchParam=searchParam;
  this.searchValue=searchValue;
  this.searchCategory=searchCategory;

  update(["AccountList"]);

}

  void updateInterface(String screenType) {
  if(screenType=="BrowsAccounts") {
      mainScreen = BrowsAccounts();
  index=0;
  }
    if(screenType=="Stats") {
      mainScreen = Stats();
    index=1;
    }
    if(screenType=="AccountSettings"){
      index=2;
    Map<String,dynamic> data=this.admin.toMap();
    data["accountType"]="admin";
    mainScreen=AccountSettings(data);
  };

    update();
  }


  checkCity()async {
   Map<String , dynamic> result=await db.infoChecker(addAccountData["city"].toString() , addAccountData["username"] , addAccountData["password"] , addAccountData["personId"].toString());
   validCity=result["city"]!=null ;
   if(validCity)addAccountData["city"]=result["city"];
   validUsername=bool.parse(result["usernameAvilability"].toString());
   validPassword=bool.parse(result["passwordAvilability"].toString());
}


  Future<bool>manageAccount() async{
   var x;
   if(isAdd) x= await addAccount();
   else x= await  updateAccount();
   return x;
  }
  Future<List> getAccounts()async{
  return await db.getAllAccounts(searchParam, searchValue, searchCategory);

  }

  Future<bool> addAccount()async {
  bool x= await db.addAccount(addAccountData);
  return x;

  }
  Future<bool> updateAccount()async {
  bool x =await db.updateAccount(addAccountData);
return x;
  }

  deleteAccount(String id) async{
  Map<String , dynamic> result =await db.deleteAccount(int.parse(id));
  return result["success"]=="true" ;

  }

  }



