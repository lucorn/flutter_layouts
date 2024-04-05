import 'package:flutter_layouts/chess/coord.dart';
import 'package:flutter_layouts/chess/piece.dart';

class PieceLocation {
  final Piece _piece;

  final List<Coord> _locations = [];

  PieceLocation({required Piece piece}) : _piece = piece;

  void addLocation(Coord coord) {
    _locations.add(coord);
  }

  void removeLocation(Coord coord) {
    int index = -1;

    for (int i = 0; i < _locations.length; i++) {
      if (_locations[i] == coord) {
        index = i;
        break;
      }
    }
    if (index == -1) {
      throw 'attempting to location $coord for piece $_piece';
    }
    _locations.removeAt(index);
  }

  Coord getFirstLocation() {
    if (_locations.isEmpty) {
      throw 'no location available for piece $_piece';
    }
    return _locations[0];
  }

  List<Coord> getOtherLocations(Coord coord) {
    List<Coord> loc = [];

    for (int i = 0; i < _locations.length; i++) {
      if (_locations[i] != coord) {
        loc.add(_locations[i]);
      }
    }

    return loc;
  }

  int get locationsCount => _locations.length;
}
