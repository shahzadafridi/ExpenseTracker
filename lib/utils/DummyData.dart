import '../model/TransactionModel.dart';
import '../resources/assets_manager.dart';

final List<TransactionModel> transactionList = [
  TransactionModel(
    icon: ImageAssets.transactionIcon,
    title: "Upwork",
    subtitle: "Today",
    amount: "23424",
    isIncome: false,
  ),
  TransactionModel(
    icon: ImageAssets.notification,
    title: "Notification",
    subtitle: "Yesterday",
    amount: "12123",
    isIncome: true,
  ),
  TransactionModel(
    icon: ImageAssets.transactionIcon,
    title: "Freelance",
    subtitle: "May 30",
    amount: "5400",
    isIncome: true,
  ),
  TransactionModel(
    icon: ImageAssets.notification,
    title: "Groceries",
    subtitle: "May 29",
    amount: "320",
    isIncome: false,
  ),
  TransactionModel(
    icon: ImageAssets.transactionIcon,
    title: "Rent",
    subtitle: "May 28",
    amount: "15000",
    isIncome: false,
  ),
  TransactionModel(
    icon: ImageAssets.notification,
    title: "Salary",
    subtitle: "May 27",
    amount: "65000",
    isIncome: true,
  ),
  TransactionModel(
    icon: ImageAssets.transactionIcon,
    title: "Netflix",
    subtitle: "May 26",
    amount: "999",
    isIncome: false,
  ),
  TransactionModel(
    icon: ImageAssets.notification,
    title: "Book Sale",
    subtitle: "May 25",
    amount: "700",
    isIncome: true,
  ),
  TransactionModel(
    icon: ImageAssets.transactionIcon,
    title: "Coffee",
    subtitle: "May 24",
    amount: "250",
    isIncome: false,
  ),
  TransactionModel(
    icon: ImageAssets.notification,
    title: "Stock Profit",
    subtitle: "May 23",
    amount: "1200",
    isIncome: true,
  ),
];