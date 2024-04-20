import 'package:flutter/material.dart';
import 'package:flutter_layouts/pages/fifth_page.dart';
import 'package:flutter_layouts/pages/first_page.dart';
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
        initialRoute: '/twopageswithmessageswithprovider',
        showPerformanceOverlay: false,
        routes: {
          '/first': (context) => const FirstPage(),
          '/twopageswithchatview': (context) =>
              const TwoPagesWithChatViewPage(),
          '/third': (context) => ThirdPage(),
          '/twopageswithmessages': (context) =>
              const TwoPagesWithMessagesPage(),
          '/fifth': (context) => const FifthPage(),
          '/twopageswithmessageswithprovider': (context) =>
              const TwoPagesWithMessagesWithProviderPage(),
        });
  }
}
