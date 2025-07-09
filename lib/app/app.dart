import '../data/local/transaction_database_service.dart';
import '../data/repository/transaction_repository_impl.dart';
import '../features/main/main_viewmodel.dart';
import 'app_preferences.dart';
import 'di.dart';
import '../resources/routes_manager.dart';
import '../resources/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

class MyApp extends StatefulWidget {
  MyApp._internal(); // name constructor

  static final MyApp _instance =
  MyApp._internal(); // singleton or single instance

  factory MyApp() => _instance; // factory

  int appState = 0;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppsPreferences _appsPreferences = instance<AppsPreferences>();
  final dbService = TransactionDatabaseService(); // Create instance

  @override
  void didChangeDependencies() {
    _appsPreferences.getLocale().then((locale) => context.setLocale(locale));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MainViewModel>(
          create: (_) {
            final viewModel = MainViewModel(
              repository: TransactionRepositoryImpl(dbService: dbService),
            );
            Future.microtask(() => viewModel.init());
            return viewModel;
          },
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        onGenerateRoute: RouteGenerator.getRoute,
        initialRoute: Routes.onBpardingRoute,
        theme: getApplicationTheme(),
      ),
    );
  }
}