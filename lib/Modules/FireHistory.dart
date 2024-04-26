class FireHistory {
late int fireId,fireFighterId;
late String actionType;
late DateTime actionDate;



FireHistory.fromMap(Map<String , dynamic>map){
  fireId=int.parse(map["fireId"]);
  fireFighterId=int.parse(map["fireFighterId"]);
  actionType=map["actionType"];
  actionDate=DateTime.parse(map["actionDate"]);
}

 @override
  String toString() {
    return """FireHistory :{
    fireId :$fireId ,fireFighterId :$fireFighterId,
    actionType :$actionType, actionTime :$actionDate
    }""";
  }






}