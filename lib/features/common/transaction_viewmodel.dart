import 'package:flutter/material.dart';
import 'package:income_expense_tracker/model/CategoryModel.dart';

import '../../data/repository/transaction_repository.dart';
import '../../model/TransactionModel.dart';

class TransactionViewModel extends ChangeNotifier {
  final TransactionRepository repository;

  List<TransactionModel> _transactions = [];
  List<TransactionModel> get transactions => _transactions;

  List<CategoryModel> _categories = [];
  List<CategoryModel> get categories => _categories;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  TransactionViewModel({required this.repository});

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