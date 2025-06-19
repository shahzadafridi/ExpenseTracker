import '../../model/CategoryModel.dart';
import '../../model/TransactionModel.dart';
import '../local/transaction_database_service.dart';
import 'transaction_repository.dart';

class TransactionRepositoryImpl extends TransactionRepository {
  final TransactionDatabaseService dbService;

  TransactionRepositoryImpl({required this.dbService});

  @override
  Future<void> init() async {
    await dbService.init();
    await dbService.seedDefaultCategories();
  }

  @override
  Future<void> insertTransaction(TransactionModel transaction) =>
      dbService.insertTransaction(transaction);

  @override
  Future<List<TransactionModel>> fetchTransactions() =>
      dbService.fetchTransactions();

  @override
  Future<List<CategoryModel>> fetchCategories() {
    return dbService.fetchCategories();
  }

  @override
  Future<void> deleteTransaction(String title) =>
      dbService.deleteTransaction(title);

  @override
  Future<void> clearAllTransactions() =>
      dbService.clearAllTransactions();

}