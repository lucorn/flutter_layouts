import 'package:flutter_layouts/chess/coord.dart';
import 'package:flutter_layouts/chess/piece.dart';
import 'package:flutter_layouts/chess/piece_location.dart';

class PieceLocationsMap {
  final Map<Piece, PieceLocation> _pieceLocations = <Piece, PieceLocation>{
    Piece.whitePawn: PieceLocation(piece: Piece.whitePawn),
    Piece.whiteRook: PieceLocation(piece: Piece.whiteRook),
    Piece.whiteKnight: PieceLocation(piece: Piece.whiteKnight),
    Piece.whiteBishop: PieceLocation(piece: Piece.whiteBishop),
    Piece.whiteQueen: PieceLocation(piece: Piece.whiteQueen),
    Piece.whiteKing: PieceLocation(piece: Piece.whiteKing),
    Piece.blackPawn: PieceLocation(piece: Piece.blackPawn),
    Piece.blackRook: PieceLocation(piece: Piece.blackRook),
    Piece.blackKnight: PieceLocation(piece: Piece.blackKnight),
    Piece.blackBishop: PieceLocation(piece: Piece.blackBishop),
    Piece.blackQueen: PieceLocation(piece: Piece.blackQueen),
    Piece.blackKing: PieceLocation(piece: Piece.blackKing),
  };

  void addPiece(Piece piece, Coord location) {
    _pieceLocations[piece]?.addLocation(location);
  }

  void removePiece(Piece piece, Coord location) {
    _pieceLocations[piece]?.removeLocation(location);
  }

  Coord getPieceFirstLocation(Piece piece) {
    PieceLocation? pieceLocation = _pieceLocations[piece];
    if (pieceLocation == null) {
      throw 'no location for piece $piece';
    }
    return pieceLocation.getFirstLocation();
  }

  List<Coord> getPieceOtherLocations(Piece piece, Coord location) {
    PieceLocation? pieceLocation = _pieceLocations[piece];
    if (pieceLocation == null) {
      throw 'no location for piece $piece';
    }
    return pieceLocation.getOtherLocations(location);
  }

  int locationsCount(Piece piece) {
    PieceLocation? pieceLocation = _pieceLocations[piece];
    if (pieceLocation == null) {
      throw 'no location for piece $piece';
    }
    return pieceLocation.locationsCount;
  }
}
