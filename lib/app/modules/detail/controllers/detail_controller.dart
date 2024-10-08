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

  int scaleValue(int value, int inMin, int inMax, int outMin, int outMax) {
    return (((value - inMin) * (outMax - outMin)) ~/ (inMax - inMin)) + outMin;
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
        int value_ultra = 0;

        if (_snapshotValue['ultra'] > 10) {
          value_ultra = 0;
        } else {
          value_ultra = scaleValue(_snapshotValue['ultra'], 0, 9, 0, 100);
        }

        data.value = value_ultra as double;
        data_temperature.value = _snapshotValue['temperature'];

        int scaledValue = scaleValue(_snapshotValue['volume'], 0, 4095, 0, 100);
        data_volume.value = scaledValue as double;

        // Data tekanan
        data_tekanan.value = (_snapshotValue['tekanan'] as num) as double;

        // Data H2S
        data_h2s.value = (_snapshotValue['h2s'] as num) as double;

        // Data CO2
        data_co2.value = (_snapshotValue['co2'] as num) as double;

        // Data CH4
        data_ch4.value = (_snapshotValue['ch4'] as num) as double;

        // Data pH
        data_ph.value = (_snapshotValue['ph'] as num) as double;

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
