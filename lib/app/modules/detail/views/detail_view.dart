import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:plant_monitoring/app/routes/app_pages.dart';
import '../controllers/detail_controller.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class DetailView extends GetView<DetailController> {
  const DetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.getData();
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Obx(
                  () =>
                  Column(
                    children: [
                      Center(
                        child: Text(
                          'Digest Sense',
                          style: TextStyle(color: Colors.black, fontSize: 23),
                        ),
                      ),
                      SizedBox(height: 18),
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: Image(image: AssetImage('images/Sun.png')),
                            title: Text('Temperature', style: GoogleFonts
                                .lexend(fontSize: 24)),
                            subtitle: Text(
                              controller.data_temperature > 40.0
                                  ? 'Hot Temperature'
                                  : 'Good Temperature',
                              style: GoogleFonts.lexend(fontSize: 14),
                            ),
                            trailing: Container(
                              width: 80,
                              height: 40,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 2),
                              decoration: BoxDecoration(
                                color: controller.data_temperature > 40.0
                                    ? Colors.red
                                    : Colors.green,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Center(
                                child: Text(
                                  '${controller.data_temperature} °C',
                                  style: GoogleFonts.jaldi(
                                      fontSize: 24, color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 18),
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: Image(image: AssetImage(
                                'images/Water.png')),
                            title: Text('Volume', style: GoogleFonts.lexend(
                                fontSize: 28)),
                            subtitle: Text(
                              controller.data < 50.0
                                  ? 'Low volume'
                                  : 'High volume',
                              style: GoogleFonts.lexend(fontSize: 14),
                            ),
                            trailing: Container(
                              width: 80,
                              height: 40,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 2),
                              decoration: BoxDecoration(
                                color: controller.data.value < 50.0
                                    ? Colors.red
                                    : Colors.green,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Center(
                                child: Text(
                                  '${controller.data.value} %',
                                  style: GoogleFonts.jaldi(
                                      fontSize: 24, color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 18),

                      // New card for TeKanang
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: Image(image: AssetImage(
                                'images/tekanan.png')),
                            title: Text('Pressure', style: GoogleFonts.lexend(
                                fontSize: 24)),
                            subtitle: Text(
                              controller.data_tekanan < 50.0
                                  ? 'Low Pressure'
                                  : 'Good Pressure',
                              style: GoogleFonts.lexend(fontSize: 14),
                            ),
                            trailing: Container(
                              width: 80,
                              height: 40,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 2),
                              decoration: BoxDecoration(
                                color: controller.data_tekanan < 50.0
                                    ? Colors.red
                                    : Colors.green,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Center(
                                child: Text(
                                  '${controller.data_tekanan} Pa',
                                  style: GoogleFonts.jaldi(
                                      fontSize: 24, color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 18),

                      // New card for H2S
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: Image(image: AssetImage('images/h2s.png')),
                            title: Text('H2S Levels', style: GoogleFonts.lexend(
                                fontSize: 24)),
                            subtitle: Text(
                              controller.data_h2s > 5.0
                                  ? 'High H2S'
                                  : 'Safe H2S Levels',
                              style: GoogleFonts.lexend(fontSize: 14),
                            ),
                            trailing: Container(
                              width: 80,
                              height: 40,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 2),
                              decoration: BoxDecoration(
                                color: controller.data_h2s > 5.0
                                    ? Colors.red
                                    : Colors.green,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Center(
                                child: Text(
                                  '${controller.data_h2s} ml',
                                  style: GoogleFonts.jaldi(
                                      fontSize: 24, color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 18),

                      // New card for CO2
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: Image(image: AssetImage('images/co2.png')),
                            title: Text('CO2 Levels', style: GoogleFonts.lexend(
                                fontSize: 24)),
                            subtitle: Text(
                              controller.data_co2 > 1000.0
                                  ? 'High CO2 Levels'
                                  : 'Safe CO2 Levels',
                              style: GoogleFonts.lexend(fontSize: 14),
                            ),
                            trailing: Container(
                              width: 80,
                              height: 40,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 2),
                              decoration: BoxDecoration(
                                color: controller.data_co2 > 1000.0
                                    ? Colors.red
                                    : Colors.green,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Center(
                                child: Text(
                                  '${controller.data_co2} ml',
                                  style: GoogleFonts.jaldi(
                                      fontSize: 24, color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 18),

                      // New card for CH4
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: Image(image: AssetImage('images/ch4.png')),
                            title: Text('CH4 Levels', style: GoogleFonts.lexend(
                                fontSize: 24)),
                            subtitle: Text(
                              controller.data_ch4 > 10.0
                                  ? 'High CH4 Levels'
                                  : 'Safe CH4 Levels',
                              style: GoogleFonts.lexend(fontSize: 14),
                            ),
                            trailing: Container(
                              width: 80,
                              height: 40,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 2),
                              decoration: BoxDecoration(
                                color: controller.data_ch4 > 10.0
                                    ? Colors.red
                                    : Colors.green,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Center(
                                child: Text(
                                  '${controller.data_ch4} ml',
                                  style: GoogleFonts.jaldi(
                                      fontSize: 24, color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 18),

                      // New card for pH
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: Image(image: AssetImage('images/Water.png')),
                            title: Text('pH Level', style: GoogleFonts.lexend(
                                fontSize: 24)),
                            subtitle: Text(
                              controller.data_ph < 7.0
                                  ? 'Acidic pH'
                                  : 'Neutral pH',
                              style: GoogleFonts.lexend(fontSize: 14),
                            ),
                            trailing: Container(
                              width: 80,
                              height: 40,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 2),
                              decoration: BoxDecoration(
                                color: controller.data_ph < 7.0
                                    ? Colors.red
                                    : Colors.green,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Center(
                                child: Text(
                                  '${controller.data_ph} pH',
                                  style: GoogleFonts.jaldi(
                                      fontSize: 24, color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 18),
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: Image(image: AssetImage(
                                'images/clock.png')),
                            title: Text(
                              'Actuator Schedule',
                              style: GoogleFonts.lexend(fontSize: 18),
                            ),
                            trailing: IconButton(
                              icon: Icon(
                                Icons.arrow_forward_ios,
                                size: 40,
                              ),
                              onPressed: () {
                                Get.toNamed(Routes.SCHEDULE);
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
            ),
          ),
        ),
      ),
    );
  }
}