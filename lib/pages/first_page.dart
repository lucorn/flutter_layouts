import 'package:flutter/material.dart';
import 'package:flutter_layouts/widgets/chess_controller.dart';
import 'package:flutter_layouts/widgets/game_board.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  final ChessController chessController = ChessController(
      moves:
          'Pe2Ee4:34,Pg7Eg6:50,Pd2Ed4:55,Bf8Eg7:56,Ng1Ef3:49,Pe7Ee6:83,Nb1Ec3:81,Ng8Ee7:127,Bc1Eg5:58:h2h4:h7h5:c1g5:f7f6:g5e3,Ke8Eg8:142:h7h6:g5f4:d7d6:d1d2:a7a6,Qd1Ed2:141,Pd7Ed6:181,Ke1Ec1:176,Nb8Ec6a:182,Bg5Eh6:162,Pf7Ef5:239:f7f6:h2h4:g7h6:d2h6:g8h8,Ph2Eh4:245,Pf5Pe4:258,Nc3Pe4:241,Ne7Ef5:295:d6d5:h6g7:g8g7:e4c5:d8d6,Bh6Eg5:151:h6g7:f5g7:h4h5:g7h5:f1d3,Qd8Ee8:144,Pc2Ec3:128,Pd6Ed5:204:e8f7:h4h5:g6h5:f1d3:e6e5,Ne4Ec5:108:e4g3:f5g3:f2g3:e6e5:d4e5,Bg7Ef6:367:b7b6:c5d3:f5d6:h4h5:d6c4,Rd1Ee1:251:g5f6:f8f6:f1b5:f5d6:b5c6,Pb7Eb6:303:f6g7:h4h5:h7h6:g2g4:f5d4,Nc5Ed3:299,Pa7Ea5:413:f6g7:h4h5:h7h6:g5f4:g6g5,Pg2Eg4:274:g5f6:f8f6:h4h5:c8a6:d3f4,Nf5Ed6:277,Ph4Eh5:257,Nd6Ee4:282,Qd2Ee3:278,Qe8Ee7:384:e4g5:f3g5:h7h6:g5e6:e8e6,Bg5Eh6:325:g5f6:e7f6:h5g6:f6g6:f1e2,Rf8Ef7:438:g6g5:h6f8:e7f8:h5h6:c8d7,Ph5Pg6:424,Ph7Pg6:424,Nd3Ee5a:205:g4g5:f6g7:h6g7:g8g7:d3e5,Nc6Ne5:473:f6e5:f1b5:f7f3:e3f3:c6d4,Pd4Ne5:470,Bf6Eg7:471,Bh6Bg7:450,Rf7Bg7:445,Qe3Eh6:357:f1d3:e4c5:d3c2:c8a6:h1h6,Kg8Ef7:528:g7h7:h6g6:h7g7:g6h6:c8b7,Qh6Ef4+:358:f1b5:c8d7:b5d7:e7d7:e1e4,Kf7Eg8:332,Nf3Ed4:80:f4h6:g7h7:h6g6:h7g7:g6h6,Bc8Ed7:84,Pf2Ef3:83,Ne4Eg5:77,Bf1Ee2:73,Pc7Ec5:78,Nd4Ec2:84,Ra8Ef8:66,Qf4Eg3:-26:f4e3:d7c6:e1f1:b6b5:h1h2,Kg8Ef7:118:g7h7:e1f1:e7f7:h1h2:f7f4,Rh1Eh2:-1:c3c4:f7e8:f3f4:g5e4:g3b3,Pb6Eb5:79:f7e8:e1h1:d7c6:h2h8:e8d7,Re1Eh1a:54,Pb5Eb4:84,Pf3Ef4:44,Ng5Ee4:38,Qg3Ee3:0,Pb4Pc3:97:g6g5:e2d3:g5f4:e3f4:f7e8,Pb2Pc3:4:e2f3:c3b2:c1b2:d7c6:b2a1,Pc5Ec4:181:g6g5:e2d3:g5f4:e3f3:e4g5,Rh2Eh7:34:e2f3:e7c5:f3e4:c5e3:c2e3,Rf8Eg8a:240:e7c5:h7g7:f7g7:e3h3:g7f7,Rh1Eh2a:13:e2f3:e4c5:f4f5:g6f5:g4f5,Bd7Ea4:122:e7c5:e3c5:e4c5:c2d4:g8f8,Be2Ef3:134,Ba4Nc2:127,Rh7Rg7+:0:c1c2:e7c5:e3d4:g8f8:h7h8,Rg8Rg7:144:f7g7:c1c2:e7c5:e3c5:e4c5,Rh2Bc2:-22:c1c2:e7c5:e3d4:f7e8:f3e4,Qe7Ea3+:43:e4c5:c1d1:f7g8:f4f5:c5d3,Kc1Ed1:48,Ne4Ec5:338:a3c5:e3d4:g7h7:f3e4:c5d4,Pf4Ef5:338,Pg6Pf5:338,Pg4Pf5:304,Pe6Pf5:484:f7e8:f5e6:c5a4:f3d5:a3c5,Bf3Pd5+:429:f3d5:f7e8:e3h6:g7d7:h6c6,Kf7Ee7:540:f7e8:e3h6:g7d7:h6c6:e8e7,Bd5Pc4:82:e3h6:g7g1:d1e2:c5a4:h6f6,Rg7Eg4:378:c5d7:e3f2:g7g4:f2f5:g4g1,Qe3Eh3:11:c4e2:g4g8:e2c4:g8g4:e3h6,Rg4Eg1+:187:a3a4:h3h7:e7d8:c4f1:c5e4,Kd1Ee2:170,Nc5Ee4:176,Qh3Eh7+:160,Ke7Ed8:120,Qh7Eh4+:0:h7a7:g1g2:e2d1:g2c2:a7d4,Qa3Ee7:14,Qh4Eh8+:-24,Kd8Ec7:-28,Qh8Eh2:-557:c4d3:e7f7:h8h6:f7d5:h6h7,Ne4Eg3+:-13:e7g7:e5e6:c7c6:h2h3:g7e5,Ke2Ef3:-14,Qe7Ec5:1000000:e7g7:h2h3:g7e5:h3h7:c7c6,Qh2Eh7+:1000000,Kc7Ec6:1000000,Qh7Eg6+:1000000,Kc6Ec7:1000000,Qg6Ef7+:1000000,Kc7Ec6:1000000,Qf7Ef6+:1000000,Kc6Ec7:1000000,Qf6Ef7+:1000000,Kc7Ec6:1000000,Rc2Ed2:1000000,Qc5Pe5:1000000,Qf7Ed7+:1000000,Kc6Eb6:1000000,Rd2Eb2+:1000000,Kb6Ec5:1000000,Qd7Eb5+:1000000,Kc5Ed6:1000000,Rb2Ed2+:1000000,Kd6Ee7:1000000,Qb5Qe5+:1000000:b5e5:e7f8:d2d8');

  @override
  void dispose() {
    super.dispose();
    chessController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Title of the page'),
        centerTitle: true,
        backgroundColor: Colors.grey[100],
      ),
      body: ChessBoard(controller: chessController),
    );
  }
}
