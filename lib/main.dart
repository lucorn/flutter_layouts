import 'package:flutter/material.dart';
import 'package:flutter_layouts/pages/app_bar_study_page.dart';
import 'package:flutter_layouts/pages/first_page.dart';
import 'package:flutter_layouts/pages/launcher_page.dart';
import 'package:flutter_layouts/pages/two_pages_with_messages.dart';
import 'package:flutter_layouts/pages/two_pages_with_chatview.dart';
import 'package:flutter_layouts/pages/third_page.dart';
import 'package:flutter_layouts/pages/two_pages_with_messages_with_provider.dart';

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
        initialRoute: '/launcher',
        showPerformanceOverlay: false,
        routes: {
          '/launcher': (context) => const LauncherPage(),
          '/first': (context) => const FirstPage(),
          '/twopageswithchatview': (context) =>
              const TwoPagesWithChatViewPage(),
          '/third': (context) => ThirdPage(),
          '/twopageswithmessages': (context) =>
              const TwoPagesWithMessagesPage(),
          '/appbarStudy': (context) => const AppBarStudyPage(),
          '/twopageswithmessageswithprovider': (context) =>
              const TwoPagesWithMessagesWithProviderPage(),
        });
  }
}
