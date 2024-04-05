class Coord {
  final int row;
  final int column;

  const Coord(this.row, this.column);

  Coord.fromNotation(String notation)
      : column = notation.codeUnitAt(0) - 'a'.codeUnitAt(0),
        row = 8 - (notation.codeUnitAt(1) - '0'.codeUnitAt(0));

  static const Coord a1 = Coord(7, 0);
  static const Coord c1 = Coord(7, 2);
  static const d1 = Coord(7, 3);
  static const e1 = Coord(7, 4);
  static const f1 = Coord(7, 5);
  static const g1 = Coord(7, 6);
  static const h1 = Coord(7, 7);

  static const a8 = Coord(0, 0);
  static const c8 = Coord(0, 2);
  static const d8 = Coord(0, 3);
  static const e8 = Coord(0, 4);
  static const f8 = Coord(0, 5);
  static const g8 = Coord(0, 6);
  static const h8 = Coord(0, 7);

  static const coordN = Coord(-1, 0);
  static const coordNW = Coord(-1, -1);
  static const coordNE = Coord(-1, 1);
  static const coordW = Coord(0, -1);
  static const coordE = Coord(0, 1);
  static const coordS = Coord(1, 0);
  static const coordSW = Coord(1, -1);
  static const coordSE = Coord(1, 1);

  static const coordKNNW = Coord(-2, -1);
  static const coordKNNE = Coord(-2, 1);
  static const coordKWNW = Coord(-1, -2);
  static const coordKENE = Coord(-1, 2);
  static const coordKWSW = Coord(1, -2);
  static const coordKESE = Coord(1, 2);
  static const coordKSSW = Coord(2, -1);
  static const coordKSSE = Coord(2, 1);

  static List<Coord> directionsForBishop = <Coord>[
    coordNE,
    coordNW,
    coordSW,
    coordSE,
  ];

  static List<Coord> directionsForRook = <Coord>[
    coordN,
    coordS,
    coordE,
    coordW,
  ];

  static List<Coord> directionsForQueen = <Coord>[
    coordNE,
    coordNW,
    coordSW,
    coordSE,
    coordN,
    coordS,
    coordE,
    coordW,
  ];

  static List<Coord> directionsForKnight = <Coord>[
    coordKNNW,
    coordKNNE,
    coordKWNW,
    coordKENE,
    coordKWSW,
    coordKESE,
    coordKSSW,
    coordKSSE,
  ];

  static List<Coord> directionsForKing = <Coord>[
    coordN,
    coordNW,
    coordNE,
    coordW,
    coordE,
    coordS,
    coordSW,
    coordSE,
  ];

  @override
  String toString() {
    return toNotation();
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Coord &&
          runtimeType == other.runtimeType &&
          row == other.row &&
          column == other.column;

  @override
  int get hashCode => row.hashCode ^ column.hashCode;

  String toNotation() {
    String not =
        String.fromCharCode('a'.codeUnitAt(0) + column) + (8 - row).toString();

    return not;
  }

  String toNotationColumn() {
    return String.fromCharCode('a'.codeUnitAt(0) + column);
  }
}
