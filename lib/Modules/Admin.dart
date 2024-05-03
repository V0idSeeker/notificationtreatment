class Admin{
  late int  personId;
  late String firstName , lastName , city , username , password , accountStatus;
  late DateTime birthDate;
  
  Admin.fromMap(Map<String , dynamic>map){
    personId=int.parse(map["personId"]);
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
    personId: $personId, 
    firstName: $firstName, lastName: $lastName, birthDate: $birthDate
    city: $city,
    username: $username, password: $password, accountStatus: $accountStatus
    } """;
  }
  Map<String,dynamic> toMap() {
    return {
      "personId": personId,
      "firstName": firstName,
      "lastName": lastName,
      "city": city,
      "username": username,
      "password": password,
      "accountStatus": accountStatus,
      "birthDate": birthDate
    };
  }


}