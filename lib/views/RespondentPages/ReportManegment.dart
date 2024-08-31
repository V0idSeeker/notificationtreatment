import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:notificationtreatment/Modules/Report.dart';
import 'package:notificationtreatment/Modules/Styler.dart';
import 'package:notificationtreatment/controlers/RespondentController/MainRespondentController.dart';
import 'package:notificationtreatment/views/RespondentPages/ReviewReport.dart';

class ReportManagement extends StatelessWidget {
  const ReportManagement({super.key});

  @override
  Widget build(BuildContext context) {
    Styler styler = Styler();
    return GetBuilder<MainRespondentController>(
      init: MainRespondentController(),
      id: "ReportManagement",
      builder: (controller) {
        controller.setupReportsMap();
        return Container(
          height: MediaQuery.of(context).size.height,
          child: Row(
            children: [
              GetBuilder<MainRespondentController>(
                id: "ReportMap",
                builder: (controller) {
                  return AnimatedContainer(
                    duration: Duration(milliseconds: 50),
                    width: MediaQuery.of(context).size.width * (1 - controller.reportListFraction),
                    color: styler.lightGreyBackgroundColor,
                    child: Stack(
                      children: [

                        FlutterMap(
                          mapController: controller.mapController,
                          options: controller.mapOptions,
                          children: [
                            TileLayer(
                              urlTemplate: 'https://mt1.google.com/vt/lyrs=y&x={x}&y={y}&z={z}',
                            ),
                            GetBuilder<MainRespondentController>(
                              id: "respondentPosition",
                              builder: (controller) {
                                return MarkerLayer(
                                  markers: [
                                    Marker(
                                      point: controller.respondentCenter,
                                      child: Icon(Icons.pin_drop_rounded, color: styler.primaryColor),
                                    ),
                                  ],
                                );
                              },
                            ),
                            GetBuilder<MainRespondentController>(
                              id: "ReportPositions",
                              builder: (controller) {
                                return CircleLayer<Object>(
                                  circles: controller.reportsList == null
                                      ? []
                                      : controller.reportsList!.map(
                                        (e) => CircleMarker(
                                      point: LatLng(e.positionLat, e.positionLong),
                                      radius: 80,
                                      color: styler.errorColor.withOpacity(0.5),
                                      useRadiusInMeter: true,
                                    ),
                                  ).toList(),
                                );
                              },
                            ),
                          ],
                        ),

                        ElevatedButton(style: styler.elevatedButtonStyle(),
                            onPressed: (){
                              controller.moveMap(controller.respondentCenter);
                            },
                            child: Icon(Icons.pin_drop_rounded)),
                      ],
                    ),
                  );
                },
              ),
              GetBuilder<MainRespondentController>(
                id: "ReportList",
                builder: (controller) {
                  controller.getReports();
                  return AnimatedContainer(
                    duration: Duration(milliseconds: 50),
                    width: MediaQuery.of(context).size.width * controller.reportListFraction,
                    color: styler.lightGreyBackgroundColor,
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8.0),
                          color: Styler().primaryColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Image.asset('assets/logo.png', height: 50,),
                              Text(
                                "Reports",
                                style: TextStyle(
                                  color: Styler().backgroundColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),

                        Expanded(
                          child: controller.reportsList == null || controller.reportsList!.isEmpty
                              ? Center(child: Text("No Reports", style: styler.themeData.textTheme.bodyLarge))
                              : ListView.separated(
                            separatorBuilder: (context, index) => Divider(color: Colors.grey),
                            itemCount: controller.reportsList!.length,
                            itemBuilder: (context, index) {
                              Report rep = controller.reportsList![index];
                              return Container(
                                color: Colors.redAccent.withOpacity(rep.confidence/100),
                                child: ListTile(
                                  leading: Text(rep.confidence.toString(), style: styler.themeData.textTheme.bodyLarge),
                                  title: Text(rep.addr, style: styler.themeData.textTheme.bodyLarge),
                                  subtitle: Text(rep.reportDate.toString(), style: styler.themeData.textTheme.bodyMedium),
                                  onTap: () {
                                    controller.moveMap(LatLng(rep.positionLat, rep.positionLong));
                                  },
                                  trailing: ElevatedButton(
                                    onPressed: () async {
                                      await controller.setReportId(index);
                                      await controller.getLocalActiveFires();
                                      Get.to(() => ReviewReport());
                                    },
                                    style: styler.editButtonStyle(),
                                    child:Icon(Icons.remove_red_eye_rounded),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () {
                              controller.showList();
                            },
                            style: styler.dialogButtonStyle(),
                            child: Text("snap"),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
