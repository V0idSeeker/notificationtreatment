import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:latlong2/latlong.dart';
import 'package:notificationtreatment/Modules/Styler.dart';
import 'package:video_player/video_player.dart';

import '../../Modules/DatabaseManeger.dart';
import '../../Modules/Fire.dart';
import '../../Modules/Report.dart';
import '../../Modules/Respondent.dart';
import '../../views/AccountSettings.dart';
import '../../views/LogIn.dart';
import '../../views/RespondentPages/FiresMap.dart';
import '../../views/RespondentPages/ReportManegment.dart';
import '../../views/Stats.dart';

class MainRespondentController extends GetxController{
  late Respondent respondent;
  late DatabaseManeger db ;
  bool isOptimalFire=true ,isConnected=true ;
  int index=0;
  late Widget mainScreen;
  double reportListFraction=0.2;
  late VideoPlayerController videoPlayerController;
  late AudioPlayer audioPlayer =AudioPlayer();
  final Styler styler = Styler();

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
  dispose() async {

    super.dispose();
  }
  Future<void> cnx() async {
    bool t = await db.connectionStatus();

    if(isConnected!=t)isConnected=t;
    Timer.periodic(Duration(milliseconds: 400), (Timer timer) async {

       t = await db.connectionStatus();


      if(isConnected!=t){

        print("change");
        isConnected=t;
        if(!isConnected) {
          timer.cancel();

          styler.showSnackBar("You have been disconected", "Connection issue");
          Get.offAll(() => LogIn());

        }
      }
    });

  }
  //interface manegment
  showList(){
    reportListFraction =reportListFraction==0.2 ? 0.3 : 0.2;
    update(["ReportManagement"]);
  }
  void updateInterface(String screenType) {
    if(screenType=="ReportManagement"){ mainScreen=ReportManagement();index=0;}
    if(screenType=="FireMap") {
      mainScreen = FireMap();
      index = 1;
    }
    if(screenType=="Stats") {
      mainScreen = Stats();
      index = 2;
    }

    if(screenType=="AccountSettings"){
      Map<String,dynamic> data=this.respondent.toMap();
      data["accountType"]="respondent";
      index=3;
      mainScreen=AccountSettings(data);
    };
    update();
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

      if(selectedReport.audioPath!=null&&selectedReport.audioPath!="null"){


        await audioPlayer.setUrl("http://192.168.1.111/api/"+selectedReport.audioPath.toString());
      }


    }

  }

  Future <void> setVideoPlayer()async{
    videoPlayerController = VideoPlayerController.networkUrl(
        Uri.http(
            "192.168.1.111" ,"api/${selectedReport.resourcePath}"));

    await videoPlayerController.initialize();

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
      update(["addToFire"]);


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