import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:income_expense_tracker/resources/color_manager.dart';
import 'package:income_expense_tracker/resources/styles_manager.dart';
import 'package:intl/intl.dart';
import '../../../model/CategoryModel.dart';
import '../../../model/TransactionModel.dart';
import 'insert_form_tab_button.dart';

class InsertFormView extends StatefulWidget {
  final List<CategoryModel> categories;

  const InsertFormView({super.key, required this.categories});

  @override
  InsertFormViewState createState() => InsertFormViewState();
}

class InsertFormViewState extends State<InsertFormView> {
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
  CategoryModel? selectedCategory;

  int selectedIndex = 0; // 0 for first tab, 1 for second tab

  final List<String> tabs = ['Expense', 'Income'];

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
            Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFF4F5F6),
                borderRadius: BorderRadius.circular(40),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
                child: Row(
                  children: [
                    InsertFormTabButton(
                      title: 'Expense',
                      isSelected: selectedIndex == 0,
                      onTap: () => setState(() => selectedIndex = 0),
                    ),
                    InsertFormTabButton(
                      title: 'Income',
                      isSelected: selectedIndex == 1,
                      onTap: () => setState(() => selectedIndex = 1),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(width: 16, height: 25),
            // Dropdown
            DropdownButtonFormField<CategoryModel>(
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
              items: widget.categories.map((category) {
                return DropdownMenuItem<CategoryModel>(
                  value: category,
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(category.icon),
                        radius: 12,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        category.title,
                        style: getMediumStyle(
                            color: ColorManager.black, fontSize: 14),
                      ),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedCategory = value;
                  // store selected category somewhere for insert
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

  TransactionModel? getTransaction() {
    final title = _titleController.text.trim();
    final amount = _amountController.text.trim();
    final date = selectedDate;

    if (title.isEmpty ||
        amount.isEmpty ||
        date == null ||
        selectedCategory == null) {
      return null;
    }

    return TransactionModel(
      categoryId: selectedCategory!.id,
      title: title,
      amount: amount,
      date: DateFormat('yyyy-MM-dd').format(date),
      type: selectedIndex ,
      // You can pass it via parent if needed
      category: selectedCategory,
    );
  }
}
