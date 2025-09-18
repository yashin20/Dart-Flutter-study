import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() =>
      _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const twentyFiveMinutes = 1500;
  int totalSeconds = twentyFiveMinutes;
  bool isRunning = false;
  int totalPomodoros = 0;
  late Timer timer;

  void onTick(Timer timer) {
    //타이머가 0에 도달 -> 리셋
    if (totalSeconds == 0) {
      setState(() {
        totalPomodoros = totalPomodoros + 1;
        isRunning = false;
        totalSeconds = twentyFiveMinutes;
      });
      //타이머 종료
      timer.cancel();
    } else {
      setState(() {
        totalSeconds = totalSeconds - 1;
      });
    }
  }

  void onStartPressed() {
    timer = Timer.periodic(
      Duration(seconds: 1),
      onTick,
    );
    setState(() {
      isRunning = true;
    });
  }

  void onPausePressed() {
    //1. 타이머가 멈춤
    timer.cancel();
    //2. 타이머 정지 상태 변환
    setState(() {
      isRunning = false;
    });
  }

  void onStopPressed() {
    //1. 타이머 멈추기
    timer.cancel();
    //2. 시간 리셋 + 타이머 정지 상태 변환
    setState(() {
      totalSeconds = twentyFiveMinutes;
      isRunning = false;
    });
  }

  String fotmat(int seconds) {
    var duration = Duration(seconds: seconds);
    return duration
        .toString()
        .split('.')
        .first
        .substring(2, 7);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //부모 정의 색상 이용
      backgroundColor: Theme.of(
        context,
      ).colorScheme.surface,
      body: Column(
        children: [
          Flexible(
            flex: 1,
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Text(
                fotmat(totalSeconds),
                style: TextStyle(
                  //부모 정의 색상 이용
                  color: Theme.of(
                    context,
                  ).cardColor,
                  fontSize: 89,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 3,
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center,
              children: [
                Center(
                  child: IconButton(
                    iconSize: 120,
                    color: Theme.of(
                      context,
                    ).cardColor,
                    //버튼이 눌렸을때 실행되는 것
                    onPressed: isRunning
                        ? onPausePressed
                        : onStartPressed,
                    icon: Icon(
                      isRunning
                          ? Icons
                                .pause_circle_outline
                          : Icons
                                .play_circle_outline,
                    ),
                  ),
                ),
                Center(
                  child: IconButton(
                    iconSize: 80,
                    color: Theme.of(
                      context,
                    ).cardColor,
                    //버튼이 눌렸을때 실행되는 것
                    onPressed: onStopPressed,
                    icon: Icon(
                      Icons.stop_circle_outlined,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            flex: 1,
            child: Row(
              children: [
                //(가로로) 끝까지 확장
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(
                        context,
                      ).cardColor,
                      borderRadius:
                          BorderRadius.circular(
                            50,
                          ),
                    ),
                    child: Column(
                      mainAxisAlignment:
                          MainAxisAlignment
                              .center,
                      children: [
                        Text(
                          'Pomodoros',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight:
                                FontWeight.w600,
                            color:
                                Theme.of(context)
                                    .textTheme
                                    .headlineLarge!
                                    .color,
                          ),
                        ),
                        Text(
                          '$totalPomodoros',
                          style: TextStyle(
                            fontSize: 58,
                            fontWeight:
                                FontWeight.w600,
                            color:
                                Theme.of(context)
                                    .textTheme
                                    .headlineLarge!
                                    .color,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
