class Respondent{
  late int respondentId , infoId;
  late String firstName , lastName , city , username , password , accountStatus;
  late DateTime birthDate;

  Respondent.fromMap(Map<String , dynamic>map){
    respondentId=int.parse(map["respondentId"]);
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
    return """ respondent: {
    respondentId: $respondentId, infoId: $infoId,
    firstName: $firstName, lastName: $lastName, birthDate: $birthDate
    city: $city,
    username: $username, password: $password, accountStatus: $accountStatus
    } """;
  }



}