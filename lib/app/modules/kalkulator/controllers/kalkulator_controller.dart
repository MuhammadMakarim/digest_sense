import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';

class KalkulatorController extends GetxController {
  var workingVolume = 40.0.obs;  // Working volume (ml)
  var suhu = 37.0.obs;  // Temperature (°C)
  var pH = 7.7.obs;  // pH value
  var avgTS = 13.71.obs;  // Average TS (g TS/kg WW)
  var avgVS = 0.0087.obs;  // Average VS (kg VS/kg WW)
  var ch4 = 0.509.obs;  // CH4 Theoretical (m3/kg VS)
  var m3CH4 = 0.0.obs;  // To store calculated CH4 value

  final DatabaseReference _database = FirebaseDatabase.instance.reference();

  // Function to calculate CH4 (Theoretical)
  void calculateCH4() {
    // Example formula: CH4 = VS * CH4 (Theoretical)
    m3CH4.value = avgVS.value * ch4.value;

    // After calculation, save to Firebase history
    saveToHistory();
  }

  // Function to save the input and result to Firebase history
  Future<void> saveToHistory() async {
    try {
      await _database.child('calculation_history').push().set({
        'workingVolume': workingVolume.value,
        'suhu': suhu.value,
        'pH': pH.value,
        'avgTS': avgTS.value,
        'avgVS': avgVS.value,
        'resultCH4': m3CH4.value,
        'timestamp': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      print('Error saving to history: $e');
    }
  }

  // Call this method to trigger the calculation
  void calculate() {
    calculateCH4();
  }
}
