import 'package:flutter/material.dart';

import '../components/app_drawer.dart';

class Home_Page extends StatelessWidget {
  const Home_Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clínica'),
      ),
      drawer: const AppDrawer(),
      body: Center(
        child: SizedBox(
            height: 240,
            width: 300,
            child: Image.asset('assets/images/LogoMaura.png',
                fit: BoxFit.contain)),
      ),
    );
  }
}
