import 'package:flutter/material.dart';
import 'package:jogo_da_memoria/widgets/game_board.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        leading: Icon(
          Icons.memory,
          color: Colors.white,
        ),
        title: Text(
          'Jogo da Memória',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        child: GameBoard(),
      ),
    );
  }
}
