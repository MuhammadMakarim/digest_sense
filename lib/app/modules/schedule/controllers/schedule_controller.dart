import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';

class ScheduleController extends GetxController {
  //TODO: Implement ScheduleController

  final count = 0.obs;
  var time = Time(hour: 11, minute: 30, second: 20).obs;
  var iosStyle = true.obs;

  var isLoading = false.obs;
  Timer? _timer;

  Future<void> getData() async {
    try {
      DatabaseReference _databaseReference = FirebaseDatabase.instanceFor(
              app: Firebase.app(),
              databaseURL:
                  'https://smartgarden-12d50-default-rtdb.asia-southeast1.firebasedatabase.app')
          .ref("plant/time_schedule");
      final snapshot = await _databaseReference.get();
      if (snapshot.exists) {
        Map<String, dynamic> _snapshotValue =
            Map<String, dynamic>.from(snapshot.value as Map);
        int hours = _snapshotValue['hour'];
        int minutes = _snapshotValue['minute'];

        Time times_new = Time(hour: hours, minute: minutes);
        time.value = times_new;

        print(_snapshotValue);
      } else {
        print('no data');
      }
    } catch (e) {
      rethrow;
    }
  }

  void startWatering() {
    isLoading.value = true;
    DatabaseReference _databaseReference = FirebaseDatabase.instanceFor(
            app: Firebase.app(),
            databaseURL:
                'https://smartgarden-12d50-default-rtdb.asia-southeast1.firebasedatabase.app')
        .ref("biogas");

// Only update the name, leave the age and address!
    _databaseReference.update({
      'isON': true,
    });

    Future.delayed(Duration(seconds: 5), () {
      stopWatering();
    });

    // Future.delayed(Duration(seconds: 5), () {
    //   isLoading.value = false;
    // });
    // _databaseReference.update({
    //   'isWatering': false,
    // });
  }

  void stopWatering() {
    isLoading.value = true;
    DatabaseReference _databaseReference = FirebaseDatabase.instanceFor(
            app: Firebase.app(),
            databaseURL:
                'https://smartgarden-12d50-default-rtdb.asia-southeast1.firebasedatabase.app')
        .ref("plant");

// Only update the name, leave the age and address!
    _databaseReference.update({
      'isON': false,
    });

    // Future.delayed(Duration(seconds: 5), () {
    //   isLoading.value = false;
    // });
    // _databaseReference.update({
    //   'isWatering': false,
    // });
  }

  void updateTime(Time newTime) {
    time.value = newTime;
    DatabaseReference _databaseReference = FirebaseDatabase.instanceFor(
            app: Firebase.app(),
            databaseURL:
                'https://smartgarden-12d50-default-rtdb.asia-southeast1.firebasedatabase.app')
        .ref("plant/time_schedule/");

// Only update the name, leave the age and address!
    _databaseReference.update({
      'hour': newTime.hour,
      'minute': newTime.minute,
    });
  }

  void checkTime() {
    final now = DateTime.now();
    print(now);
    print(time.value.second);

    if (now.hour == time.value.hour && now.minute == time.value.minute) {
      // Time matches, perform the desired action
      print('Time matches! Performing action Actuator');
      startWatering();
      _timer?.cancel(); // Example action
    }
  }

  @override
  void onInit() {
    super.onInit();
    getData();
    _timer = Timer.periodic(Duration(seconds: 30), (timer) {
      checkTime();
      print('Check Time Jalan');
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
