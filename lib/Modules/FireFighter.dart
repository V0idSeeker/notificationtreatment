class FireFighter{
  late int fireFighterId , infoId;
  late String firstName , lastName , city , username , password , accountStatus;
  late DateTime birthDate;

  FireFighter.fromMap(Map<String , dynamic>map){
    fireFighterId=int.parse(map["adminId"]);
    infoId=int.parse(map["infoId"]);
    firstName=map["firstName"];
    lastName=map["lastName"];
    city=map["city"];
    username=map["username"];
    password=map["password"];
    accountStatus=map["accountStatus"];
    birthDate=DateTime.parse(map["birthDate"]);
  }

  @override
  String toString() {
    return """ Admin: {
    fireFighterId: $fireFighterId, infoId: $infoId,
    firstName: $firstName, lastName: $lastName, birthDate: $birthDate
    city: $city,
    username: $username, password: $password, accountStatus: $accountStatus
    } """;
  }


}