import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GameTimer {
  final _duration = const Duration().obs;
  Timer? _timer;

  bool isTimerRunning() {
    return _timer == null ? false: _timer!.isActive;
  }

  void resetTimer() {
    _duration.value = const Duration();
  }

  void addTime() {
      _duration.value = Duration(seconds: _duration.value.inSeconds + 1);
  }

  void startTimer({bool reset = true}) {
    if (reset) {
      resetTimer();
    }
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => addTime());
  }

  void stopTimer({bool reset = true}) {
    if (reset) {
      resetTimer();
    }

    _timer?.cancel();
    // setState(() => _timer?.cancel());
  }

  Widget buildTime() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(_duration.value.inMinutes).obs;
    final seconds = twoDigits(_duration.value.inSeconds.remainder(60)).obs;

    return Text(
      '$minutes:$seconds',
      style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black
      ),
    );
  }
}