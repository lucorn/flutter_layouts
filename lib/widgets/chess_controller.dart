import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_layouts/chess/chess.dart';
import 'package:flutter_layouts/chess/coord.dart';
import 'package:flutter_layouts/chess/move.dart';
import 'package:flutter_layouts/chess/piece.dart';

class ChessController extends ChangeNotifier {
  late Chess game;
  String moves;

  final List<BoardArrow> _arrows = [];

  ChessController({required this.moves}) {
    game = Chess(moves);
    game.goToEnd();
    _addMoveArrow();
  }

  Piece? getPiece(Coord coord) => game.getPiece(coord);

  bool get canGoBack => game.canGoBack;
  bool get canGoForward => game.canGoForward;

  List<BoardArrow> get arrows => _arrows;

  void _addMoveArrow() {
    _arrows.clear();

    Move? move = game.previousMove;
    if (move != null) {
      BoardArrow arrow = BoardArrow(
        from: move.origin,
        to: move.destination,
        color: Colors.yellowAccent.withOpacity(0.4),
      );

      _arrows.add(arrow);
    }
  }

  void forwardMove() {
    if (game.forwardMove()) {
      _addMoveArrow();
      notifyListeners();
    }
  }

  void backOneMove() {
    if (game.backOneMove()) {
      _addMoveArrow();
      notifyListeners();
    }
  }

  void goToEnd() {
    game.goToEnd();
    _addMoveArrow();
    notifyListeners();
  }

  void goToBeginning() {
    game.goToBeginning();
    _addMoveArrow();
    notifyListeners();
  }
}

class BoardArrow {
  final Coord from;
  final Coord to;
  final Color color;

  BoardArrow({
    required this.from,
    required this.to,
    Color? color,
  }) : color = color ?? Colors.black.withOpacity(0.3);

  @override
  bool operator ==(Object other) {
    return other is BoardArrow && from == other.from && to == other.to;
  }

  @override
  int get hashCode => from.hashCode * to.hashCode;
}

enum PlayerColor {
  white,
  black,
}

class ArrowPainter extends CustomPainter {
  List<BoardArrow> arrows;
  PlayerColor boardOrientation;

  ArrowPainter(this.arrows, this.boardOrientation);

  @override
  void paint(Canvas canvas, Size size) {
    var blockSize = size.width / 8;
    var halfBlockSize = size.width / 16;

    for (var arrow in arrows) {
      var startFile = arrow.from.column;
      var startRank = arrow.from.row;
      var endFile = arrow.to.column;
      var endRank = arrow.to.row;
      // var startFile = files.indexOf(arrow.from[0]);
      // var startRank = int.parse(arrow.from[1]) - 1;
      // var endFile = files.indexOf(arrow.to[0]);
      // var endRank = int.parse(arrow.to[1]) - 1;

      int effectiveRowStart = 0;
      int effectiveColumnStart = 0;
      int effectiveRowEnd = 0;
      int effectiveColumnEnd = 0;

      if (boardOrientation == PlayerColor.black) {
        effectiveColumnStart = startFile;
        effectiveColumnEnd = endFile;
        effectiveRowStart = startRank;
        effectiveRowEnd = endRank;
      } else {
        effectiveColumnStart = startFile;
        effectiveColumnEnd = endFile;
        effectiveRowStart = 7 - startRank;
        effectiveRowEnd = 7 - endRank;
      }

      var startOffset = Offset(((effectiveColumnStart + 1) * blockSize) - halfBlockSize,
          ((effectiveRowStart + 1) * blockSize) - halfBlockSize);
      var endOffset = Offset(
          ((effectiveColumnEnd + 1) * blockSize) - halfBlockSize, ((effectiveRowEnd + 1) * blockSize) - halfBlockSize);

      var yDist = 0.8 * (endOffset.dy - startOffset.dy);
      var xDist = 0.8 * (endOffset.dx - startOffset.dx);

      var paint = Paint()
        ..strokeWidth = halfBlockSize * 0.6
        ..color = arrow.color;

      canvas.drawLine(startOffset, Offset(startOffset.dx + xDist, startOffset.dy + yDist), paint);

      var slope = (endOffset.dy - startOffset.dy) / (endOffset.dx - startOffset.dx);

      var newLineSlope = -1 / slope;

      var points = _getNewPoints(Offset(startOffset.dx + xDist, startOffset.dy + yDist), newLineSlope, halfBlockSize);
      var newPoint1 = points[0];
      var newPoint2 = points[1];

      var path = Path();

      path.moveTo(endOffset.dx, endOffset.dy);
      path.lineTo(newPoint1.dx, newPoint1.dy);
      path.lineTo(newPoint2.dx, newPoint2.dy);
      path.close();

      canvas.drawPath(path, paint);
    }
  }

  List<Offset> _getNewPoints(Offset start, double slope, double length) {
    if (slope == double.infinity || slope == double.negativeInfinity) {
      return [Offset(start.dx, start.dy + length), Offset(start.dx, start.dy - length)];
    }

    return [
      Offset(
          start.dx + (length / sqrt(1 + (slope * slope))), start.dy + ((length * slope) / sqrt(1 + (slope * slope)))),
      Offset(
          start.dx - (length / sqrt(1 + (slope * slope))), start.dy - ((length * slope) / sqrt(1 + (slope * slope)))),
    ];
  }

  @override
  bool shouldRepaint(ArrowPainter oldDelegate) {
    return arrows != oldDelegate.arrows;
  }
}
