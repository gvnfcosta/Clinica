import 'package:flutter/material.dart';
import '../utils/app_routes.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
              title: const Text('CLÍNICA'), automaticallyImplyLeading: false),

          const Divider(),
          // ListTile(
          //   leading: const Icon(Icons.shop),
          //   title: const Text('Loja'),
          //   onTap: () {
          //     Navigator.of(context)
          //         .pushReplacementNamed(AppRoutes.PEDIDOS_PAGINA);
          //   },
          // ),
          // const Divider(),
          // ListTile(
          //   leading: const Icon(Icons.people_alt),
          //   title: const Text('Pacientes'),
          //   onTap: () {
          //     Navigator.of(context)
          //         .pushReplacementNamed(AppRoutes.PACIENTE_PAGE);
          //   },
          // ),
          // const Divider(),
          ListTile(
            leading: const Icon(Icons.list_alt),
            title: const Text('Produtos'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(AppRoutes.PRODUTOS_PAGE);
            },
          ),
        ],
      ),
    );
  }
}
