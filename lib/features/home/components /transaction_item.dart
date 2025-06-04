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
    return ListTile(
      leading: Image.asset(
        transaction.icon,
        width: 50,
        height: 50,
      ),
      title: Text(
        transaction.title,
        style: getMediumStyle(color: ColorManager.black, fontSize: 16),
      ),
      subtitle: Text(
        transaction.subtitle,
        style: getRegularStyle(color: ColorManager.lightGrey, fontSize: 13),
      ),
      trailing: Text(
        transaction.isIncome ? '+\$${transaction.amount}' : '-\$${transaction.amount}',
        style: getSemiBoldStyle(
          color: transaction.isIncome ? ColorManager.green : ColorManager.red,
          fontSize: 18,
        ),
      ),
    );
  }
}