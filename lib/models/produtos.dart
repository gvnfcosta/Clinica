import 'package:flutter/foundation.dart';

class Produtos with ChangeNotifier {
  final String id;
  final String nome_produto;
  final String descricao;
  final double preco_atacado;
  //final double preco_terapeuta;
  final double preco_final;
  final String urlImagem;

  Produtos({
    required this.id,
    required this.nome_produto,
    required this.descricao,
    required this.preco_atacado,
    //required this.preco_terapeuta,
    required this.preco_final,
    required this.urlImagem,
  });
}
