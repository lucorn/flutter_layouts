import 'package:flutter/material.dart';
import 'package:flutter_layouts/chess/coord.dart';
import 'package:flutter_layouts/chess/piece.dart';
import 'package:flutter_layouts/widgets/chess_controller.dart';

class ChessBoard extends StatefulWidget {
  final ChessController controller;
  const ChessBoard({super.key, required this.controller});

  @override
  State<ChessBoard> createState() => _ChessBoardState();
}

class _ChessBoardState extends State<ChessBoard> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 8),
      itemBuilder: (context, index) {
        var row = index ~/ 8;
        var column = index % 8;

        Piece? piece = widget.controller.getPiece(Coord(row, column));

        return Container(
          color: (row + column) % 2 == 0 ? Colors.white : Colors.orangeAccent[400],
          child: piece != null ? Image.asset(Piece.getImageForPiece(piece)) : const SizedBox(),
        );
      },
      itemCount: 64,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
    );
  }
}
