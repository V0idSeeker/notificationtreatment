


class Fire {
  late int fireId;
  late String city ,fireStatus="active";
  DateTime? initialDate=DateTime.now() ,finalDate;



Fire.fromMap(Map<String,dynamic> map){
  fireId=int.parse(map["fireId"]);
  city=map["city"];
  fireStatus=map["fireStatus"];
  initialDate=DateTime.parse(map["initialDate"]);
  finalDate=DateTime.tryParse(map["finalDate"].toString());
}




  @override
  String toString() {

    return """ Fire :{
    fireId: $fireId,city: $city,
    fireStatus: $fireStatus,
    initialDate: $initialDate, finalDate: $finalDate,
    }""";
  }

}