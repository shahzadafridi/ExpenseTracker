import 'package:flutter/material.dart';
import '../../resources/color_manager.dart';
import '../../resources/styles_manager.dart';
import 'components /home_header_view.dart';
import 'components /transaction_header_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: const Column(
        children: [HomeHeaderView(), TransactionHeaderView()],
      ),
    );
  }
}


