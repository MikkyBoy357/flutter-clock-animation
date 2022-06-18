import 'package:clock_animation/provider/clock_provider.dart';
import 'package:clock_animation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ClockProvider()),
      ],
      child: MaterialApp(
        title: 'Clock Animation',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          accentColor: Colors.purple,
        ),
        home: const HomeScreen(title: 'Flutter Clock'),
      ),
    );
  }
}
