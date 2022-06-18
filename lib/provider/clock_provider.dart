import 'package:flutter/material.dart';

class ClockProvider extends ChangeNotifier {
  bool isStreaming = false;
  DateTime dateTime = DateTime.now();

  late Animation<double> animation;
  late AnimationController controller;

  void streamDateTime() async {
    isStreaming = !isStreaming;
    // notifyListeners();
    while (isStreaming == true) {
      dateTime = DateTime.now();
      print('Date Time = > $dateTime');
      if (!isStreaming) return print('Time Stream terminated');
      notifyListeners();
      await Future.delayed(Duration(milliseconds: 500));
    }
  }

  void setAnimationController(AnimationController _controller) {
    controller = _controller;
    // notifyListeners();
  }

  // Tween<double>(begin: clock.dateTime.second.toDouble() / 60, end: 60).animate(clock.controller)
  void setAnimation() {
    animation = Tween<double>(begin: 0, end: 60).animate(controller);
    controller.forward(from: 1 / 60);
    controller.repeat(reverse: false);
    controller.addListener(() {
      if (dateTime.second == 59) {
        controller.stop();
        controller.forward(from: dateTime.second.toDouble() / 60);
        // notifyListeners();
      }
      // print('Seconds => ${dateTime.second}');
      // print('Hello => ${controller.value}');
    });
    // notifyListeners();
  }
}
