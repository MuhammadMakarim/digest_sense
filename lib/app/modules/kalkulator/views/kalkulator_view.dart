import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/kalkulator_controller.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class KalkulatorView extends GetView<KalkulatorController> {
  const KalkulatorView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kalkulator Biogas", style: GoogleFonts.lato()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              "Kalkulasi Potensi Biogas",
              style: GoogleFonts.lato(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            // Input fields
            TextField(
              onChanged: (value) {
                controller.workingVolume.value = double.tryParse(value) ?? 40.0;
              },
              decoration: InputDecoration(
                labelText: "Working Volume (ml)",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            TextField(
              onChanged: (value) {
                controller.suhu.value = double.tryParse(value) ?? 37.0;
              },
              decoration: InputDecoration(
                labelText: "Suhu (°C)",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            TextField(
              onChanged: (value) {
                controller.pH.value = double.tryParse(value) ?? 7.7;
              },
              decoration: InputDecoration(
                labelText: "pH",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            TextField(
              onChanged: (value) {
                controller.avgTS.value = double.tryParse(value) ?? 13.71;
              },
              decoration: InputDecoration(
                labelText: "Average TS (g TS/kg WW)",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            TextField(
              onChanged: (value) {
                controller.avgVS.value = double.tryParse(value) ?? 0.0087;
              },
              decoration: InputDecoration(
                labelText: "Average VS (kg VS/kg WW)",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                controller.calculate();
              },
              child: Text("Hitung Potensi CH4"),
            ),
            SizedBox(height: 20),
            Obx(() {
              return Text(
                "Potensi CH4: ${controller.m3CH4.value.toStringAsFixed(3)} m3/kg VS",
                style: GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.bold),
              );
            }),
          ],
        ),
      ),
    );
  }
}