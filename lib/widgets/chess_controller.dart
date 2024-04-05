import 'package:flutter/material.dart';
import 'package:flutter_layouts/chess/chess.dart';
import 'package:flutter_layouts/chess/coord.dart';
import 'package:flutter_layouts/chess/piece.dart';

class ChessController extends ChangeNotifier {
  late Chess game;
  String moves;

  ChessController({required this.moves}) {
    game = Chess(moves);
    game.goToEnd();
  }

  Piece? getPiece(Coord coord) => game.getPiece(coord);

  void forwardMove() {
    if (game.forwardMove()) {
      notifyListeners();
    }
  }

  void backOneMove() {
    if (game.backOneMove()) {
      notifyListeners();
    }
  }

  void goToEnd() {
    game.goToEnd();
    notifyListeners();
  }

  void goToBeginning() {
    game.goToBeginning();
    notifyListeners();
  }
}
