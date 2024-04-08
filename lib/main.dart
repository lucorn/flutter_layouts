import 'package:flutter/material.dart';
import 'package:flutter_layouts/pages/fifth_page.dart';
import 'package:flutter_layouts/pages/first_page.dart';
import 'package:flutter_layouts/pages/fourth_page.dart';
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
        initialRoute: '/fifth',
        showPerformanceOverlay: false,
        routes: {
          '/first': (context) => const FirstPage(),
          '/second': (context) => const SecondPage(),
          '/third': (context) => ThirdPage(),
          '/fourth': (context) => const FourthPage(),
          '/fifth': (context) => const FifthPage(),
        });
  }
}
