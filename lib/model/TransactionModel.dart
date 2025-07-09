import 'CategoryModel.dart';

class TransactionModel {
  final String categoryId;
  final String title;
  final String amount;
  final String date;
  final int type;
  final CategoryModel? category; // optional, used when joining

  TransactionModel({
    required this.categoryId,
    required this.title,
    required this.amount,
    required this.date,
    required this.type,
    this.category,
  });

  Map<String, dynamic> toJson() => {
    'categoryId': categoryId,
    'title': title,
    'amount': amount,
    'date': date,
    'type': type ,
  };

  factory TransactionModel.fromJson(Map<String, dynamic> json,
      {CategoryModel? category}) {
    return TransactionModel(
      categoryId: json['categoryId'],
      title: json['title'],
      amount: json['amount'],
      date: json['date'],
      type: json['type'],
      category: category,
    );
  }
}