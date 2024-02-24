import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stopwatch',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const StopWatchScreen(),
    );
  }
}

class StopWatchScreen extends StatefulWidget {
  const StopWatchScreen({Key? key}) : super(key: key);

  @override
  State<StopWatchScreen> createState() => _StopWatchScreenState();
}

class _StopWatchScreenState extends State<StopWatchScreen> {
  String hoursString = "00", minuteString = "00", secondString = "00";

  int hours = 0, minutes = 0, seconds = 0;
  bool isTimerRunning = false, isResetButtonVisible = false;
  late Timer _timer;

  void startTimer() {
    setState(() {
      isTimerRunning = true;
    });
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _startSecond();
    });
  }

  void pauseTimer() {
    _timer.cancel();
    setState(() {
      isTimerRunning = false;
    });
    isResetButtonVisible = checkValues();
  }

  void _startSecond() {
    setState(() {
      if (seconds < 59) {
        seconds++;
        secondString = seconds.toString();
        if (secondString.length == 1) {
          secondString = "0" + secondString;
        }
      } else {
        _startMinute();
      }
    });
  }

  void _startMinute() {
    setState(() {
      if (minutes < 59) {
        seconds = 0;
        secondString = "00";
        minutes++;
        minuteString = minutes.toString();
        if (minuteString.length == 1) {
          minuteString = "0" + minuteString;
        }
      } else {
        _starHour();
      }
    });
  }

  void _starHour() {
    setState(() {
      seconds = 0;
      minutes = 0;
      secondString = "00";
      minuteString = "00";
      hours++;
      hoursString = hours.toString();
      if (hoursString.length == 1) {
        hoursString = "0" + hoursString;
      }
    });
  }

  void resetTimer() {
    _timer.cancel();
    setState(() {
      seconds = 0;
      minutes = 0;
      hours = 0;
      secondString = "00";
      minuteString = "00";
      hoursString = "00";
      isResetButtonVisible = false;
    });
  }

  bool checkValues() {
    if (seconds != 0 || minutes != 0 || hours != 0) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Icon(
          Icons.menu,
          color: Colors.black,
        ),
        title: const Text(
          "Stopwatch",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "$hoursString:$minuteString:$secondString",
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.w500,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (isTimerRunning) {
                  pauseTimer();
                } else {
                  startTimer();
                }
              },
              child: Text(isTimerRunning ? "Pause" : "Play"),
            ),
            isResetButtonVisible
                ? ElevatedButton(
                    onPressed: () {
                      resetTimer();
                    },
                    child: Text("Reset"),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
