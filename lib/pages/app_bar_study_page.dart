import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PageState extends ChangeNotifier {
  bool canSubmit = false;
  bool canTakeBack = true;

  void updateState(bool canSubmit, bool canTakeBack) {
    this.canSubmit = canSubmit;
    this.canTakeBack = canTakeBack;
    notifyListeners();
  }
}

class AppBarStudyPage extends StatefulWidget {
  const AppBarStudyPage({super.key});

  @override
  State<AppBarStudyPage> createState() => _AppBarStudyPageState();
}

class _AppBarStudyPageState extends State<AppBarStudyPage> {
  ValueNotifier<Offset> tappedAt = ValueNotifier(Offset.zero);

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final arguments = (ModalRoute.of(context)?.settings.arguments ??
    //     <String, dynamic>{}) as Map;

    // debugPrint('appBarStudy page built. arguments: $arguments');

    BoardPainter painter = BoardPainter(tappedAt: tappedAt);
    PageState pageState = PageState();
    return Scaffold(
      appBar: AppBar(
        title: const Text('AppBar Study Page'),
        elevation: 0,
        actions: [
          ChangeNotifierProvider<PageState>.value(
              value: pageState,
              child: Consumer<PageState>(builder: (context, g, child) {
                return PopupMenuButton<int>(
                  onSelected: (item) => {
                    debugPrint('selected item $item'),
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  itemBuilder: (context) => [
                    if (g.canTakeBack)
                      const PopupMenuItem<int>(
                        value: 0,
                        child: Row(
                          children: [
                            Icon(
                              Icons.undo,
                            ),
                            SizedBox(width: 10),
                            Text('Take back'),
                          ],
                        ),
                      ),
                    if (g.canSubmit)
                      const PopupMenuItem<int>(
                        value: 1,
                        child: Row(
                          children: [
                            Icon(
                              Icons.exit_to_app_outlined,
                            ),
                            SizedBox(width: 10),
                            Text('Submit'),
                          ],
                        ),
                      ),
                    const PopupMenuItem<int>(
                      value: 5,
                      child: Row(
                        children: [
                          Icon(
                            Icons.share,
                          ),
                          SizedBox(width: 10),
                          Text('Share'),
                        ],
                      ),
                    ),
                  ],
                );
              })),
        ],
      ),
      body: Column(
        children: [
          GestureDetector(
            onTapDown: (details) {
              tappedAt.value = details.localPosition;
            },
            child: RepaintBoundary(
              child: CustomPaint(
                foregroundPainter: painter,
                child: Container(
                  height: 500,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                    onPressed: () {}, child: const Text('First button')),
                ElevatedButton(
                    onPressed: () {}, child: const Text('Second button')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BoardPainter extends CustomPainter {
  ValueNotifier<Offset> tappedAt;

  BoardPainter({required this.tappedAt}) : super(repaint: tappedAt);

  @override
  void paint(Canvas canvas, Size size) {
    Rect rect = Rect.fromLTRB(0, 0, size.width, size.height);

    Paint paint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Colors.white, Colors.white30],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawRect(rect, paint);

    debugPrint('Repainting.. last tap ${tappedAt.value}');
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
