import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jogo_da_memoria/model/carta.model.dart';

class GameBoard extends StatefulWidget {
  @override
  _GameBoardState createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  List<Carta> _cartas = [];
  List<Carta> _cartasValidadas = [];
  int _pontos = 0;
  
  @override
  void initState() {
    _criarListaCartas();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _criarGridCartas();
  }

  Widget _criarGridCartas() {
    return Center(
      child: GridView.count(
        padding: EdgeInsets.all(15),
        crossAxisCount: 4,
        children: _criarItensGrid(),
      ),
    );
  }

  void _criarListaCartas() {
    this._cartas = [
      Carta(id: 1, grupo: 1, cor: Colors.red),
      Carta(id: 2, grupo: 1, cor: Colors.red),
      Carta(id: 3, grupo: 2, cor: Colors.blue),
      Carta(id: 4, grupo: 2, cor: Colors.blue),
      Carta(id: 5, grupo: 3, cor: Colors.amber),
      Carta(id: 6, grupo: 3, cor: Colors.amber),
      Carta(id: 7, grupo: 4, cor: Colors.brown),
      Carta(id: 8, grupo: 4, cor: Colors.brown),
      Carta(id: 9, grupo: 5, cor: Colors.pink),
      Carta(id: 10, grupo: 5, cor: Colors.pink),
      Carta(id: 11, grupo: 6, cor: Colors.purple),
      Carta(id: 12, grupo: 6, cor: Colors.purple),
      Carta(id: 13, grupo: 7, cor: Colors.orange),
      Carta(id: 14, grupo: 7, cor: Colors.orange),
      Carta(id: 15, grupo: 8, cor: Colors.cyan),
      Carta(id: 16, grupo: 8, cor: Colors.cyan),
      Carta(id: 17, grupo: 9, cor: Colors.indigo),
      Carta(id: 18, grupo: 9, cor: Colors.indigo),
      Carta(id: 19, grupo: 10, cor: Colors.teal),
      Carta(id: 20, grupo: 10, cor: Colors.teal),
      Carta(id: 21, grupo: 11, cor: Colors.lime),
      Carta(id: 22, grupo: 11, cor: Colors.lime),
      Carta(id: 23, grupo: 12, cor: Colors.deepPurple),
      Carta(id: 24, grupo: 12, cor: Colors.deepPurple),
    ];

    _cartas.shuffle();
  }

  List<Widget> _criarItensGrid() {
    return _cartas.map((carta) => _criarCardCarta(carta)).toList();
  }

  Widget _criarCardCarta(Carta carta) {
    return GestureDetector(
      child: Card(
        color: carta.visivel ? carta.cor : Colors.grey,
        child: Center(
          child: _criarTextoCard(carta),
        ),
      ),
      onTap: () => _mudarVisualizacao(carta),
    );
  }

  Widget _criarTextoCard(Carta carta) {
    if (carta.bloqueada) {
      return Icon(Icons.check_circle_outline, color: Colors.white);
    } else if (carta.visivel) {
      return Text(
        carta.grupo.toString(),
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w400,
          fontSize: 24,
        ),
      );
    } else {
      return Icon(
        Icons.memory,
        color: Colors.white,
      );
    }
  }

  void _mudarVisualizacao(Carta carta) {
    if (carta.bloqueada != true) {
      setState(() {
        carta.visivel = !carta.visivel;
      });
    }

    _validarAcerto();
  }

  void _validarAcerto() {
    List<Carta> cartasViradas = _listarCartasVisiveis();
    if (cartasViradas.length == 2) {
      if (cartasViradas[0].grupo == cartasViradas[1].grupo) {
        setState(() {
          cartasViradas.forEach((Carta carta) {
            carta.bloqueada = true;
            carta.cor = Colors.green[600];
            _cartasValidadas.add(carta);
          });
        });
        
        _aumentarPontuacao();
      } else {
        Timer(
          Duration(milliseconds: 500),
          () => {
            cartasViradas.forEach((Carta carta) {
              setState(() {
                carta.bloqueada = false;
                carta.visivel = false;
              });
            }),
          }
        );

        _diminuirPontuacao();
      }
    }

    if (_cartasValidadas.length > 0) {
      if (_cartasValidadas.length == _cartas.length) {
        print(_cartasValidadas.length);
        _reiniciar();
      }
    }
  }

  void _reiniciar() {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text('Parabéns, Você Venceu !! \nFez $_pontos pontos'),
        duration: Duration(seconds: 8),
        action: SnackBarAction(
          label: 'Reiniciar',
          onPressed: () {
            setState(() {
              _criarListaCartas();
              _criarGridCartas();
              _cartasValidadas.clear();
              _pontos = 0;
            });
          },
        ),
      ),
    );
  }

  void _aumentarPontuacao() {
    setState(() {
      _pontos += 25;
    });
    _mostrarPontuacao();
  }

  void _diminuirPontuacao() {
    setState(() {
      _pontos -= 5; 
    });
  }

  void _mostrarPontuacao() {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text('Pontuação: ${_pontos}'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  List<Carta> _listarCartasVisiveis() {
    return this._cartas.where(
      (Carta carta) => carta.visivel && !carta.bloqueada,
    ).toList();
  }
}
