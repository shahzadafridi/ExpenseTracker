import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:income_expense_tracker/resources/color_manager.dart';
import 'package:income_expense_tracker/resources/styles_manager.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

import '../../../utils/categories.dart';

class InsertFormView extends StatefulWidget {
  const InsertFormView({super.key});

  @override
  _InsertFormViewState createState() => _InsertFormViewState();
}

class _InsertFormViewState extends State<InsertFormView> {
  final TextEditingController _titleController =
      TextEditingController(text: '');
  final FocusNode _focusTitletNode = FocusNode();
  bool _showTitleClear = false;

  final TextEditingController _amountController =
      TextEditingController(text: '');
  final FocusNode _focusAmountNode = FocusNode();
  bool _showAmountClear = false;

  DateTime? selectedDate; // initially null
  final formatCurrency = NumberFormat.simpleCurrency(decimalDigits: 2);
  String dropdownValue = '';

  @override
  void initState() {
    super.initState();
    _titleController.addListener(_updateClearState);
    _amountController.addListener(_updateClearState);
    _focusTitletNode.addListener(_updateClearState);
    _focusAmountNode.addListener(_updateClearState);
  }

  void _updateClearState() {
    setState(() {
      _showTitleClear =
          _titleController.text.isNotEmpty && _focusTitletNode.hasFocus;
      _showAmountClear =
          _amountController.text.isNotEmpty && _focusAmountNode.hasFocus;
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    _focusTitletNode.dispose();
    _focusAmountNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 16, right: 16, top: 32, bottom: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Dropdown
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'CATEGORY',
                labelStyle: getRegularStyle(
                    color: ColorManager.lightGrey, fontSize: 12),
                border: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: ColorManager.lightGrey, width: 1),
                    borderRadius: BorderRadius.circular(8)),
              ),
              hint: Text(
                'Select Category',
                style: getRegularStyle(
                  color: ColorManager.lightGrey,
                  fontSize: 14,
                ),
              ),
              icon: const Icon(Icons.arrow_drop_down),
              items: categories.map((category) {
                return DropdownMenuItem<String>(
                  value: category['name'],
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(category['icon']),
                        radius: 12,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        category['name'],
                        style: getMediumStyle(
                            color: ColorManager.black, fontSize: 14),
                      ),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  dropdownValue = value!;
                });
              },
            ),

            const SizedBox(height: 20),

            // Title field with clear
            Stack(
              alignment: Alignment.centerRight,
              children: [
                TextField(
                  controller: _titleController,
                  focusNode: _focusTitletNode,
                  keyboardType: TextInputType.multiline,
                  // allow multiline
                  maxLines: 4,
                  // removes line limit
                  style:
                      getMediumStyle(color: ColorManager.black, fontSize: 14),
                  // Set text color to black
                  decoration: InputDecoration(
                    hintText: 'Enter title',
                    hintStyle: getRegularStyle(
                      color: ColorManager.lightGrey,
                      fontSize: 14,
                    ),
                    labelText: 'TITLE',
                    labelStyle: getRegularStyle(
                        color: ColorManager.lightGrey, fontSize: 12),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: ColorManager.lightGrey, width: 1),
                        borderRadius: BorderRadius.circular(8)),
                  ),
                ),
                _showTitleClear
                    ? TextButton(
                        onPressed: () => _titleController.clear(),
                        child: Text(
                          'Clear',
                          style: getRegularStyle(
                              color: ColorManager.lightGrey, fontSize: 12),
                        ),
                      )
                    : const SizedBox(),
              ],
            ),

            const SizedBox(height: 20),

            // Amount field with clear
            Stack(
              alignment: Alignment.centerRight,
              children: [
                TextField(
                  controller: _amountController,
                  focusNode: _focusAmountNode,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  style:
                      getMediumStyle(color: ColorManager.black, fontSize: 14),
                  // Set text color to black
                  decoration: InputDecoration(
                    prefixText: '\$ ',
                    hintText: '00.00',
                    hintStyle: getRegularStyle(
                        color: ColorManager.lightGrey, fontSize: 14),
                    labelText: 'AMOUNT',
                    labelStyle: getRegularStyle(
                        color: ColorManager.lightGrey, fontSize: 12),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: ColorManager.lightGrey, width: 1),
                        borderRadius: BorderRadius.circular(8)),
                  ),
                ),
                _showAmountClear
                    ? TextButton(
                        onPressed: () => _amountController.clear(),
                        child: Text(
                          'Clear',
                          style: getRegularStyle(
                              color: ColorManager.lightGrey, fontSize: 12),
                        ),
                      )
                    : const SizedBox(),
              ],
            ),

            const SizedBox(height: 20),

            // Date Picker
            InkWell(
              onTap: () => _selectDate(context),
              child: InputDecorator(
                decoration: InputDecoration(
                  labelText: 'DATE',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      selectedDate != null
                          ? DateFormat('d MMM yyyy').format(selectedDate!)
                          : 'Choose date',
                      style: getMediumStyle(
                        color: selectedDate != null
                            ? ColorManager.black
                            : ColorManager.lightGrey,
                        fontSize: 14,
                      ),
                    ),
                    Icon(
                      Icons.calendar_today,
                      size: 20,
                      color: ColorManager.lightGrey,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }
}
