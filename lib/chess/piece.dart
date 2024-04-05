enum ChessColor {
  white,
  black,
}

enum PieceType {
  none,
  pawn,
  rook,
  knight,
  bishop,
  queen,
  king,
}

class Piece {
  final PieceType type;
  final ChessColor color;

  const Piece(this.type, this.color);

  factory Piece.fromNotation(String notation, ChessColor color) {
    PieceType type = PieceType.none;

    switch (notation) {
      case 'E':
        type = PieceType.none;
        break;
      case 'P':
        type = PieceType.pawn;
        break;
      case 'R':
        type = PieceType.rook;
        break;
      case 'N':
        type = PieceType.knight;
        break;
      case 'B':
        type = PieceType.bishop;
        break;
      case 'Q':
        type = PieceType.queen;
        break;
      case 'K':
        type = PieceType.king;
        break;
    }

    return Piece(type, color);
  }

  static Piece whitePawn = const Piece(PieceType.pawn, ChessColor.white);
  static Piece blackPawn = const Piece(PieceType.pawn, ChessColor.black);
  static Piece whiteQueen = const Piece(PieceType.queen, ChessColor.white);
  static Piece blackQueen = const Piece(PieceType.queen, ChessColor.black);
  static Piece whiteRook = const Piece(PieceType.rook, ChessColor.white);
  static Piece blackRook = const Piece(PieceType.rook, ChessColor.black);
  static Piece whiteBishop = const Piece(PieceType.bishop, ChessColor.white);
  static Piece blackBishop = const Piece(PieceType.bishop, ChessColor.black);
  static Piece whiteKnight = const Piece(PieceType.knight, ChessColor.white);
  static Piece blackKnight = const Piece(PieceType.knight, ChessColor.black);
  static Piece whiteKing = const Piece(PieceType.king, ChessColor.white);
  static Piece blackKing = const Piece(PieceType.king, ChessColor.black);

  static String notationEmpty = "E";

  static int getMask(Piece? piece) {
    if (piece == null) {
      return 0;
    }

    int mask = piece.type.index;
    if (piece.color == ChessColor.black) {
      mask += 8;
    }
    return mask;
  }

  static String getImageForPiece(Piece? piece) {
    if (piece == null) {
      return '';
    }
    String pieceTypeName = '';

    switch (piece.type) {
      case PieceType.bishop:
        pieceTypeName = 'bishop';
        break;
      case PieceType.knight:
        pieceTypeName = 'knight';
        break;
      case PieceType.rook:
        pieceTypeName = 'rook';
        break;
      case PieceType.pawn:
        pieceTypeName = 'pawn';
        break;
      case PieceType.queen:
        pieceTypeName = 'queen';
        break;
      case PieceType.king:
        pieceTypeName = 'king';
        break;
      case PieceType.none:
        pieceTypeName = '';
        break;
    }
    String col = piece.color == ChessColor.white ? 'white' : 'black';

    String img = 'images/${pieceTypeName}_${col}_2.png';

    return img;
  }

  String toNotation() {
    String c = '.';

    switch (type) {
      case PieceType.none:
        c = 'E';
        break;
      case PieceType.pawn:
        c = 'P';
        break;
      case PieceType.rook:
        c = 'R';
        break;
      case PieceType.knight:
        c = 'N';
        break;
      case PieceType.bishop:
        c = 'B';
        break;
      case PieceType.queen:
        c = 'Q';
        break;
      case PieceType.king:
        c = 'K';
        break;
    }

    return c;
  }

  @override
  String toString() {
    String c = color == ChessColor.white ? "W" : "B";
    return "${toNotation()}$c";
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Piece &&
          runtimeType == other.runtimeType &&
          type == other.type &&
          color == other.color;

  @override
  int get hashCode => type.hashCode ^ color.hashCode;

  static bool isNotationValid(String notation) => (notation == 'E' ||
      notation == 'P' ||
      notation == 'R' ||
      notation == 'N' ||
      notation == 'B' ||
      notation == 'Q' ||
      notation == 'K');
}
