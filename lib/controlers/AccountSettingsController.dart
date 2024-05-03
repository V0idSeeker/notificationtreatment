import 'package:get/get.dart';

import '../Modules/DatabaseManeger.dart';

class AccountSettingsController extends GetxController{
  late Map<String , dynamic > accountInfo;
  late DatabaseManeger db;
  bool validUsername=true , validPassword=true;




  AccountSettingsController(this.accountInfo);

  @override
  onInit(){
    db=new DatabaseManeger();
    super.onInit();
  }




  checkCity()async {
    Map<String , dynamic> result=await db.infoChecker(null , accountInfo["username"] , accountInfo["password"] , accountInfo["personId"].toString());
    validUsername=bool.parse(result["usernameAvilability"].toString());
    validPassword=bool.parse(result["passwordAvilability"].toString());
  }

  Future<bool> updateSettings() async {
    var t=accountInfo;
    t["personId"]=accountInfo["personId"].toString();
    t["birthDate"]=accountInfo["birthDate"].toString();

    return await db.updateAccount(t);
  }


}