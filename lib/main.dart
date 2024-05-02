import 'package:flutter/material.dart';
import 'package:flutter_layouts/pages/app_bar_study_page.dart';
import 'package:flutter_layouts/pages/chess_game_page.dart';
import 'package:flutter_layouts/pages/edit_controls_page.dart';
import 'package:flutter_layouts/pages/launcher_page.dart';
import 'package:flutter_layouts/pages/list_with_headers_page.dart';
import 'package:flutter_layouts/pages/two_pages_with_chatview.dart';
import 'package:flutter_layouts/pages/two_pages_with_messages.dart';
import 'package:flutter_layouts/pages/two_pages_with_messages_with_provider.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // GoRouter configuration
  final _router = GoRouter(
    initialLocation: '/editControlPage',
    routes: [
      GoRoute(
        path: '/launcherPage',
        builder: (context, state) => const LauncherPage(),
      ),
      GoRoute(
        path: '/editControlPage',
        builder: (context, state) => EditControlPage(),
      ),
      GoRoute(
        path: '/chessGamePage',
        builder: (context, state) => const ChessGamePage(),
      ),
      GoRoute(
        path: '/listWithHeadersPage',
        builder: (context, state) => ListWithHeadersPage(),
      ),
      GoRoute(
        path: '/appbarStudy/:id',
        builder: (context, state) =>
            AppBarStudyPage(identifier: state.pathParameters['id']),
      ),
      GoRoute(
        path: '/twoPagesWithMessagesPage',
        builder: (context, state) => const TwoPagesWithMessagesPage(),
      ),
      GoRoute(
        path: '/twoPagesWithChatViewPage',
        builder: (context, state) => const TwoPagesWithChatViewPage(),
      ),
      GoRoute(
        path: '/twoPagesWithMessagesWithProviderPage',
        builder: (context, state) =>
            const TwoPagesWithMessagesWithProviderPage(),
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
