import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/pages/produtos_page.dart';
import '../models/produtos.dart';
import '../models/produtos_list.dart';
import '../utils/app_routes.dart';

class ProdutosItems extends StatelessWidget {
  final Produtos produtos;
  //final ProdutosPage _tipo;
  const ProdutosItems(this.produtos, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final preco = produtos.preco_atacado.toString();
    if (_tipo == 'final') {
      String preco = produtos.preco_final.toString();
    }
    return ListTile(
      leading: CircleAvatar(
          backgroundColor: Colors.amberAccent,
          backgroundImage: NetworkImage(produtos.urlImagem)),
      title: Text(
        '${produtos.nome_produto} ${produtos.descricao}   - R\$ $preco',
        style: const TextStyle(fontSize: 14),
      ),
      trailing: Container(
          width: 80,
          child: Row(
            children: [
              IconButton(
                  icon: const Icon(Icons.edit),
                  color: Colors.purple,
                  onPressed: () {
                    Navigator.of(context).pushNamed(AppRoutes.PRODUTOS_FORM,
                        arguments: produtos);
                  }),
              IconButton(
                  icon: const Icon(Icons.delete),
                  color: Theme.of(context).errorColor,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                          title: const Text('Excluir Produto'),
                          content: const Text('Tem certeza?'),
                          actions: [
                            TextButton(
                                child: const Text('NÃO'),
                                onPressed: () => Navigator.of(ctx).pop()),
                            TextButton(
                                child: const Text('SIM'),
                                onPressed: () {
                                  Provider.of<ProdutosList>(context,
                                          listen: false)
                                      .removeProduct(produtos);
                                  Navigator.of(ctx).pop();
                                }),
                          ]),
                    );
                  }),
            ],
          )),
    );
  }
}
