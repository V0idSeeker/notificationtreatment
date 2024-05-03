import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:notificationtreatment/controlers/RespondentController/MainRespondentController.dart';
import 'package:video_player/video_player.dart';

import '../../Modules/Report.dart';

class ReviewReport extends StatelessWidget {
  const ReviewReport({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainRespondentController>(
        id: "ReviewReport",
        init: MainRespondentController(),
        builder: (controller) {
          if (controller.reportsList == null) {
            Get.snackbar("Error", "There Have Been An Error");
            Get.back();
          }

          //TODO: chaba7 audio player

          return Scaffold(
            body: Center(
              child: Container(
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height * 0.8,
                width: MediaQuery.of(context).size.width * 0.8,
                child: SingleChildScrollView(
                    child: Column(
                  children: [
                    TextFormField(
                      readOnly: true,
                      initialValue: controller.selectedReport.city,
                      decoration: InputDecoration(label: Text("City")),
                    ),
                    TextFormField(
                      readOnly: true,
                      initialValue: controller.selectedReport.addr,
                      decoration:
                          InputDecoration(label: Text("Street Address")),
                    ),
                    TextFormField(
                      readOnly: true,
                      initialValue:
                          controller.selectedReport.reportDate.toString(),
                      decoration:
                          InputDecoration(label: Text("Report TimeStamp")),
                    ),
                    TextFormField(
                      readOnly: true,
                      initialValue: controller.selectedReport.description,
                      decoration:
                          InputDecoration(label: Text("Report Description")),
                    ),
                    TextFormField(
                      readOnly: true,
                      initialValue: controller.selectedReport.phoneNumber,
                      decoration:
                          InputDecoration(label: Text("Attached Phone Number")),
                    ),
                    controller.selectedReport.resourceType == "image"
                        ? Container(
                            child: Image.network(
                              "http://192.168.1.111/api/${controller.selectedReport.resourcePath}",
                              fit: BoxFit.cover,
                              width: 400,
                              height: 400,
                            ),
                          )
                        :Stack(
                      alignment: Alignment.bottomCenter,
                            children:[ Container(
                                width: controller.videoPlayerController.value.size.width/2,
                                height:controller.videoPlayerController.value.size.height/2,
                                child: VideoPlayer(
                                    controller.videoPlayerController)),
                            ElevatedButton(onPressed: (){
                              controller.videoPlayerController.value.isPlaying
                                  ? controller.videoPlayerController.pause()
                                  : controller.videoPlayerController.play();
                            }, child: Text("play"))

                            ]
                          ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("Audio Recording"),
                        controller.selectedReport.audioPath.toString() == "null"
                            ? Text("No Audio Included")
                            : ElevatedButton(
                                onPressed: () async {
                                  if(controller.selectedReport.audioPath != null)
                                  controller.audioPlayer.playing
                                      ? controller.audioPlayer.pause()
                                      : controller.audioPlayer.play();
                                },
                                child: Text("play audio"))
                      ],
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: DropdownButtonFormField(
                          value: controller.selectedReport.reportStatus,
                          items: [
                            DropdownMenuItem(
                                value: "onReview", child: Text("On Review")),
                            DropdownMenuItem(
                              value: "nonValid",
                              child: Text("Invalidate"),
                            ),
                            DropdownMenuItem(
                              value: "valid",
                              child: Text("Validate"),
                            ),
                          ],
                          onChanged: (value) {
                            controller.validationController(value.toString());
                          }),
                    ),
                    GetBuilder<MainRespondentController>(
                        id: "addToFire",
                        builder: (controller) {
                          if (controller.selectedReport.reportStatus != "valid")
                            return Container();
                          return Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Row(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.2,
                                  child: DropdownButtonFormField(
                                      items: [
                                        ...controller.activeFiresList!.map((e) =>
                                           DropdownMenuItem(
                                                value: e.fireId,
                                                child: Text(e.optimalAddr))),
                                        DropdownMenuItem(
                                          value: null,
                                          child: Text("New Fire"),
                                        ),
                                      ],
                                      onChanged: (value) {
                                        controller.selectedReport.fireId =
                                            int.tryParse(value.toString());
                                        controller.update(["addToFire"]);
                                      }),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.2,
                                  child: DropdownButtonFormField(
                                    value: controller.selectedReport.fireId == null
                                        ? true
                                        : false,
                                    decoration: InputDecoration(
                                        label: Text("Set As Optimal")),
                                    items: controller.selectedReport.fireId == null
                                        ? [
                                            DropdownMenuItem(
                                                value: true, child: Text("True")),
                                          ]
                                        : [
                                            DropdownMenuItem(
                                                value: true, child: Text("True")),
                                            DropdownMenuItem(
                                                value: false, child: Text("No")),
                                          ],
                                    onChanged: (bool? value) {
                                      controller.isOptimalFire = value!;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                    Row(
                      children: [
                        ElevatedButton(
                            onPressed: () async {
                              await controller.setReportId(-1);
                              controller.activeFiresList = [];
                              Get.back();
                            },
                            child: Text("Return ")),
                        ElevatedButton(
                            onPressed: () async {
                              showDialog(
                                  context: (context),
                                  builder: (context) {
                                    return AlertDialog(
                                        content: Text(
                                            "You sure u wanna Set this Report to : ${controller.selectedReport.reportStatus}? "),
                                        actions: [
                                          ElevatedButton(
                                              onPressed: () {
                                                Get.back();

                                              },
                                              child: Text("No")),
                                          ElevatedButton(
                                              onPressed: () async {
                                                await controller.reportTreatment();
                                                await controller.setReportId(-1);
                                                Get.back();
                                                Get.back();
                                                Get.snackbar("Report Treated", "Report set to ${controller.selectedReport.reportStatus}") ;

                                              },
                                              child: Text("Yes")),
                                        ]);
                                  });
                            },
                            child: Text("Confirm")),
                      ],
                    )
                  ],
                )),
              ),
            ),
          );
        });
  }
}
