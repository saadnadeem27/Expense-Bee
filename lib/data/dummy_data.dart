import 'dart:math';
import 'package:uuid/uuid.dart';
import '../domain/entities/transaction.dart';
import '../domain/entities/account.dart';
import '../domain/entities/budget.dart';
import '../domain/entities/goal.dart';
import '../core/constants/app_constants.dart';

class DummyDataGenerator {
  static const Uuid _uuid = Uuid();
  static final Random _random = Random();

  // Generate dummy accounts
  static List<Account> generateAccounts() {
    final accounts = <Account>[];
    final accountData = [
      {'name': 'Main Bank Account', 'type': AccountType.bankAccount, 'balance': 15000.0, 'color': 0xFF667eea},
      {'name': 'Cash Wallet', 'type': AccountType.cash, 'balance': 500.0, 'color': 0xFF10B981},
      {'name': 'Credit Card', 'type': AccountType.creditCard, 'balance': -2500.0, 'color': 0xFFEF4444},
      {'name': 'PayPal', 'type': AccountType.digitalWallet, 'balance': 1200.0, 'color': 0xFF3B82F6},
      {'name': 'Savings Account', 'type': AccountType.bankAccount, 'balance': 25000.0, 'color': 0xFF14B8A6},
    ];

    for (final data in accountData) {
      accounts.add(Account(
        id: _uuid.v4(),
        name: data['name'] as String,
        type: data['type'] as AccountType,
        balance: data['balance'] as double,
        currency: 'USD',
        color: data['color'] as int,
        createdAt: DateTime.now().subtract(Duration(days: _random.nextInt(365))),
        updatedAt: DateTime.now(),
      ));
    }

    return accounts;
  }

  // Generate dummy transactions
  static List<Transaction> generateTransactions(List<Account> accounts) {
    final transactions = <Transaction>[];
    final now = DateTime.now();

    // Expense transactions
    final expenseData = [
      {'title': 'Grocery Shopping', 'category': 'Food & Dining', 'amount': 85.50},
      {'title': 'Gas Station', 'category': 'Transportation', 'amount': 45.00},
      {'title': 'Netflix Subscription', 'category': 'Entertainment', 'amount': 15.99},
      {'title': 'Coffee Shop', 'category': 'Food & Dining', 'amount': 12.50},
      {'title': 'Uber Ride', 'category': 'Transportation', 'amount': 22.30},
      {'title': 'Amazon Purchase', 'category': 'Shopping', 'amount': 156.78},
      {'title': 'Electricity Bill', 'category': 'Bills & Utilities', 'amount': 120.00},
      {'title': 'Internet Bill', 'category': 'Bills & Utilities', 'amount': 60.00},
      {'title': 'Pharmacy', 'category': 'Healthcare', 'amount': 35.25},
      {'title': 'Movie Tickets', 'category': 'Entertainment', 'amount': 28.00},
      {'title': 'Restaurant Dinner', 'category': 'Food & Dining', 'amount': 95.75},
      {'title': 'Gym Membership', 'category': 'Personal Care', 'amount': 50.00},
      {'title': 'Book Store', 'category': 'Education', 'amount': 24.99},
      {'title': 'Hair Salon', 'category': 'Personal Care', 'amount': 80.00},
      {'title': 'Phone Bill', 'category': 'Bills & Utilities', 'amount': 55.00},
    ];

    // Income transactions
    final incomeData = [
      {'title': 'Monthly Salary', 'category': 'Salary', 'amount': 4500.00},
      {'title': 'Freelance Project', 'category': 'Freelance', 'amount': 850.00},
      {'title': 'Investment Dividend', 'category': 'Investment', 'amount': 125.50},
      {'title': 'Bonus Payment', 'category': 'Bonus', 'amount': 1000.00},
      {'title': 'Side Business', 'category': 'Business', 'amount': 300.00},
    ];

    // Generate expenses for the last 30 days
    for (int i = 0; i < 50; i++) {
      final expenseItem = expenseData[_random.nextInt(expenseData.length)];
      final account = accounts[_random.nextInt(accounts.length)];
      
      transactions.add(Transaction(
        id: _uuid.v4(),
        title: expenseItem['title'] as String,
        description: 'Auto-generated expense transaction',
        amount: (expenseItem['amount'] as double) + (_random.nextDouble() * 20 - 10),
        category: expenseItem['category'] as String,
        type: TransactionType.expense,
        date: now.subtract(Duration(days: _random.nextInt(30))),
        accountId: account.id,
      ));
    }

    // Generate incomes
    for (int i = 0; i < 8; i++) {
      final incomeItem = incomeData[_random.nextInt(incomeData.length)];
      final account = accounts[_random.nextInt(accounts.length)];
      
      transactions.add(Transaction(
        id: _uuid.v4(),
        title: incomeItem['title'] as String,
        description: 'Auto-generated income transaction',
        amount: incomeItem['amount'] as double,
        category: incomeItem['category'] as String,
        type: TransactionType.income,
        date: now.subtract(Duration(days: _random.nextInt(30))),
        accountId: account.id,
      ));
    }

    // Sort by date (newest first)
    transactions.sort((a, b) => b.date.compareTo(a.date));
    return transactions;
  }

  // Generate dummy budgets
  static List<Budget> generateBudgets() {
    final budgets = <Budget>[];
    final now = DateTime.now();
    final startOfMonth = DateTime(now.year, now.month, 1);
    final endOfMonth = DateTime(now.year, now.month + 1, 0);

    final budgetData = [
      {'name': 'Food Budget', 'category': 'Food & Dining', 'amount': 500.0, 'spent': 325.50, 'color': 0xFF10B981},
      {'name': 'Transportation', 'category': 'Transportation', 'amount': 200.0, 'spent': 145.30, 'color': 0xFF3B82F6},
      {'name': 'Entertainment', 'category': 'Entertainment', 'amount': 150.0, 'spent': 89.99, 'color': 0xFFEC4899},
      {'name': 'Shopping', 'category': 'Shopping', 'amount': 300.0, 'spent': 456.78, 'color': 0xFFEF4444},
      {'name': 'Bills', 'category': 'Bills & Utilities', 'amount': 400.0, 'spent': 235.00, 'color': 0xFF14B8A6},
    ];

    for (final data in budgetData) {
      budgets.add(Budget(
        id: _uuid.v4(),
        name: data['name'] as String,
        category: data['category'] as String,
        amount: data['amount'] as double,
        spent: data['spent'] as double,
        period: BudgetPeriod.monthly,
        startDate: startOfMonth,
        endDate: endOfMonth,
        color: data['color'] as int,
      ));
    }

    return budgets;
  }

  // Generate dummy goals
  static List<Goal> generateGoals() {
    final goals = <Goal>[];
    final now = DateTime.now();

    final goalData = [
      {
        'name': 'Emergency Fund',
        'description': 'Build a 6-month emergency fund for financial security',
        'target': 10000.0,
        'current': 6500.0,
        'category': GoalCategory.emergency,
        'targetDate': now.add(const Duration(days: 180)),
        'color': 0xFF10B981,
      },
      {
        'name': 'Vacation to Japan',
        'description': 'Save for a 2-week trip to Japan including flights and accommodation',
        'target': 5000.0,
        'current': 2300.0,
        'category': GoalCategory.vacation,
        'targetDate': now.add(const Duration(days: 365)),
        'color': 0xFFEC4899,
      },
      {
        'name': 'New Laptop',
        'description': 'MacBook Pro for work and personal projects',
        'target': 2500.0,
        'current': 1850.0,
        'category': GoalCategory.gadget,
        'targetDate': now.add(const Duration(days: 90)),
        'color': 0xFF3B82F6,
      },
      {
        'name': 'Car Down Payment',
        'description': 'Save for a down payment on a new car',
        'target': 8000.0,
        'current': 3200.0,
        'category': GoalCategory.car,
        'targetDate': now.add(const Duration(days: 270)),
        'color': 0xFF14B8A6,
      },
    ];

    for (final data in goalData) {
      goals.add(Goal(
        id: _uuid.v4(),
        name: data['name'] as String,
        description: data['description'] as String,
        targetAmount: data['target'] as double,
        currentAmount: data['current'] as double,
        category: data['category'] as GoalCategory,
        targetDate: data['targetDate'] as DateTime,
        createdAt: now.subtract(Duration(days: _random.nextInt(180))),
        color: data['color'] as int,
      ));
    }

    return goals;
  }

  // Generate chart data for analytics
  static Map<String, dynamic> generateAnalyticsData() {
    final now = DateTime.now();
    final monthlyData = <String, double>{};
    final categoryData = <String, double>{};
    final dailyData = <String, double>{};

    // Generate last 12 months data
    for (int i = 11; i >= 0; i--) {
      final month = DateTime(now.year, now.month - i, 1);
      final monthKey = '${month.month.toString().padLeft(2, '0')}/${month.year}';
      monthlyData[monthKey] = 1000 + (_random.nextDouble() * 2000);
    }

    // Generate category spending data
    for (final category in AppConstants.expenseCategories) {
      categoryData[category] = _random.nextDouble() * 500 + 100;
    }

    // Generate last 30 days data
    for (int i = 29; i >= 0; i--) {
      final date = now.subtract(Duration(days: i));
      final dateKey = '${date.day}/${date.month}';
      dailyData[dateKey] = _random.nextDouble() * 200 + 50;
    }

    return {
      'monthly': monthlyData,
      'category': categoryData,
      'daily': dailyData,
      'totalIncome': 5675.50,
      'totalExpense': 3245.67,
      'netIncome': 2429.83,
    };
  }
}