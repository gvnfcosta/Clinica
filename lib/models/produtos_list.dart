import 'dart:math';
import 'package:flutter/material.dart';
import '../data/produtos_dados.dart';
import '../models/produtos.dart';

class ProdutosList with ChangeNotifier {
  final List<Produtos> _items = dadosProdutos;

  List<Produtos> get items => [..._items];

  int get itemsCount {
    return _items.length;
  }

  void saveProduct(Map<String, Object> data) {
    bool hasId = data['id'] != null;

    final produtos = Produtos(
        id: Random().nextDouble().toString(),
        nome_produto: data['nome_produto'] as String,
        descricao: data['descricao'] as String,
        preco_final: data['preco_final'] as double,
        preco_atacado: data['preco_atacado'] as double,
        urlImagem: data['urlImagem'] as String);

    if (hasId) {
      updateProduct(produtos);
    } else {
      addProduct(produtos);
    }
  }

  void addProduct(Produtos produtos) {
    _items.add(produtos);
    notifyListeners();
  }

  void updateProduct(Produtos produtos) {
    int index = _items.indexWhere((p) => p.id == produtos.id);

    if (index >= 0) {
      _items[index] = produtos;
      notifyListeners();
    }
  }

  void removeProduct(Produtos produtos) {
    int index = _items.indexWhere((p) => p.id == produtos.id);

    if (index >= 0) {
      _items.removeWhere((p) => p.id == produtos.id);
      notifyListeners();
    }
  }
}
