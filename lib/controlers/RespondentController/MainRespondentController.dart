import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:latlong2/latlong.dart';
import 'package:video_player/video_player.dart';

import '../../Modules/DatabaseManeger.dart';
import '../../Modules/Fire.dart';
import '../../Modules/Report.dart';
import '../../Modules/Respondent.dart';
import '../../views/AccountSettings.dart';
import '../../views/RespondentPages/FiresMap.dart';
import '../../views/RespondentPages/ReportManegment.dart';
import '../../views/Stats.dart';

class MainRespondentController extends GetxController{
  late Respondent respondent;
  late DatabaseManeger db ;
  bool isOptimalFire=true;
  late Widget mainScreen;
  double reportListFraction=0.2;
  late VideoPlayerController videoPlayerController;
  late AudioPlayer audioPlayer =AudioPlayer();

  List<Report>? reportsList=null;
  List<Fire>? activeFiresList=null , allFiresList=null;
  late Report selectedReport;
  MapOptions mapOptions=MapOptions(center: LatLng(0,0) ,zoom: 4);
  MapController mapController=new MapController();
   LatLng respondentCenter=LatLng(0,0);
  setRespondent(Respondent respondent)  {
    this.respondent=respondent;
  }
  @override
  Future<void> onInit() async {
    mainScreen=ReportManagement();
    db=DatabaseManeger();



    super.onInit();
  }
  //interface manegment
  showList(){
    reportListFraction =reportListFraction==0.2 ? 0.3 : 0.2;
    update(["ReportManagement"]);
  }
  void updateInterface(String screenType) {
    if(screenType=="ReportManagement") mainScreen=ReportManagement();
    if(screenType=="Stats") mainScreen=Stats();
    if(screenType=="FireMap")mainScreen=FireMap();
    if(screenType=="AccountSettings"){
      Map<String,dynamic> data=this.respondent.toMap();
      data["accountType"]="respondent";
      mainScreen=AccountSettings(data);
    };
    update(["interface"]);
  }

  //reports manegment

  Future<void>getReports() async {
    if(reportsList==null) {
      reportsList = await db.getRespondentReports(respondent.city);
      update(["ReportList","ReportPositions"]);
    }

  }
  Future<bool> updateReportStatus(String mode)async{
    return await db.updateRespondentReportStatus(selectedReport.reportId ,respondent.personId, mode) ;
  }

  setReportId(int id) async {
    if(id==-1)
      {
        reportsList=await db.getRespondentReports(respondent.city);
        try{ videoPlayerController.dispose();


      }catch(e){
        print(e);
      }
        update(["ReportList","ReportPositions"]); }
    else {
      selectedReport=reportsList![id];
      if(selectedReport.resourceType!="image") {
      try {
        videoPlayerController = VideoPlayerController.networkUrl(
            Uri.http(
                "192.168.1.111" ,"api/${selectedReport.resourcePath}"));
        await videoPlayerController.initialize();
      }catch(e){
        print (e.toString());
    }
      }
      if(selectedReport.audioPath!=null&&selectedReport.audioPath!="null"){


        await audioPlayer.setUrl("http://192.168.1.111/api/"+selectedReport.audioPath.toString());
      }


    }
  }
  Future<void> reportTreatment()async{
    //invalidate
    if(selectedReport.reportStatus=="onReview") return;
    if(selectedReport.reportStatus=="nonValid") {
      await updateReportStatus("nonValid");
    return;
    }

    await updateReportStatus("valid");
    if(selectedReport.fireId==null){

      //validate and new fire
      await addNewFire();
    }else {
      //validate to fire
      await assignToFire(selectedReport.fireId!);
    }






  }

  void validationController (String newStatus){

    bool isInValid=selectedReport.reportStatus!="valid";
    if(selectedReport.reportStatus==newStatus) return;
    selectedReport.reportStatus=newStatus;


    if(isInValid ==(selectedReport.reportStatus=="valid"))
      update(["ReviewReport"]);


  }

// fireManegment
  Future<void> setupFireMap()async{
    await markRespondent();
    allFiresList=await db.getAllLocalFires(respondent.city);
    update(["FiresList","FiresMap"]);

    mapController.move(respondentCenter, 15);

  }
  Future<void> getLocalActiveFires()async {
    activeFiresList = await db.getActiveLocalFires(respondent.city);


  }
  Future<void> addNewFire() async {
    Map<String,dynamic>data =selectedReport.toMap();
    data["optimalPositionLat"]=selectedReport.positionLat;
    data["optimalPositionLong"]=selectedReport.positionLong;
    data["fireStatus"]="active";
    data["optimalAddr"]=selectedReport.addr;
    data["initialDate"]=selectedReport.reportDate;

    await db.addNewFire(Fire.fromMap(data) , selectedReport.reportId);
  }

  Future<void> assignToFire(int fireId) async{
    await db.assignToFire(fireId , selectedReport , isOptimalFire);

  }

//mapManegmen

  Future<void> markRespondent() async {

    if(respondentCenter==LatLng(0,0)) {

      Map<String , dynamic> tmp=await db.cityToLatLang(respondent.city);

      respondentCenter=LatLng(double.parse(tmp["positionLat"]), double.parse(tmp["positionLong"]));
      update(["respondentPosition"]);
    }
    else mapOptions=MapOptions(initialCenter: respondentCenter, initialZoom: 15);
  }

  Future<void> setupReportsMap()async {


    await markRespondent();

    mapController.move(respondentCenter, 15);
  }
  moveMap(LatLng pos){
    mapController.move(pos, 15  );
  }





}