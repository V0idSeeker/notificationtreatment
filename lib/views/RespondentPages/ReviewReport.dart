import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:notificationtreatment/Modules/Styler.dart';
import 'package:notificationtreatment/controlers/RespondentController/MainRespondentController.dart';
import 'package:video_player/video_player.dart';


class ReviewReport extends StatelessWidget {
  ReviewReport({super.key});
  final styler= Styler();
  @override
  Widget build(BuildContext context) {

    return GetBuilder<MainRespondentController>(
      id: "ReviewReport",
      init: MainRespondentController(),
      builder: (controller) {
        if (controller.reportsList == null) {
          Get.snackbar("Error", "There Has Been An Error");
          Get.back();
          return Container();
        }

        return Scaffold(

          body: Container(
            decoration:styler.orangeBlueBackground(),
            child: Center(
              child: Container(

                alignment: Alignment.center,
                padding: EdgeInsets.all(16.0),
                height: MediaQuery.of(context).size.height * 0.8,
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: styler.containerDecoration(),
                child: SingleChildScrollView(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            _buildInfoCard(controller),
                            _buildDropdownButton(controller),
                            _buildFireAssignmentSection(controller),
                            _buildActionButtons(controller),

                          ],
                        ),
                      ),
                      SizedBox(width: 30),
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            _buildImageOrVideoCard(controller),
                            _buildAudioSection(controller),

                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoCard(MainRespondentController controller) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            if (controller.selectedReport.city != null)
              _buildReadOnlyTextField(controller.selectedReport.city, "City"),
            if (controller.selectedReport.addr != null)
              _buildReadOnlyTextField(controller.selectedReport.addr, "Street Address"),
            if (controller.selectedReport.reportDate != null)
              _buildReadOnlyTextField(controller.selectedReport.reportDate.toString(), "Report TimeStamp"),
            if (controller.selectedReport.description != null)
              _buildReadOnlyTextField(controller.selectedReport.description, "Report Description"),
            if (controller.selectedReport.phoneNumber != null)
              _buildReadOnlyTextField(controller.selectedReport.phoneNumber, "Attached Phone Number"),
          ],
        ),
      ),
    );
  }

  Widget _buildReadOnlyTextField(String? initialValue, String label) {
    if (initialValue == null) {
      return Container();
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        readOnly: true,
        initialValue: initialValue,
        decoration: styler.inputDecoration(label),
      ),
    );
  }

  Widget _buildImageOrVideoCard(MainRespondentController controller) {
    return controller.selectedReport.resourceType == "image"
        ? _buildImageCard(controller.selectedReport.resourcePath)
        : _buildVideoCard(controller);
  }

  Widget _buildImageCard(String resourcePath) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Container(
        height: 600,
        padding: const EdgeInsets.all(16.0),
        child: Image.network(
          "http://192.168.1.111/api/$resourcePath",
          fit: BoxFit.fitHeight,

        ),
      ),
    );
  }

  Widget _buildVideoCard(MainRespondentController controller) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder(
          future: controller.setVideoPlayer(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) return CircularProgressIndicator();
            if (snapshot.hasError) return Text(snapshot.error.toString());
            return Column(
              children: [
                SizedBox(
                  height: 600,
                  child: AspectRatio(
                    aspectRatio: controller.videoPlayerController.value.aspectRatio,
                    child: VideoPlayer(controller.videoPlayerController),
                  ),
                ),
                VideoProgressIndicator(controller.videoPlayerController, allowScrubbing: true),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      icon: Icon(
                        controller.videoPlayerController.value.isPlaying ? Icons.pause : Icons.play_arrow,
                        color: styler.secondaryColor,
                      ),
                      onPressed: () {
                        controller.videoPlayerController.value.isPlaying
                            ? controller.videoPlayerController.pause()
                            : controller.videoPlayerController.play();
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.stop, color: styler.secondaryColor),
                      onPressed: () {
                        controller.videoPlayerController.seekTo(Duration.zero);
                        controller.videoPlayerController.pause();
                      },
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildAudioSection(MainRespondentController controller) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("Audio Recording", style: styler.labelTextStyle()),
            controller.selectedReport.audioPath.toString() == "null"
                ? Text("No Audio Included", style: styler.labelTextStyle())
                : ElevatedButton(
              onPressed: () async {
                if (controller.selectedReport.audioPath != null)
                  controller.audioPlayer.playing
                      ? controller.audioPlayer.pause()
                      : controller.audioPlayer.play();
              },
              style: styler.elevatedButtonStyle(),
              child: Text(controller.audioPlayer.playing ? "Pause Audio" : "Play Audio"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownButton(MainRespondentController controller) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: DropdownButtonFormField(
          value: controller.selectedReport.reportStatus,
          items: [
            DropdownMenuItem(value: "onReview", child: Text("On Review")),
            DropdownMenuItem(value: "nonValid", child: Text("Invalidate")),
            DropdownMenuItem(value: "valid", child: Text("Validate")),
          ],
          onChanged: (value) {
            controller.validationController(value.toString());
          },
          decoration: styler.inputDecoration("Report Status"),
        ),
      ),
    );
  }

  Widget _buildFireAssignmentSection(MainRespondentController controller) {
    return GetBuilder<MainRespondentController>(
      id: "addToFire",
      builder: (controller) {
        if (controller.selectedReport.reportStatus != "valid") return Padding(padding: EdgeInsets.symmetric(vertical: 52,horizontal: 16));
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 3,
          margin: EdgeInsets.symmetric(vertical: 8),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField(
                    items: [ DropdownMenuItem(value: null, child: Text("New Fire")),
                      ...controller.activeFiresList!.map((e) => DropdownMenuItem(value: e.fireId, child: Text(e.optimalAddr))),
                     
                    ],
                    onChanged: (value) {
                      controller.selectedReport.fireId = int.tryParse(value.toString());
                      controller.update(["addToFire"]);
                    },
                    decoration: styler.inputDecoration("Assign to Fire"),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonFormField(
                    value: controller.selectedReport.fireId == null ,
                    decoration: styler.inputDecoration("Set As Optimal"),
                    items: controller.selectedReport.fireId == null
                        ? [DropdownMenuItem(value: true, child: Text("True"))]
                        : [
                      DropdownMenuItem(value: true, child: Text("True")),
                      DropdownMenuItem(value: false, child: Text("No")),
                    ],
                    onChanged: (bool? value) {
                      controller.isOptimalFire = value!;
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildActionButtons(MainRespondentController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            onPressed: () async {
              await controller.setReportId(-1);
              controller.activeFiresList = [];
              Get.back();
            },
            style: styler.elevatedButtonStyle(),
            child: Text("Return"),
          ),
          ElevatedButton(
            onPressed: () async {

                  styler.showDialogUnRemoved(title: "Confirm",
                    content: Text("You sure you want to set this report to: ${controller.selectedReport.reportStatus}?"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        style: styler.textButtonStyle(),
                        child: Text("No"),
                      ),
                      TextButton(
                        onPressed: () async {
                          await controller.reportTreatment();
                          await controller.setReportId(-1);
                          Get.back();
                          Get.back();
                          styler.showSnackBar("Report Treated", "Report set to ${controller.selectedReport.reportStatus}");
                        },
                        style: styler.textButtonStyle(),
                        child: Text("Yes"),
                      ),
                    ],
                  );

            },
            style: styler.elevatedButtonStyle(),
            child: Text("Confirm"),
          ),
        ],
      ),
    );
  }
}
