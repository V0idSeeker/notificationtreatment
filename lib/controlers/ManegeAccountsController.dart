
import 'package:get/get.dart';

import 'package:notificationtreatment/Modules/DatabaseManeger.dart';
import 'package:notificationtreatment/Modules/Report.dart';

class ManegeAccountsController extends GetxController{
DatabaseManeger db =DatabaseManeger();
Map<String , dynamic>data={};
@override
  void onInit() async {
    db= DatabaseManeger();
    super.onInit();
  }
  addUser()async{
  String? result =await db.addUser(data);
  return result;
  }
  
  getinfo()async{
    await  db.latLongToCity(36.72822, 3.32285);
    //await  db.cityToLatLong("Réghaïa");

}




}