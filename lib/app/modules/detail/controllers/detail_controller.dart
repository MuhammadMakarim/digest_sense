import 'dart:ffi';

import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';

class DetailController extends GetxController {
  //TODO: Implement DetailController
  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref("plant");
  Rx<double> data = 0.0.obs;
  Rx<double> data_temperature = 0.0.obs;
  Rx<double> data_volume = 0.0.obs;
  Rx<double> data_tekanan = 0.0.obs;
  Rx<double> data_h2s = 0.0.obs;
  Rx<double> data_co2 = 0.0.obs;
  Rx<double> data_ch4 = 0.0.obs;
  Rx<double> data_ph = 0.0.obs;

  late Timer _timer;

  double scaleValue(double value, double inMin, double inMax, double outMin, double outMax) {
    return (((value - inMin) * (outMax - outMin)) / (inMax - inMin)) + outMin;
  }

  Future<void> getData() async {
    try {
      DatabaseReference _databaseReference = FirebaseDatabase.instanceFor(
          app: Firebase.app(),
          databaseURL:
          'https://smartgarden-12d50-default-rtdb.asia-southeast1.firebasedatabase.app')
          .ref("plant");
      final snapshot = await _databaseReference.get();
      if (snapshot.exists) {
        Map<String, dynamic> _snapshotValue =
        Map<String, dynamic>.from(snapshot.value as Map);
        double value_ultra = 0;

        if (_snapshotValue['ultra'] > 10) {
          value_ultra = 0;
        } else {
          double valueUltra = scaleValue(_snapshotValue['ultra'].toDouble(), 0, 9, 0, 100);
          data.value = valueUltra;
        }

        data.value = value_ultra;

        if (_snapshotValue['temperature'] != null) {
          data_temperature.value = _snapshotValue['temperature'].toDouble();
        } else {
          data_temperature.value = 0.0;
        }

        if (_snapshotValue['volume'] != null) {
          double scaledValue = scaleValue(_snapshotValue['volume'].toDouble(), 0, 4095, 0, 100);
          data_volume.value = scaledValue;
        } else {
          data_volume.value = 0.0;
        }

        // Data tekanan
        if (_snapshotValue['tekanan'] != null) {
          data_tekanan.value = _snapshotValue['tekanan'].toDouble();
        } else {
          data_tekanan.value = 0.0;
        }

        // Data H2S
        if (_snapshotValue['h2s'] != null) {
          data_h2s.value = _snapshotValue['h2s'].toDouble();
        } else {
          data_h2s.value = 0.0;
        }

        // Data CO2
        if (_snapshotValue['co2'] != null) {
          data_co2.value = _snapshotValue['co2'].toDouble();
        } else {
          data_co2.value = 0.0;
        }

        // Data CH4
        if (_snapshotValue['ch4'] != null) {
          data_ch4.value = _snapshotValue['ch4'].toDouble();
        } else {
          data_ch4.value = 0.0;
        }

        // Data pH
        if (_snapshotValue['ph'] != null) {
          data_ph.value = _snapshotValue['ph'].toDouble();
        } else {
          data_ph.value = 0.0;
        }

        print(_snapshotValue);
      } else {
        print('no data');
      }
    } catch (e) {
      rethrow;
    }
  }


  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    getData();
    // Fetch data every 30 seconds
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      print('Dijalankan');
      getData();
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    _timer.cancel();
    super.onClose();
  }

  void increment() => count.value++;
}
