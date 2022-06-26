import 'package:flutter/material.dart';

import '../components/app_drawer.dart';

class PedidosPage extends StatelessWidget {
  const PedidosPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pedidos'),
      ),
      drawer: const AppDrawer(),
      body: Center(child: Text('Página de Pedidos')),
    );
  }
}
