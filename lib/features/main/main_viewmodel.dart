import 'package:flutter/material.dart';
import 'package:income_expense_tracker/model/CategoryModel.dart';

import '../../data/repository/transaction_repository.dart';
import '../../model/TransactionModel.dart';

enum TimeFilter {
  day,
  week,
  month,
  year,
}

class MainViewModel extends ChangeNotifier {
  final TransactionRepository repository;

  List<TransactionModel> _transactions = [];
  List<TransactionModel> get transactions => _transactions;

  List<CategoryModel> _categories = [];
  List<CategoryModel> get categories => _categories;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  TimeFilter _selectedFilter = TimeFilter.day;
  List<TransactionModel> _filteredTransactions = [];

  TimeFilter get selectedFilter => _selectedFilter;
  List<TransactionModel> get filteredTransactions => _filteredTransactions;

  MainViewModel({required this.repository});

  void setSelectedFilter(TimeFilter filter) {
    _selectedFilter = filter;
    notifyListeners();
  }

  Future<void> fetchFilteredTransactions({DateTime? selectedDate}) async {
    final baseDate = selectedDate ?? DateTime.now();

    if (_isLoading) return;
    _isLoading = true;
    _error = null;
    notifyListeners();

    List<TransactionModel> all = [];

    try {
      all = await repository.fetchTransactions();
    } catch (e, stackTrace) {
      _error = "Error fetching transactions: $e";
      debugPrint(_error);
      debugPrintStack(stackTrace: stackTrace);
      _isLoading = false;
      notifyListeners();
      return;
    }

    DateTime startDate;
    DateTime endDate;

    switch (_selectedFilter) {
      case TimeFilter.day:
        startDate = DateTime(baseDate.year, baseDate.month, baseDate.day);
        endDate = startDate.add(const Duration(days: 1));
        break;

      case TimeFilter.week:
        startDate = baseDate.subtract(Duration(days: baseDate.weekday - 1));
        startDate = DateTime(startDate.year, startDate.month, startDate.day);
        endDate = startDate.add(const Duration(days: 7));
        break;

      case TimeFilter.month:
        startDate = DateTime(baseDate.year, baseDate.month);
        endDate = DateTime(baseDate.year, baseDate.month + 1);
        break;

      case TimeFilter.year:
        startDate = DateTime(baseDate.year);
        endDate = DateTime(baseDate.year + 1);
        break;
    }

    _filteredTransactions = all.where((txn) {
      final txnDate = DateTime.tryParse(txn.date);
      if (txnDate == null) return false;
      return txnDate.isAtSameMomentAs(startDate) || (txnDate.isAfter(startDate) && txnDate.isBefore(endDate));
    }).toList();

    debugPrint("_filteredTransactions = ${_filteredTransactions.map((e) => e.title).toList()}");

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchTransactions() async {

    if (_isLoading) return;
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _transactions = await repository.fetchTransactions();
      debugPrint("transactions = ${_transactions.map((e) => e.title).toList()}");
    } catch (e, stackTrace) {
      _error = "Error fetching transactions: $e";
      debugPrint(_error);
      debugPrintStack(stackTrace: stackTrace);
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchCategories() async {
    if (_isLoading) return;
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _categories = await repository.fetchCategories();
      debugPrint("categories = ${_categories.map((e) => e.title).toList()}");
    } catch (e, stackTrace) {
      debugPrint("Error fetching categories: $e");
      debugPrintStack(stackTrace: stackTrace);
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> insertTransaction(TransactionModel transaction) async {
    if (_isLoading) return;
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await repository.insertTransaction(transaction);
      await fetchTransactions(); // Refresh transactions after insert
    } catch (e) {
      _error = "Error inserting transaction: $e";
      debugPrint(_error);
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> init() async {
    await repository.init(); // initializes DB and seeds categories
    await fetchCategories(); // load categories after DB is ready
    await fetchTransactions(); // optional: load transactions too
  }
}