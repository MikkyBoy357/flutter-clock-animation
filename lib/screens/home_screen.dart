import 'dart:math';

import 'package:circle_list/circle_list.dart';
import 'package:circle_list/radial_drag_gesture_detector.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/clock_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  void initState() {
    Provider.of<ClockProvider>(context, listen: false).streamDateTime();
    Provider.of<ClockProvider>(context, listen: false).setAnimationController(
      AnimationController(
        duration: const Duration(seconds: 3500),
        vsync: this,
      )..repeat(reverse: false),
    );
    Provider.of<ClockProvider>(context, listen: false).setAnimation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ClockProvider viewModel = Provider.of(context, listen: false);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Consumer<ClockProvider>(
        builder: (context, clock, _) {
          // print('LOL => ${clock.dateTime.second / 60}');
          return Column(
            children: [
              SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${clock.dateTime.toString().substring(10, 13)}',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    ':',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    clock.dateTime.toString().substring(14, 16),
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    ':',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    clock.dateTime.toString().substring(17, 19),
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: size.height * 0.7,
                  // color: Colors.green,
                  child: Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // CircleList(
                        //   origin: Offset(0, 0),
                        //   outerRadius: 55,
                        //   innerRadius: 40,
                        //   outerCircleColor: Colors.white,
                        //   rotateMode: RotateMode.stopRotate,
                        //   children: List.generate(12, (index) {
                        //     print(index);
                        //     return Transform.rotate(
                        //       angle: sin((index + 1).toDouble() + 4.8) + 2.2,
                        //       child: Container(
                        //         width: 2,
                        //         height: 10,
                        //         color: index % 2 == 0 ? Colors.blue : Colors.orange,
                        //       ),
                        //     );
                        //   }),
                        // ),

                        /// First Progress Indicator
                        Container(
                          width: 190,
                          height: 190,
                          // color: Colors.green[100],
                          child: TweenAnimationBuilder<double>(
                            tween: Tween<double>(
                                begin: clock.dateTime.second / 60, end: 60),
                            duration: Duration(seconds: 3500),
                            builder: (context, value, _) {
                              return CircularProgressIndicator(
                                value: value,
                                strokeWidth: 10,
                                color: Colors.green,
                              );
                            },
                          ),
                        ),

                        /// Second Progress Indicator
                        Container(
                          width: 155,
                          height: 155,
                          // color: Colors.blue[100],
                          child: CircularProgressIndicator(
                            value: clock.dateTime.minute / 60,
                            strokeWidth: 10,
                            color: Colors.blue,
                          ),
                        ),

                        /// Third Progress Indicator
                        Container(
                          width: 120,
                          height: 120,
                          // color: Colors.red[100],
                          child: CircularProgressIndicator(
                            value: clock.dateTime.hour / 24,
                            strokeWidth: 10,
                            color: Colors.red,
                          ),
                        ),

                        /// Hours Clock Hand
                        ClockHand(
                          rotationAngle: (clock.dateTime.hour / 24) * 6.4,
                          color: Colors.red,
                        ),

                        /// Minutes Clock Hand
                        ClockHand(
                          rotationAngle: (clock.dateTime.minute / 60) * 6.4,
                          color: Colors.blue,
                        ),

                        /// Seconds Clock Hand
                        TweenAnimationBuilder<double>(
                          tween: Tween<double>(
                              begin: clock.dateTime.second / 60, end: 60),
                          duration: Duration(seconds: 3500),
                          builder: (context, value, _) {
                            return ClockHand(
                              rotationAngle: value * 6.4,
                              color: Colors.green,
                            );
                          },
                        ),

                        /// Center Anchor
                        CircleAvatar(
                          radius: 5,
                          backgroundColor: Colors.deepPurple,
                        ),
                        // Container(
                        //   color: Colors.white,
                        //   child: Text(
                        //     clock.dateTime.toString(),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          viewModel.streamDateTime();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ClockHand extends StatelessWidget {
  final double rotationAngle;
  final Color color;

  const ClockHand({
    Key? key,
    this.rotationAngle = 0.0,
    this.color = Colors.green,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: rotationAngle,
      child: Container(
        width: 80,
        height: 80,
        // color: Colors.green[100],
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: 2.5,
              height: 35,
              color: color,
            ),
          ],
        ),
      ),
    );
  }
}
