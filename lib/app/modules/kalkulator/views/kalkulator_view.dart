import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/kalkulator_controller.dart';

class KalkulatorView extends GetView<KalkulatorController> {
  const KalkulatorView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Kalkulator Biogas",
          style: GoogleFonts.lato(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTitle(),
              const SizedBox(height: 20),
              _buildInputField(
                label: "Working Volume (ml)",
                onChanged: (value) {
                  controller.workingVolume.value =
                      double.tryParse(value) ?? 40.0;
                },
              ),
              const SizedBox(height: 20),
              _buildInputField(
                label: "Suhu (°C)",
                onChanged: (value) {
                  controller.suhu.value = double.tryParse(value) ?? 37.0;
                },
              ),
              const SizedBox(height: 20),
              _buildInputField(
                label: "pH",
                onChanged: (value) {
                  controller.pH.value = double.tryParse(value) ?? 7.7;
                },
              ),
              const SizedBox(height: 20),
              _buildInputField(
                label: "Average TS (g TS/kg WW)",
                onChanged: (value) {
                  controller.avgTS.value = double.tryParse(value) ?? 13.71;
                },
              ),
              const SizedBox(height: 20),
              _buildInputField(
                label: "Average VS (kg VS/kg WW)",
                onChanged: (value) {
                  controller.avgVS.value = double.tryParse(value) ?? 0.0087;
                },
              ),
              const SizedBox(height: 20),
              _buildCalculateButton(),
              const SizedBox(height: 20),
              _buildResult(),
            ],
          ),
        ),
      ),
    );
  }

  // Builds the title widget with larger text
  Widget _buildTitle() {
    return Text(
      "Kalkulasi Potensi Biogas",
      style: GoogleFonts.lato(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  // Reusable input field widget to avoid code duplication
  Widget _buildInputField({
    required String label,
    required Function(String) onChanged,
  }) {
    return TextField(
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.number,
    );
  }

  // Button to trigger the calculation
  Widget _buildCalculateButton() {
    return ElevatedButton(
      onPressed: () {
        controller.calculate();  // Calls the controller method to perform the calculation
      },
      child: Text("Hitung Potensi CH4"),
    );
  }

  // Displays the result of the calculation
  Widget _buildResult() {
    return Obx(() {
      return Text(
        "Potensi CH4: ${controller.m3CH4.value.toStringAsFixed(3)} m3/kg VS",
        style: GoogleFonts.lato(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      );
    });
  }
}
