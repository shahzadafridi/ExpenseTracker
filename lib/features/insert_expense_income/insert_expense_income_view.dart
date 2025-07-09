import 'package:flutter/material.dart';

class InsertExpenseIncomeView extends StatelessWidget {
  const InsertExpenseIncomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Insert Expense Income'),
      ),
      body: Center(
        child: Text(
          'Welcome to the Insert Expense Income Page',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 24,
              ),
        ),
      ),
    );
  }
}
