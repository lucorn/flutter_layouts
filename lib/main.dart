import 'package:flutter/material.dart';
import 'package:flutter_layouts/pages/first_page.dart';
import 'package:flutter_layouts/pages/second_page.dart';
import 'package:flutter_layouts/pages/third_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          primarySwatch: Colors.purple,
        ),
        initialRoute: '/first',
        showPerformanceOverlay: false,
        routes: {
          '/first': (context) => FirstPage(),
          '/second': (context) => const SecondPage(),
          '/third': (context) => ThirdPage(),
        });
  }
}
