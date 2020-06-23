import 'package:flutter/material.dart';

class Carta {
  int id;
  int grupo;
  Color cor;
  bool visivel;
  bool bloqueada;

  Carta({ this.id, this.grupo, this.cor, this.visivel = false, this.bloqueada = false });
}