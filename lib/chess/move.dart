import 'package:flutter_layouts/chess/coord.dart';
import 'package:flutter_layouts/chess/piece.dart';

enum MoveState { normal, check, mate, draw }

enum MoveInfo {
  normal,
  enPassant,
  ambiguous,
  transformQueen,
  transformRook,
  transformKnight,
  transformBishop,
  castleKingSide,
  castleQueenSide
}

class Move {
  final int moveId;
  final Coord origin;
  final Coord destination;
  final Piece piece;
  Piece? pieceAtDestination;
  Piece? pieceRemoved;
  Coord? destinationRemoved;
  MoveState state = MoveState.normal;
  MoveInfo extraInfo = MoveInfo.normal;
  List<int>? boardMask;
  List<String>? bestMoves;
  int cp = 0;

  Move(
      {required this.moveId,
      required this.origin,
      required this.destination,
      required this.piece,
      required this.pieceAtDestination,
      required this.pieceRemoved,
      required this.destinationRemoved});

  String toNotation() {
    // Notation: Re4Qe2, Pe5Ef6e, Pe7Qf8R+, Ke1Eg1#

    String notation = piece.toNotation() + origin.toNotation();

    notation += (pieceRemoved != null ? pieceRemoved!.toNotation() : Piece.notationEmpty);

    notation += destination.toNotation();

    switch (extraInfo) {
      case MoveInfo.enPassant:
        notation += "e";
        break;
      case MoveInfo.ambiguous:
        notation += "a";
        break;
      case MoveInfo.transformQueen:
        notation += "Q";
        break;
      case MoveInfo.transformRook:
        notation += "R";
        break;
      case MoveInfo.transformKnight:
        notation += "N";
        break;
      case MoveInfo.transformBishop:
        notation += "B";
        break;
      case MoveInfo.castleKingSide:
      case MoveInfo.castleQueenSide:
      case MoveInfo.normal:
        break;
    }

    switch (state) {
      case MoveState.check:
        notation += "+";
        break;
      case MoveState.mate:
        notation += "#";
        break;
      case MoveState.draw:
        notation += "=";
        break;
      case MoveState.normal:
        break;
    }

    return notation;
  }

  String toVisualNotation(bool includePosition) {
    String notation = '';

    int loc = moveId ~/ 2 + 1;

    if (includePosition && moveId % 2 == 0) {
      notation = '$loc. ';
    }

    if (extraInfo == MoveInfo.castleKingSide) {
      notation += 'O-O';
    } else if (extraInfo == MoveInfo.castleQueenSide) {
      notation += 'O-O-O';
    } else {
      if (piece.type != PieceType.pawn) {
        notation += piece.toNotation();
      }

      if (extraInfo == MoveInfo.ambiguous) {
        notation += origin.toNotation();
      }

      if (pieceRemoved != null || extraInfo == MoveInfo.enPassant) {
        if (piece.type == PieceType.pawn) {
          notation += origin.toNotationColumn();
        }
        notation += "x";
      }

      notation += destination.toNotation();

      switch (extraInfo) {
        case MoveInfo.transformQueen:
          notation += "Q";
          break;
        case MoveInfo.transformRook:
          notation += "R";
          break;
        case MoveInfo.transformKnight:
          notation += "N";
          break;
        case MoveInfo.transformBishop:
          notation += "B";
          break;
        case MoveInfo.normal:
        case MoveInfo.enPassant:
        case MoveInfo.ambiguous:
        case MoveInfo.castleKingSide:
        case MoveInfo.castleQueenSide:
          break;
      }
    }

    switch (state) {
      case MoveState.check:
        notation += "+";
        break;
      case MoveState.mate:
        notation += "#";
        break;
      case MoveState.draw:
        notation += "=";
        break;
      case MoveState.normal:
        break;
    }
    return notation;
  }

  static Move? fromNotation(int moveId, String notation) {
    ChessColor moveColor = (moveId % 2 == 0) ? ChessColor.white : ChessColor.black;
    ChessColor oppositeColor = (moveColor == ChessColor.white) ? ChessColor.black : ChessColor.white;

    Move? move;

    try {
      Piece piece = Piece.fromNotation(notation[0], moveColor);

      Coord origin = Coord.fromNotation(notation.substring(1, 3));

      Coord dest = Coord.fromNotation(notation.substring(4, 6));

      Coord? destinationRemoved;

      Piece? pieceRemoved;

      if (notation[3] != 'E') {
        pieceRemoved = Piece.fromNotation(notation[3], oppositeColor);
        destinationRemoved = dest;
      }

      MoveState state = MoveState.normal;
      MoveInfo extraInfo = MoveInfo.normal;

      Piece? pieceAtDestination;

      if (notation.length > 6) {
        int nextIndexToCheck = 6;

        switch (notation[6]) {
          case 'e':
            extraInfo = MoveInfo.enPassant;
            pieceRemoved = Piece.fromNotation('P', oppositeColor);
            destinationRemoved = Coord(origin.row, dest.column);
            nextIndexToCheck++;
            break;
          case 'a':
            extraInfo = MoveInfo.ambiguous;
            nextIndexToCheck++;
            break;
          case 'Q':
            extraInfo = MoveInfo.transformQueen;
            pieceAtDestination = Piece.fromNotation('Q', moveColor);
            nextIndexToCheck++;
            break;
          case 'R':
            extraInfo = MoveInfo.transformRook;
            pieceAtDestination = Piece.fromNotation('R', moveColor);
            nextIndexToCheck++;
            break;
          case 'N':
            extraInfo = MoveInfo.transformKnight;
            pieceAtDestination = Piece.fromNotation('N', moveColor);
            nextIndexToCheck++;
            break;
          case 'B':
            extraInfo = MoveInfo.transformBishop;
            pieceAtDestination = Piece.fromNotation('B', moveColor);
            nextIndexToCheck++;
            break;
        }

        if (notation.length > nextIndexToCheck) {
          switch (notation[nextIndexToCheck]) {
            case '+':
              state = MoveState.check;
              break;
            case '#':
              state = MoveState.mate;
              break;
            case '=':
              state = MoveState.draw;
              break;
          }
        }
      }

      // Castling
      if (notation == "Ke1Eg1" || notation == "Ke8Eg8") {
        extraInfo = MoveInfo.castleKingSide;
      } else if (notation == "Ke1Ec1" || notation == "Ke8Ec8") {
        extraInfo = MoveInfo.castleQueenSide;
      }

      move = Move(
          moveId: moveId,
          origin: origin,
          destination: dest,
          piece: piece,
          pieceAtDestination: pieceAtDestination,
          pieceRemoved: pieceRemoved,
          destinationRemoved: destinationRemoved);
      move.extraInfo = extraInfo;
      move.state = state;
    } catch (e) {
      print('Failed to parse move id $moveId from notation $notation. Error: $e');
    }
    return move;
  }
}
