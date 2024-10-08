import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plant_monitoring/app/data/date.dart';

import '../controllers/schedule_controller.dart';
import 'package:getwidget/getwidget.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';

class ScheduleView extends GetView<ScheduleController> {
  const ScheduleView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Watering Schedule'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: const Color(0xff569033),
                  child: Icon(Icons.calendar_month),
                ),
                title: Text('Watering Schedule'),
                subtitle: Obx(() => Text(
                    'Everyday ${controller.time.value.hour}:${controller.time.value.minute}')),
                trailing: TextButton(
                  style:
                      TextButton.styleFrom(backgroundColor: Color(0xff569033)),
                  onPressed: () {
                    Navigator.of(context).push(
                      showPicker(
                        context: context,
                        value: controller.time.value,
                        sunrise: TimeOfDay(hour: 6, minute: 0), // optional
                        sunset: TimeOfDay(hour: 18, minute: 0), // optional
                        duskSpanInMinutes: 120, // optional
                        onChange: controller.updateTime,
                        sunAsset: Image.asset('images/sun-date.png'),
                        moonAsset: Image.asset('images/moon-date.png'),
                        is24HrFormat: true,
                      ),
                    );
                  },
                  child: Text(
                    "Change Time",
                    style: TextStyle(color: Color(0xffEBFDF2)),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 125,
            ),
            Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: Center(
                    child: GestureDetector(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          ClipOval(
                            child: Container(
                              width: 200,
                              height: 200,
                              color: Color(0xff569033),
                            ),
                          ),
                          Text(
                            'Watering Now',
                            style: TextStyle(fontSize: 25, color: Colors.white),
                          ),
                        ],
                      ),
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (_) {
                              return AlertDialog(
                                title: Text('Information'),
                                content: const Text(
                                    'Are you sure want to a watering a plant now?'),
                                actions: [
                                  TextButton(
                                      onPressed: Navigator.of(context).pop,
                                      child: const Text('Cancel')),
                                  TextButton(
                                    onPressed: () {
                                      controller.startWatering();
                                      Navigator.of(context).pop();
                                      _showLoadingDialog(context);
                                    },
                                    child: const Text('Ok'),
                                  ),
                                ],
                              );
                            });
                      },
                    ),
                  ),
                )
              ],
            ),
          ],
        ));
  }

  void _showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible:
          false, // Prevent user from dismissing the dialog by tapping outside
      builder: (_) {
        return WillPopScope(
          onWillPop: () async => false, // Disable back button
          child: AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 20),
                Text("Watering a plant ..."),
              ],
            ),
          ),
        );
      },
    );

    // Simulate some async operation
    Future.delayed(Duration(seconds: 5), () {
      Navigator.of(context).pop();
      controller.stopWatering(); // Close the loading dialog
      // Perform the watering action or any other action here
    });
  }
}
