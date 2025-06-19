import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../model/TransactionModel.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/styles_manager.dart';

class TransactionItem extends StatelessWidget {
  final TransactionModel transaction;

  const TransactionItem({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    final category = transaction.category;
    final icon = category?.icon;
    final title = category?.title ?? 'Unknown';

    return ListTile(
      leading: icon != null && icon.isNotEmpty
          ? Image.network( // assuming it's a network icon
        icon,
        width: 50,
        height: 50,
        errorBuilder: (_, __, ___) => const Icon(Icons.category),
      )
          : const Icon(Icons.category, size: 40, color: Colors.grey),
      title: Text(
        title,
        style: getMediumStyle(color: ColorManager.black, fontSize: 16),
      ),
      subtitle: Text(
        transaction.date,
        style: getRegularStyle(color: ColorManager.lightGrey, fontSize: 13),
      ),
      trailing: Text(
        transaction.type == 1 ? '+\$${transaction.amount}' : '-\$${transaction.amount}',
        style: getSemiBoldStyle(
          color: transaction.type == 1 ? ColorManager.green : ColorManager.red,
          fontSize: 18,
        ),
      ),
    );
  }
}