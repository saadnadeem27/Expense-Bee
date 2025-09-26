class AppConstants {
  // App Information
  static const String appName = 'Expense Bee';
  static const String appVersion = '1.0.0';
  static const String appDescription =
      'Smart expense tracking with AI insights';

  // API & Database
  static const String databaseName = 'expense_bee.db';
  static const int databaseVersion = 1;

  // Shared Preferences Keys
  static const String keyThemeMode = 'theme_mode';
  static const String keyFirstLaunch = 'first_launch';
  static const String keyBiometricEnabled = 'biometric_enabled';
  static const String keyNotificationsEnabled = 'notifications_enabled';
  static const String keyDefaultCurrency = 'default_currency';
  static const String keyUserId = 'user_id';

  // Animation Durations
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 300);
  static const Duration longAnimation = Duration(milliseconds: 500);

  // UI Constants
  static const double borderRadius = 12.0;
  static const double cardElevation = 8.0;
  static const double buttonHeight = 56.0;
  static const double iconSize = 24.0;
  static const double avatarRadius = 20.0;

  // Spacing
  static const double paddingXS = 4.0;
  static const double paddingS = 8.0;
  static const double paddingM = 16.0;
  static const double paddingL = 24.0;
  static const double paddingXL = 32.0;

  // Categories
  static const List<String> expenseCategories = [
    'Food & Dining',
    'Shopping',
    'Transportation',
    'Entertainment',
    'Bills & Utilities',
    'Healthcare',
    'Education',
    'Travel',
    'Personal Care',
    'Gifts & Donations',
    'Business',
    'Others',
  ];

  static const List<String> incomeCategories = [
    'Salary',
    'Freelance',
    'Business',
    'Investment',
    'Rental',
    'Bonus',
    'Gift',
    'Others',
  ];

  // Account Types
  static const List<String> accountTypes = [
    'Cash',
    'Bank Account',
    'Credit Card',
    'Debit Card',
    'Digital Wallet',
    'Investment',
  ];

  // Currencies
  static const List<Map<String, String>> currencies = [
    {'code': 'USD', 'name': 'US Dollar', 'symbol': '\$'},
    {'code': 'EUR', 'name': 'Euro', 'symbol': '€'},
    {'code': 'GBP', 'name': 'British Pound', 'symbol': '£'},
    {'code': 'JPY', 'name': 'Japanese Yen', 'symbol': '¥'},
    {'code': 'INR', 'name': 'Indian Rupee', 'symbol': '₹'},
    {'code': 'CAD', 'name': 'Canadian Dollar', 'symbol': 'C\$'},
    {'code': 'AUD', 'name': 'Australian Dollar', 'symbol': 'A\$'},
    {'code': 'CHF', 'name': 'Swiss Franc', 'symbol': 'CHF'},
    {'code': 'CNY', 'name': 'Chinese Yuan', 'symbol': '¥'},
  ];

  // Recurring Periods
  static const List<String> recurringPeriods = [
    'Daily',
    'Weekly',
    'Monthly',
    'Quarterly',
    'Yearly',
  ];

  // Chart Colors
  static const List<int> chartColors = [
    0xFF667eea,
    0xFF764ba2,
    0xFFFFD700,
    0xFFFFA500,
    0xFF4F46E5,
    0xFF7C3AED,
    0xFF06B6D4,
    0xFF14B8A6,
    0xFFEC4899,
    0xFFBE185D,
    0xFF10B981,
    0xFFEF4444,
  ];
}
