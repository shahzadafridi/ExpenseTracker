import 'package:flutter/material.dart';
import 'package:income_expense_tracker/resources/color_manager.dart';
import 'package:income_expense_tracker/resources/styles_manager.dart';

class InsertFormTabButton extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const InsertFormTabButton({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor: isSelected ? ColorManager.primary : Colors.transparent,
            elevation: 0,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
            padding: EdgeInsets.zero,
          ),
          child: Center(
            child: Text(
              title,
              style: getMediumStyle(
                color: isSelected ? ColorManager.white : ColorManager.black,
                fontSize: 14
              ),
            ),
          ),
        ),
      ),
    );
  }
}
