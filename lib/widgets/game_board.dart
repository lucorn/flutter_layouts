import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
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
    super.initState();
    widget.controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Show the opening
        const Padding(
          padding: EdgeInsets.all(3),
          child: Text(
            'Open sicilian',
            style: TextStyle(fontSize: 16),
          ),
        ),
        // build the board
        Stack(
          children: [
            GridView.builder(
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
            ),
            if (widget.controller.arrows.isNotEmpty)
              IgnorePointer(
                child: AspectRatio(
                  aspectRatio: 1.0,
                  child: CustomPaint(
                    painter: ArrowPainter(widget.controller.arrows, PlayerColor.black),
                    child: Container(),
                  ),
                ),
              ),
          ],
        ),
        AspectRatio(
          aspectRatio: 16,
          child: Container(
            color: Colors.white12,
          ),
        ),
        AspectRatio(
          aspectRatio: 4,
          child: Container(
            color: Colors.orangeAccent,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {},
                child: const Text('What If'),
              ),
              const Text('4..b4'),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(5, 0, 5, 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                  icon: Icon(
                    Icons.keyboard_double_arrow_left,
                    color: widget.controller.canGoBack ? Colors.black : Colors.grey,
                  ),
                  iconSize: 36,
                  tooltip: 'start',
                  onPressed: () {
                    widget.controller.goToBeginning();
                  }),
              IconButton(
                  icon: Icon(
                    Icons.keyboard_arrow_left,
                    color: widget.controller.canGoBack ? Colors.black : Colors.grey,
                  ),
                  iconSize: 36,
                  tooltip: 'previous',
                  onPressed: () {
                    widget.controller.backOneMove();
                  }),
              IconButton(
                  icon: Icon(
                    Icons.keyboard_arrow_right,
                    color: widget.controller.canGoForward ? Colors.black : Colors.grey,
                  ),
                  iconSize: 36,
                  tooltip: 'next',
                  onPressed: () {
                    widget.controller.forwardMove();
                  }),
              IconButton(
                  icon: Icon(
                    Icons.keyboard_double_arrow_right,
                    color: widget.controller.canGoForward ? Colors.black : Colors.grey,
                  ),
                  iconSize: 36,
                  tooltip: 'end',
                  onPressed: () {
                    widget.controller.goToEnd();
                  }),
              badges.Badge(
                badgeContent: const Text('2'),
                badgeStyle: const badges.BadgeStyle(
                  badgeColor: Colors.amber,
                  elevation: 0,
                ),
                position: badges.BadgePosition.topEnd(top: -3, end: 0),
                child: IconButton(
                    icon: const Icon(Icons.people_outlined), iconSize: 36, tooltip: 'watchers', onPressed: () {}),
              ),
              Badge.count(
                  count: 3,
                  textColor: Colors.black,
                  textStyle: const TextStyle(fontSize: 14),
                  backgroundColor: Colors.orangeAccent,
                  child: IconButton(
                      icon: const Icon(Icons.mark_chat_unread_outlined),
                      iconSize: 36,
                      color: Colors.red,
                      tooltip: 'chat',
                      onPressed: () {})),
            ],
          ),
        ),
      ],
    );
  }
}
