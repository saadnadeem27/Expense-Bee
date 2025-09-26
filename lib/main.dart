import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'core/theme/app_theme.dart';
import 'presentation/bloc/transaction/transaction_bloc_simple.dart';
import 'presentation/screens/onboarding/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Hive
  await Hive.initFlutter();
  
  // Register Hive adapters (will be generated)
  // Hive.registerAdapter(TransactionAdapter());
  // Hive.registerAdapter(TransactionTypeAdapter());
  // Hive.registerAdapter(RecurringPeriodAdapter());
  // Hive.registerAdapter(AccountAdapter());
  // Hive.registerAdapter(AccountTypeAdapter());
  // Hive.registerAdapter(BudgetAdapter());
  // Hive.registerAdapter(BudgetPeriodAdapter());
  // Hive.registerAdapter(GoalAdapter());
  // Hive.registerAdapter(GoalCategoryAdapter());

  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  runApp(const ExpenseBeeApp());
}

class ExpenseBeeApp extends StatelessWidget {
  const ExpenseBeeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TransactionBloc()..add(const LoadTransactions()),
        ),
      ],
      child: MaterialApp(
        title: 'Expense Bee',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        home: const SplashScreen(),
      ),
    );
  }
}