class ReportHistory{
  late int reportId,respondentId;
  late String actionType;
  late DateTime actionDate;



  ReportHistory.fromMap(Map<String , dynamic>map){
    reportId=int.parse(map["reportId"]);
    respondentId=int.parse(map["respondentId"]);
    actionType=map["actionType"];
    actionDate=DateTime.parse(map["actionDate"]);
  }

  @override
  String toString() {
    return """ReportHistory :{
    reportId :$reportId ,respondentId :$respondentId,
    actionType :$actionType, actionTime :$actionDate
    }""";
  }
}