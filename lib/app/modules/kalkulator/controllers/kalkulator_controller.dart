import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';

class KalkulatorController extends GetxController {
  var workingVolume = 40.0.obs;  // Example variable for working volume (ml)
  var suhu = 37.0.obs;  // Example variable for temperature (°C)
  var pH = 7.7.obs;  // Example pH value
  var avgTS = 13.71.obs;  // Average TS (Total Solids)
  var avgVS = 0.0087.obs;  // Average VS (Volatile Solids)
  var ch4 = 0.509.obs;  // CH4 Theoretical (m3/kg VS)
  var m3CH4 = 0.0.obs;  // To store calculated CH4 value

  // Function to calculate CH4 (Theoretical)
  void calculateCH4() {
    // Example calculation formula: CH4 = VS * CH4 (Theoretical)
    // For example purposes, you might adjust this formula based on your calculations
    m3CH4.value = avgVS.value * ch4.value;
  }

  // Call this method to trigger the calculation when button is pressed
  void calculate() {
    calculateCH4();
  }
}