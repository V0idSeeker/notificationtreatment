class Respondent{
  late int id;
  late String username,password,name;
  late bool isManager;
  late double positionLat,positionLong;

  Respondent.fromMap(Map<String, dynamic> map ){
    this.username=map["username"].toString();
    this.password=map["password"].toString();
    this.name=map["name"].toString();
    this.positionLat=double.parse(map["positionLat"].toString());
    this.positionLong=double.parse(map["positionLong"].toString());

    if(map["isManager"].toString()=="1") this.isManager=true;
    else if(map["isManager"].toString()=="0") this.isManager=false;
    else this.isManager=bool.parse(map["isManager"].toString());
  }



}