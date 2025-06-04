class TransactionModel {
  final String icon;
  final String title;
  final String subtitle;
  final String amount;
  final bool isIncome;

  TransactionModel({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.isIncome,
  });
}