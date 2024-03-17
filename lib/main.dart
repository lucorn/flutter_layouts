import 'package:flutter/material.dart';
import 'package:flutter_layouts/pages/first_page.dart';

void main() {
  runApp(MyApp());
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
          '/first': (context) => const FirstPage(),
        });
  }
}
