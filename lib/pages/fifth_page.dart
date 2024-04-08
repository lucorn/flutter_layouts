import 'package:flutter/material.dart';

class FifthPage extends StatefulWidget {
  const FifthPage({super.key});

  @override
  State<FifthPage> createState() => _FifthPageState();
}

class _FifthPageState extends State<FifthPage> {
  ValueNotifier<Offset> tappedAt = ValueNotifier(Offset.zero);

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    BoardPainter painter = BoardPainter(tappedAt: tappedAt);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fifth page'),
        centerTitle: true,
        backgroundColor: Colors.grey[100],
      ),
      body: SizedBox(
          height: 700,
          child: GestureDetector(
            onTapDown: (details) {
              tappedAt.value = details.localPosition;
            },
            child: CustomPaint(
              foregroundPainter: painter,
              child: Container(
                height: 500,
                color: Colors.grey,
              ),
            ),
          )),
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

    print('last tap ${tappedAt.value}');
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
