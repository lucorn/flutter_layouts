class CastlingState {
  int blackKingMoved = -1;
  int blackRookLongMoved = -1;
  int blackRookShortMoved = -1;
  int whiteKingMoved = -1;
  int whiteRookLongMoved = -1;
  int whiteRookShortMoved = -1;

  int _fromMoveId = -1;

  CastlingState();

  void copyFrom(CastlingState state, int moveId) {
    _fromMoveId = moveId;

    blackKingMoved = state.blackKingMoved >= moveId ? -1 : state.blackKingMoved;
    blackRookLongMoved = state.blackRookLongMoved >= moveId ? -1 : state.blackRookLongMoved;
    blackRookShortMoved = state.blackRookShortMoved >= moveId ? -1 : state.blackRookShortMoved;

    whiteKingMoved = state.whiteKingMoved >= moveId ? -1 : state.whiteKingMoved;
    whiteRookLongMoved = state.whiteRookLongMoved >= moveId ? -1 : state.whiteRookLongMoved;
    whiteRookShortMoved = state.whiteRookShortMoved >= moveId ? -1 : state.whiteRookShortMoved;
  }

  void trimLaterMoves(CastlingState state, int moveId) {
    if (blackKingMoved >= moveId) {
      blackKingMoved = state.blackKingMoved >= _fromMoveId ? -1 : state.blackKingMoved;
    }
    if (blackRookLongMoved >= moveId) {
      blackRookLongMoved = state.blackRookLongMoved >= _fromMoveId ? -1 : state.blackRookLongMoved;
    }
    if (blackRookShortMoved >= moveId) {
      blackRookShortMoved = state.blackRookShortMoved >= _fromMoveId ? -1 : state.blackRookShortMoved;
    }

    if (whiteKingMoved >= moveId) {
      whiteKingMoved = state.whiteKingMoved >= _fromMoveId ? -1 : state.whiteKingMoved;
    }
    if (whiteRookLongMoved >= moveId) {
      whiteRookLongMoved = state.whiteRookLongMoved >= _fromMoveId ? -1 : state.whiteRookLongMoved;
    }
    if (whiteRookShortMoved >= moveId) {
      whiteRookShortMoved = state.whiteRookShortMoved >= _fromMoveId ? -1 : state.whiteRookShortMoved;
    }
  }
}
