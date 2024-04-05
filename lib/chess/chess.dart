import 'package:flutter_layouts/chess/castling_state.dart';
import 'package:flutter_layouts/chess/coord.dart';
import 'package:flutter_layouts/chess/move.dart';
import 'package:flutter_layouts/chess/piece.dart';
import 'package:flutter_layouts/chess/piece_location_map.dart';

class Chess {
  final PieceLocationsMap _pieceLocations = PieceLocationsMap();

  final List<Move> _committedMoves = [];

  int _moveId = 0;

  final List<List<Piece?>> _matrix =
      List.generate(8, (i) => List.generate(8, (j) => null, growable: false), growable: false);

  final List<List<Piece?>> _matrixSim =
      List.generate(8, (i) => List.generate(8, (j) => null, growable: false), growable: false);

  String _moves = '';

  CastlingState castlingState = CastlingState();

  Chess(String moves) {
    _moves = moves;
    _initmatrix();
    _parseMoves();
  }

  Piece? getPiece(Coord coord) => _matrix[coord.row][coord.column];

  Piece? getPieceFromNotation(String square) {
    Coord coord = Coord.fromNotation(square);
    return _matrix[coord.row][coord.column];
  }

  ChessColor get playerToMove => (_moveId % 2 == 0) ? ChessColor.white : ChessColor.black;

  bool makeMove(String move) {
    if (move == '-') {
      // removing the last move
      if (_committedMoves.isEmpty) {
        return false;
      }
      _committedMoves.removeLast();
      if (_committedMoves.isEmpty) {
        _moves = '';
      } else {
        int lastIndex = _moves.lastIndexOf(',');
        _moves = _moves.substring(0, lastIndex);
      }
      return true;
    }

    Move? m = Move.fromNotation(_committedMoves.length, move);

    if (m == null) {
      return false;
    }

    _committedMoves.add(m);
    _moves += ',$move';
    return true;
  }

  // BEGIN Move navigation

  /// forward move
  bool forwardMove() {
    if (_moveId == _committedMoves.length) {
      // at the end of the moves already
      return false;
    }
    Move move = _committedMoves[_moveId];

    if (move.pieceRemoved != null) {
      _removePiece(move.pieceRemoved, move.destinationRemoved);
    }
    if (move.pieceAtDestination != null) {
      _addPiece(move.pieceAtDestination, move.destination);
    } else {
      _addPiece(move.piece, move.destination);
    }
    _removePiece(move.piece, move.origin);

    _handleCastling(move);

    _moveId++;

    move.boardMask ??= _getBoardMask();

    return true;
  }

  /// back one move
  bool backOneMove() {
    if (_moveId == 0) {
      return false;
    }

    _moveId--;

    Move move = _committedMoves[_moveId];

    // update the dictionary
    if (_matrix[move.origin.row][move.origin.column] != null) {
      throw 'Board is not in the expected state!';
    }
    _addPiece(move.piece, move.origin);

    if (move.pieceAtDestination != null) {
      _removePiece(move.pieceAtDestination, move.destination);
    } else {
      _removePiece(move.piece, move.destination);
    }

    if (move.pieceRemoved != null) {
      _addPiece(move.pieceRemoved, move.destinationRemoved!);
    }

    _handleReverseCastling(move);
    return true;
  }

  void goToEnd() {
    while (forwardMove()) {
      // continue to move forward
    }
  }

  void goToBeginning() {
    while (backOneMove()) {
      // continue to move backward
    }
  }

  // END Move navigation

  void _initmatrix() {
    ChessColor color = ChessColor.white;
    PieceType pieceType = PieceType.none;

    for (int r = 0; r < 8; r++) {
      for (int c = 0; c < 8; c++) {
        _matrix[r][c] = null;

        if (r == 0 || r == 7) {
          color = (r == 0) ? ChessColor.black : ChessColor.white;

          switch (c) {
            case 0:
            case 7:
              pieceType = PieceType.rook;
              break;
            case 1:
            case 6:
              pieceType = PieceType.knight;
              break;
            case 2:
            case 5:
              pieceType = PieceType.bishop;
              break;
            case 3:
              pieceType = PieceType.queen;
              break;
            case 4:
              pieceType = PieceType.king;
              break;
          }
        } else if (r == 1 || r == 6) {
          color = (r == 1) ? ChessColor.black : ChessColor.white;
          pieceType = PieceType.pawn;
        } else {
          pieceType = PieceType.none;
        }
        Piece? piece = pieceType != PieceType.none ? Piece(pieceType, color) : null;

        if (piece != null) {
          _addPiece(piece, Coord(r, c));
        }
      }
    }
  }

  void _parseMoves() {
    if (_moves.isEmpty) {
      return;
    }

    List<String> movesList = _moves.split(',');

    for (int i = 0; i < movesList.length; i++) {
      String m = movesList[i];

      Move? move;

      // check for best moves
      if (m.contains(':')) {
        List<String> tokens = m.split(':');

        move = Move.fromNotation(i, tokens[0]);
        if (move == null) {
          throw 'failed to parse analyzed move $m';
        }

        if (tokens.length > 1) {
          move.cp = int.parse(tokens[1]);

          if (tokens.length > 2) {
            List<String> bestMoves = [];
            for (int j = 2; j < tokens.length; j++) {
              bestMoves.add(tokens[j]);
            }
            move.bestMoves = bestMoves;
          }
        }
      } else {
        move = Move.fromNotation(i, m);
      }

      if (move == null) {
        throw 'failed to parse move $m';
      }

      _committedMoves.add(move);
    }
  }

  void _addPiece(Piece? piece, Coord coord) {
    if (piece == null) {
      throw 'piece $piece cannot be null';
    }
    _pieceLocations.addPiece(piece, coord);
    _matrix[coord.row][coord.column] = piece;
  }

  void _removePiece(Piece? piece, Coord? coord) {
    if (piece == null || coord == null) {
      throw 'piece $piece cannot be null and neither can coord $coord';
    }
    if (_matrix[coord.row][coord.column] != piece) {
      throw 'attempting to remove piece $piece from location(${coord.row}, ${coord.column})';
    }
    _pieceLocations.removePiece(piece, coord);
    _matrix[coord.row][coord.column] = null;
  }

  void _handleCastling(Move move) {
    if (move.piece.type == PieceType.king) {
      if (move.piece.color == ChessColor.white) {
        if (move.origin == Coord.e1) {
          if (move.destination == Coord.g1) {
            // move the h1 rook.
            _addPiece(_matrix[7][7], Coord.f1);
            _removePiece(_matrix[7][7], Coord.h1);

            move.extraInfo = MoveInfo.castleKingSide;
          } else if (move.destination == Coord.c1) {
            // move the a1 rook.
            _addPiece(_matrix[7][0], Coord.d1);
            _removePiece(_matrix[7][0], Coord.a1);

            move.extraInfo = MoveInfo.castleQueenSide;
          }
        }

        if (castlingState.whiteKingMoved == -1) {
          castlingState.whiteKingMoved = _moveId;
        }
      } else {
        if (move.origin == Coord.e8) {
          if (move.destination == Coord.g8) {
            // move the h8 rook.
            _addPiece(_matrix[0][7], Coord.f8);
            _removePiece(_matrix[0][7], Coord.h8);

            move.extraInfo = MoveInfo.castleKingSide;
          } else if (move.destination == Coord.c8) {
            // move the a8 rook.
            _addPiece(_matrix[0][0], Coord.d8);
            _removePiece(_matrix[0][0], Coord.a8);

            move.extraInfo = MoveInfo.castleQueenSide;
          }
        }
        if (castlingState.blackKingMoved == -1) {
          castlingState.blackKingMoved = _moveId;
        }
      }
    } else {
      if (move.piece.type == PieceType.rook) {
        if (move.piece.color == ChessColor.white) {
          if (move.origin == Coord.a1 && castlingState.whiteRookLongMoved == -1) {
            castlingState.whiteRookLongMoved = _moveId;
          } else if (move.origin == Coord.h1 && castlingState.whiteRookShortMoved == -1) {
            castlingState.whiteRookShortMoved = _moveId;
          }
        } else {
          if (move.origin == Coord.a8 && castlingState.blackRookLongMoved == -1) {
            castlingState.blackRookLongMoved = _moveId;
          } else if (move.origin == Coord.h8 && castlingState.blackRookShortMoved == -1) {
            castlingState.blackRookShortMoved = _moveId;
          }
        }
      }
    }

    if (move.pieceRemoved == null) {
      return;
    }

    if (move.pieceRemoved?.type == PieceType.rook) {
      if (move.pieceRemoved?.color == ChessColor.white) {
        if (move.destinationRemoved == Coord.a1 && castlingState.whiteRookLongMoved == -1) {
          castlingState.whiteRookLongMoved = _moveId;
        } else if (move.destinationRemoved == Coord.h1 && castlingState.whiteRookShortMoved == -1) {
          castlingState.whiteRookShortMoved = _moveId;
        }
      } else {
        if (move.destinationRemoved == Coord.a8 && castlingState.blackRookLongMoved == -1) {
          castlingState.blackRookLongMoved = _moveId;
        } else if (move.destinationRemoved == Coord.h8 && castlingState.blackRookShortMoved == -1) {
          castlingState.blackRookShortMoved = _moveId;
        }
      }
    }
  }

  void _handleReverseCastling(Move move) {
    if (move.piece.type != PieceType.king) {
      return;
    }

    if (move.piece.color == ChessColor.white) {
      if (move.extraInfo == MoveInfo.castleKingSide) {
        _addPiece(_matrix[7][5], Coord.h1);
        _removePiece(_matrix[7][5], Coord.f1);
      } else if (move.extraInfo == MoveInfo.castleQueenSide) {
        _addPiece(_matrix[7][3], Coord.a1);
        _removePiece(_matrix[7][3], Coord.d1);
      }
    } else {
      if (move.extraInfo == MoveInfo.castleKingSide) {
        _addPiece(_matrix[0][5], Coord.h8);
        _removePiece(_matrix[0][5], Coord.f8);
      } else if (move.extraInfo == MoveInfo.castleQueenSide) {
        _addPiece(_matrix[0][3], Coord.a8);
        _removePiece(_matrix[0][3], Coord.d8);
      }
    }
  }

  List<int> _getBoardMask() {
    List<int> mask = <int>[0, 0, 0, 0, 0, 0, 0, 0];

    for (int r = 0; r < 8; r++) {
      mask[r] = Piece.getMask(_matrix[r][0]) +
          Piece.getMask(_matrix[r][1]) * 16 +
          Piece.getMask(_matrix[r][2]) * 256 +
          Piece.getMask(_matrix[r][3]) * 4069 +
          Piece.getMask(_matrix[r][4]) * 65536 +
          Piece.getMask(_matrix[r][5]) * 1048576 +
          Piece.getMask(_matrix[r][6]) * 16777216 +
          Piece.getMask(_matrix[r][7]) * 268435456;
    }

    return mask;
  }
}
