import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:notificationtreatment/Modules/Report.dart';
import 'package:notificationtreatment/controlers/RespondentController/MainRespondentController.dart';
import 'package:notificationtreatment/views/RespondentPages/ReviewReport.dart';

class ReportManagement extends StatelessWidget {
  const ReportManagement({super.key});

  @override
  Widget build(BuildContext context) {
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
                          width: MediaQuery.of(context).size.width *
                              (1 - controller.reportListFraction),
                          color: Colors.blue,
                          child: FlutterMap(
                            mapController: controller.mapController,
                            options: controller.mapOptions,
                            children: [
                              TileLayer(
                                urlTemplate:
                                    'https://mt1.google.com/vt/lyrs=y&x={x}&y={y}&z={z}',
                              ),
                              GetBuilder<MainRespondentController>(
                                  id: "respondentPosition",
                                  builder: (controller) {
                                    return MarkerLayer(markers: [
                                      Marker(
                                          point: controller.respondentCenter,
                                          child: Icon(Icons.pin_drop_rounded))
                                    ]);
                                  }),
                              GetBuilder<MainRespondentController>(
                                  id: "ReportPositions",
                                  builder: (controller) {
                                    return CircleLayer(
                                      circles: controller.reportsList == null
                                          ? []
                                          : controller.reportsList!
                                              .map((e) => CircleMarker(
                                                  point: LatLng(e.positionLat,
                                                      e.positionLong),
                                                  radius: 80,
                                      color: Colors.red.withOpacity(0.5),
                                        useRadiusInMeter: true
                                      ))
                                              .toList(),
                                    );
                                  })
                            ],
                          ),
                        );
                      }),
                  GetBuilder<MainRespondentController>(
                      id: "ReportList",
                      builder: (controller) {
                        controller.getReports();
                        return AnimatedContainer(
                            duration: Duration(milliseconds: 50),
                            width: MediaQuery.of(context).size.width *
                                controller.reportListFraction,
                            child: Column(children: [
                              Expanded(
                                  child: Column(children: [
                                Center(child: Text("Reports")),
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.8,
                                  child: controller.reportsList == null ||
                                          controller.reportsList!.isEmpty
                                      ? Text("No Reports")
                                      : ListView.separated(
                                          separatorBuilder: (context, index) =>
                                              Divider(color: Colors.grey,),
                                          itemCount:
                                              controller.reportsList!.length,
                                          itemBuilder: (context, index) {
                                            Report rep =
                                                controller.reportsList![index];
                                            return ListTile(
                                              leading: Text(rep.confidence.toString()),
                                                title: Text(rep.addr),
                                                subtitle: Text(
                                                    rep.reportDate.toString()),
                                                onTap: () {
                                                  controller.moveMap(LatLng(
                                                      rep.positionLat,
                                                      rep.positionLong));
                                                },trailing: ElevatedButton(onPressed: () async {
                                                  await controller.setReportId(index);
                                                  await controller.getLocalActiveFires();
                                                  Get.to(()=>ReviewReport());

                                            },child: Text("Edit"),),


                                                );
                                          }),
                                )
                              ])),
                              ElevatedButton(
                                onPressed: () {
                                  controller.showList();
                                },
                                child: Text("snap"),
                              ),
                            ]));
                      }),
                ],
              ));
        });
  }
}
