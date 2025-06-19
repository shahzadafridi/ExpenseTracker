import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';
import 'package:path/path.dart';
import '../../model/CategoryModel.dart';
import '../../model/TransactionModel.dart';

class TransactionDatabaseService {
  Database? _db;
  final _uuid = Uuid();

  /// Initialize the local SQLite database with `categories` and `transactions` tables.
  Future<void> init() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'transactions.db');

    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE IF NOT EXISTS categories (
          id TEXT PRIMARY KEY,
          title TEXT,
          icon TEXT
        )
      ''');

        await db.execute('''
        CREATE TABLE IF NOT EXISTS transactions (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          categoryId TEXT,
          title TEXT,
          amount TEXT,
          date TEXT,
          type INTEGER,
          FOREIGN KEY (categoryId) REFERENCES categories (id)
        )
      ''');
      },
    );
  }

  /// Insert a new transaction
  Future<void> insertTransaction(TransactionModel transaction) async {
    await _db?.insert(
      'transactions',
      transaction.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Insert a new category
  Future<void> insertCategory(CategoryModel category) async {
    await _db?.insert(
      'categories',
      category.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Fetch all transactions along with their category details
  Future<List<TransactionModel>> fetchTransactions() async {
    final result = await _db?.rawQuery('''
      SELECT t.*, c.title as categoryTitle, c.icon as categoryIcon
      FROM transactions t
      LEFT JOIN categories c ON t.categoryId = c.id
    ''');

    return result?.map((row) {
      final category = CategoryModel(
        id: row['categoryId'] as String,
        title: row['categoryTitle'] as String,
        icon: row['categoryIcon'] as String,
      );

      return TransactionModel.fromJson(row, category: category);
    }).toList() ??
        [];
  }

  /// Fetch all categories from the database
  Future<List<CategoryModel>> fetchCategories() async {
    final result = await _db?.query('categories');

    return result?.map((row) {
      return CategoryModel(
        id: row['id'] as String,
        title: row['title'] as String,
        icon: row['icon'] as String,
      );
    }).toList() ?? [];
  }

  /// Delete transaction by title (you may change to use an ID instead)
  Future<void> deleteTransaction(String title) async {
    await _db?.delete(
      'transactions',
      where: 'title = ?',
      whereArgs: [title],
    );
  }

  /// Delete all transactions
  Future<void> clearAllTransactions() async {
    await _db?.delete('transactions');
  }

  Future<void> seedDefaultCategories() async {
    final List<Map<String, dynamic>> categories = [
      {
        'name': 'Groceries',
        'icon': 'https://cdn-icons-png.flaticon.com/512/3075/3075977.png'
      },
      {
        'name': 'Transportation',
        'icon': 'https://cdn-icons-png.flaticon.com/512/854/854878.png'
      },
      {
        'name': 'Dining Out',
        'icon': 'https://cdn-icons-png.flaticon.com/512/1046/1046784.png'
      },
      {
        'name': 'Utilities',
        'icon': 'https://cdn-icons-png.flaticon.com/512/3079/3079365.png'
      },
      {
        'name': 'Rent',
        'icon': 'https://cdn-icons-png.flaticon.com/512/809/809957.png'
      },
      {
        'name': 'Health',
        'icon': 'https://cdn-icons-png.flaticon.com/512/2965/2965567.png'
      },
      {
        'name': 'Education',
        'icon': 'https://cdn-icons-png.flaticon.com/512/2942/2942605.png'
      },
      {
        'name': 'Internet',
        'icon': 'https://cdn-icons-png.flaticon.com/512/1041/1041916.png'
      },
      {
        'name': 'Phone Bill',
        'icon': 'https://cdn-icons-png.flaticon.com/512/726/726623.png'
      },
      {
        'name': 'Shopping',
        'icon': 'https://cdn-icons-png.flaticon.com/512/1170/1170678.png'
      },
      {
        'name': 'Travel',
        'icon': 'https://cdn-icons-png.flaticon.com/512/201/201623.png'
      },
      {
        'name': 'Insurance',
        'icon': 'https://cdn-icons-png.flaticon.com/512/1041/1041883.png'
      },
      {
        'name': 'Subscriptions',
        'icon': 'https://cdn-icons-png.flaticon.com/512/943/943804.png'
      },
      {
        'name': 'Entertainment',
        'icon': 'https://cdn-icons-png.flaticon.com/512/3342/3342137.png'
      },
      {
        'name': 'Other',
        'icon': ''
      },
    ];

    for (final item in categories) {
      final existing = await _db?.query(
        'categories',
        where: 'title = ?',
        whereArgs: [item['name']],
        limit: 1,
      );

      if (existing == null || existing.isEmpty) {
        final category = CategoryModel(
          id: _uuid.v4(), // Generate a unique UUID
          title: item['name'] ?? '',
          icon: item['icon'] ?? '',
        );

        await insertCategory(category);
      }
    }
  }

  /// Close the database
  Future<void> close() async {
    await _db?.close();
  }
}