import 'package:flutter/material.dart';
import 'components /home_header_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: const Column(
        children: [
          HomeHeaderView(),
        ],
      ),
    );
  }
}
