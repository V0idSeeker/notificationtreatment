class Respondent{
  late int id;
  late String username,password,name;
  late bool isManeger;
  late double positionLat,positionLong;

  Respondent.fromMap(Map<String, dynamic> map ){
    this.username=map["username"].toString();
    this.password=map["password"].toString();
    this.name=map["name"].toString();

  }


}