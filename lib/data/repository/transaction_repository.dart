import 'package:income_expense_tracker/model/CategoryModel.dart';

import '../../model/TransactionModel.dart';

abstract class TransactionRepository {
  Future<void> init();
  Future<void> insertTransaction(TransactionModel transaction);
  Future<List<TransactionModel>> fetchTransactions();
  Future<List<CategoryModel>> fetchCategories();
  Future<void> deleteTransaction(String title);
  Future<void> clearAllTransactions();
}