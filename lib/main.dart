import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/pages/produtos_form_page.dart';
import '../pages/produtos_page.dart';
import '../pages/home.dart';
import '../utils/app_routes.dart';
import 'models/produtos_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProdutosList(),
        ),
      ],
      child: MaterialApp(
        title: 'SHOP',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: Colors.purple,
            secondary: Colors.deepOrange,
            background: Colors.purple,
          ),
          fontFamily: 'Lato',
        ),
        routes: {
          AppRoutes.HOME_PAGE: (ctx) => const Home_Page(),
          AppRoutes.PRODUTOS_PAGE: (ctx) => ProdutosPage(),
          AppRoutes.PRODUTOS_FORM: (ctx) => ProdutosFormPage(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
