class Report {

  //attributes
late int reportId  ;
int? fireId;
String reportStatus="onReview";
late String city,addr,resourceType,resourcePath;
String? audioPath , description;
late double positionLat , positionLong;
late DateTime reportDate;


Report.fromMap(Map<String , dynamic>map){
  reportId=int.parse(map['reportId']);
  fireId=int.tryParse(map['fireId'].toString());
  reportStatus=map['reportStatus'];
  city=map['city'];
  addr=map['addr'];
  resourceType=map['resourceType'];
  resourcePath=map['resourcePath'];
  audioPath=map['audioPath'];
  description=map['description'];
  positionLat=double.parse(map['positionLat']);
  positionLong=double.parse(map['positionLong']);
  reportDate=DateTime.parse(map['reportDate']);
}

@override
  String toString() {
    return """ Report: {
    reportId : $reportId, fireId : $fireId, reportStatus : $reportStatus, reportDate : $reportDate,
    , positionLat : $positionLat, positionLong : $positionLong, 
    city : $city, addr : $addr, 
    resourceType : $resourceType, resourcePath : $resourcePath, audioPath : $audioPath,
     description : $description 
    }""";
  }



}