import 'package:flutter/material.dart';
import 'package:flutter_layouts/pages/app_bar_study_page.dart';
import 'package:flutter_layouts/pages/first_page.dart';
import 'package:flutter_layouts/pages/launcher_page.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // GoRouter configuration
  final _router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const LauncherPage(),
      ),
      GoRoute(
        path: '/first',
        builder: (context, state) => const FirstPage(),
      ),
      GoRoute(
        path: '/appbarStudy/:id',
        builder: (context, state) =>
            AppBarStudyPage(identifier: state.pathParameters['id']),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.purple,
      ),
      //initialRoute: '/launcher',
      showPerformanceOverlay: false,
      routerConfig: _router,
      // routes: {
      //   '/launcher': (context) => const LauncherPage(),
      //   '/first': (context) => const FirstPage(),
      //   '/twopageswithchatview': (context) =>
      //       const TwoPagesWithChatViewPage(),
      //   '/third': (context) => ThirdPage(),
      //   '/twopageswithmessages': (context) =>
      //       const TwoPagesWithMessagesPage(),
      //   '/appbarStudy': (context) => const AppBarStudyPage(),
      //   '/twopageswithmessageswithprovider': (context) =>
      //       const TwoPagesWithMessagesWithProviderPage(),
      // }
    );
  }
}
