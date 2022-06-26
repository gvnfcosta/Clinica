import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/app_drawer.dart';
import '../components/produtos_item.dart';
import '../models/produtos_list.dart';
import '../utils/app_routes.dart';

enum FilterOptions {
  Atacado,
  Final,
}

class ProdutosPage extends StatefulWidget {
  const ProdutosPage({Key? key}) : super(key: key);

  @override
  State<ProdutosPage> createState() => _ProdutosPageState();
}

class _ProdutosPageState extends State<ProdutosPage> {
  String _tipo = 'final';
  @override
  Widget build(BuildContext context) {
    final ProdutosList produtos = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerenciar Produtos'),
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            itemBuilder: (_) => [
              const PopupMenuItem(
                value: FilterOptions.Atacado,
                child: Text('Preço Atacado'),
              ),
              const PopupMenuItem(
                value: FilterOptions.Final,
                child: Text('Preço Final'),
              ),
            ],
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                _tipo = 'atacado';
                if (selectedValue == FilterOptions.Final) {
                  _tipo = 'final';
                }
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: (() {
              Navigator.of(context).pushNamed(AppRoutes.PRODUTOS_FORM);
            }),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: produtos.itemsCount,
          itemBuilder: (ctx, i) => Column(
            children: [
              ProdutosItems(produtos.items[i], _tipo),
              const Divider(),
            ],
          ),
        ),
      ),
      drawer: const AppDrawer(),
    );
  }
}
