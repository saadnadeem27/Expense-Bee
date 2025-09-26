import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_theme.dart';
import '../../../domain/entities/transaction.dart';
import '../../bloc/transaction/transaction_bloc_simple.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String selectedPeriod = 'This Month';
  final List<String> periods = [
    'This Week',
    'This Month',
    'Last 3 Months',
    'This Year'
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: BlocBuilder<TransactionBloc, TransactionState>(
          builder: (context, state) {
            if (state is TransactionLoading) {
              return const _LoadingWidget();
            }

            if (state is TransactionError) {
              return _ErrorWidget(message: state.message);
            }

            if (state is TransactionLoaded) {
              return _AnalyticsContent(
                state: state,
                tabController: _tabController,
                selectedPeriod: selectedPeriod,
                periods: periods,
                onPeriodChanged: (period) {
                  setState(() {
                    selectedPeriod = period;
                  });
                },
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class _AnalyticsContent extends StatelessWidget {
  final TransactionLoaded state;
  final TabController tabController;
  final String selectedPeriod;
  final List<String> periods;
  final Function(String) onPeriodChanged;

  const _AnalyticsContent({
    required this.state,
    required this.tabController,
    required this.selectedPeriod,
    required this.periods,
    required this.onPeriodChanged,
  });

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        _buildAppBar(context),
      ],
      body: Column(
        children: [
          _buildTabBar(),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                _buildOverviewTab(context),
                _buildCategoriesTab(context),
                _buildTrendsTab(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 145,
      floating: false,
      pinned: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        onPressed: () => Navigator.of(context).pop(),
        icon: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: AppTheme.darkBlue.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Icon(
            Icons.arrow_back_ios_new,
            color: AppTheme.darkBlue,
            size: 20,
          ),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF667EEA),
                Color(0xFF764BA2),
              ],
            ),
          ),
          child: Container(
            padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
            child: Row(
              children: [
                const SizedBox(width: 40), // Space for back button
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Analytics',
                        style: AppTheme.headingLarge.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Track your spending patterns',
                        style: AppTheme.bodyMedium.copyWith(
                          color: Colors.white.withOpacity(0.8),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                _buildPeriodSelector(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPeriodSelector() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedPeriod,
          dropdownColor: AppTheme.darkBlue,
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: Colors.white,
            size: 20,
          ),
          style: AppTheme.bodySmall.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
          items: periods.map((period) {
            return DropdownMenuItem(
              value: period,
              child: Text(
                period,
                style: AppTheme.bodySmall.copyWith(
                  color: Colors.white,
                ),
              ),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              onPeriodChanged(value);
            }
          },
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppTheme.darkBlue.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TabBar(
        controller: tabController,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: AppTheme.primaryGradient,
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorPadding: const EdgeInsets.all(4),
        dividerColor: Colors.transparent,
        labelColor: Colors.white,
        unselectedLabelColor: AppTheme.softGray,
        labelStyle: AppTheme.bodyMedium.copyWith(
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: AppTheme.bodyMedium,
        tabs: const [
          Tab(text: 'Overview'),
          Tab(text: 'Categories'),
          Tab(text: 'Trends'),
        ],
      ),
    );
  }

  Widget _buildOverviewTab(BuildContext context) {
    final totalIncome = state.totalIncome;
    final totalExpense = state.totalExpense;
    final balance = state.balance;
    final savingsRate = totalIncome > 0
        ? ((totalIncome - totalExpense) / totalIncome) * 100
        : 0;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Summary Cards
          Row(
            children: [
              Expanded(
                child: _buildSummaryCard(
                  'Total Income',
                  '\$${NumberFormat('#,##0.00').format(totalIncome)}',
                  AppTheme.success,
                  Icons.trending_up,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildSummaryCard(
                  'Total Expense',
                  '\$${NumberFormat('#,##0.00').format(totalExpense)}',
                  AppTheme.error,
                  Icons.trending_down,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: _buildSummaryCard(
                  'Net Balance',
                  '\$${NumberFormat('#,##0.00').format(balance)}',
                  balance >= 0 ? AppTheme.success : AppTheme.error,
                  balance >= 0 ? Icons.account_balance_wallet : Icons.warning,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildSummaryCard(
                  'Savings Rate',
                  '${savingsRate.toStringAsFixed(1)}%',
                  savingsRate > 20
                      ? AppTheme.success
                      : savingsRate > 10
                          ? AppTheme.warning
                          : AppTheme.error,
                  Icons.savings,
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Income vs Expense Chart
          _buildIncomeExpenseChart(),

          const SizedBox(height: 24),

          // Top Categories
          _buildTopCategories(),
        ],
      ),
    );
  }

  Widget _buildCategoriesTab(BuildContext context) {
    final expenseTransactions = state.transactions
        .where((t) => t.type == TransactionType.expense)
        .toList();

    final categoryExpenses = <String, double>{};
    for (final transaction in expenseTransactions) {
      categoryExpenses[transaction.category] =
          (categoryExpenses[transaction.category] ?? 0) + transaction.amount;
    }

    final sortedCategories = categoryExpenses.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Category Pie Chart
          _buildCategoryPieChart(sortedCategories),

          const SizedBox(height: 24),

          // Category List
          Text(
            'Category Breakdown',
            style: AppTheme.headingMedium.copyWith(
              color: AppTheme.darkBlue,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          ...sortedCategories.take(10).map((entry) {
            final percentage = state.totalExpense > 0
                ? (entry.value / state.totalExpense) * 100
                : 0.0;
            return _buildCategoryItem(
              entry.key,
              entry.value,
              percentage,
            );
          }),
        ],
      ),
    );
  }

  Widget _buildTrendsTab(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Spending Trend Chart
          _buildSpendingTrendChart(),

          const SizedBox(height: 24),

          // Weekly Comparison
          _buildWeeklyComparison(),

          const SizedBox(height: 24),

          // Monthly Insights
          _buildMonthlyInsights(),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(
      String title, String value, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppTheme.darkBlue.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 20,
                ),
              ),
              const Spacer(),
              Icon(
                Icons.more_horiz,
                color: AppTheme.softGray,
                size: 20,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: AppTheme.bodySmall.copyWith(
              color: AppTheme.softGray,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: AppTheme.headingSmall.copyWith(
              color: AppTheme.darkBlue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIncomeExpenseChart() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppTheme.darkBlue.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Income vs Expenses',
            style: AppTheme.headingMedium.copyWith(
              color: AppTheme.darkBlue,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 200,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: [state.totalIncome, state.totalExpense]
                        .reduce((a, b) => a > b ? a : b) *
                    1.2,
                barTouchData: BarTouchData(enabled: false),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        switch (value.toInt()) {
                          case 0:
                            return Text('Income', style: AppTheme.bodySmall);
                          case 1:
                            return Text('Expenses', style: AppTheme.bodySmall);
                          default:
                            return const SizedBox.shrink();
                        }
                      },
                    ),
                  ),
                  leftTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                borderData: FlBorderData(show: false),
                barGroups: [
                  BarChartGroupData(
                    x: 0,
                    barRods: [
                      BarChartRodData(
                        toY: state.totalIncome,
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            AppTheme.success.withOpacity(0.7),
                            AppTheme.success,
                          ],
                        ),
                        width: 40,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(6),
                          topRight: Radius.circular(6),
                        ),
                      ),
                    ],
                  ),
                  BarChartGroupData(
                    x: 1,
                    barRods: [
                      BarChartRodData(
                        toY: state.totalExpense,
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            AppTheme.error.withOpacity(0.7),
                            AppTheme.error,
                          ],
                        ),
                        width: 40,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(6),
                          topRight: Radius.circular(6),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopCategories() {
    final expenseTransactions = state.transactions
        .where((t) => t.type == TransactionType.expense)
        .toList();

    final categoryExpenses = <String, double>{};
    for (final transaction in expenseTransactions) {
      categoryExpenses[transaction.category] =
          (categoryExpenses[transaction.category] ?? 0) + transaction.amount;
    }

    final sortedCategories = categoryExpenses.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppTheme.darkBlue.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Top Spending Categories',
            style: AppTheme.headingMedium.copyWith(
              color: AppTheme.darkBlue,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ...sortedCategories.take(5).map((entry) {
            final percentage = state.totalExpense > 0
                ? (entry.value / state.totalExpense) * 100
                : 0;
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: _getCategoryColor(entry.key),
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          entry.key,
                          style: AppTheme.bodyMedium.copyWith(
                            color: AppTheme.darkBlue,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '${percentage.toStringAsFixed(1)}% of expenses',
                          style: AppTheme.bodySmall.copyWith(
                            color: AppTheme.softGray,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '\$${NumberFormat('#,##0.00').format(entry.value)}',
                    style: AppTheme.bodyMedium.copyWith(
                      color: AppTheme.darkBlue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildCategoryPieChart(List<MapEntry<String, double>> categories) {
    if (categories.isEmpty || state.totalExpense == 0) {
      return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppTheme.darkBlue.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              'Expense Distribution',
              style: AppTheme.headingMedium.copyWith(
                color: AppTheme.darkBlue,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),
            Text(
              'No expense data available',
              style: AppTheme.bodyMedium.copyWith(
                color: AppTheme.softGray,
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppTheme.darkBlue.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Expense Distribution',
            style: AppTheme.headingMedium.copyWith(
              color: AppTheme.darkBlue,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 200,
            child: PieChart(
              PieChartData(
                sectionsSpace: 2,
                centerSpaceRadius: 50,
                sections: categories.take(6).map((entry) {
                  final percentage = (entry.value / state.totalExpense) * 100;
                  return PieChartSectionData(
                    color: _getCategoryColor(entry.key),
                    value: percentage,
                    title: '${percentage.toStringAsFixed(1)}%',
                    radius: 60,
                    titleStyle: AppTheme.bodySmall.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(String category, double amount, double percentage) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppTheme.darkBlue.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: _getCategoryColor(category).withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              _getCategoryIcon(category),
              color: _getCategoryColor(category),
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category,
                  style: AppTheme.bodyMedium.copyWith(
                    color: AppTheme.darkBlue,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '${percentage.toStringAsFixed(1)}% of total',
                  style: AppTheme.bodySmall.copyWith(
                    color: AppTheme.softGray,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '\$${NumberFormat('#,##0.00').format(amount)}',
            style: AppTheme.bodyMedium.copyWith(
              color: AppTheme.darkBlue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpendingTrendChart() {
    // Group transactions by week
    final weeklyExpenses = <DateTime, double>{};
    final now = DateTime.now();

    for (int i = 6; i >= 0; i--) {
      final weekStart = now.subtract(Duration(days: now.weekday - 1 + (i * 7)));
      weeklyExpenses[weekStart] = 0;
    }

    for (final transaction in state.transactions) {
      if (transaction.type == TransactionType.expense) {
        final weekStart = transaction.date.subtract(
          Duration(days: transaction.date.weekday - 1),
        );

        for (final week in weeklyExpenses.keys) {
          if (weekStart.isAtSameMomentAs(week)) {
            weeklyExpenses[week] = weeklyExpenses[week]! + transaction.amount;
            break;
          }
        }
      }
    }

    final sortedWeeks = weeklyExpenses.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key));

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppTheme.darkBlue.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Weekly Spending Trend',
            style: AppTheme.headingMedium.copyWith(
              color: AppTheme.darkBlue,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 200,
            child: LineChart(
              LineChartData(
                gridData: const FlGridData(show: false),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        if (value.toInt() >= 0 &&
                            value.toInt() < sortedWeeks.length) {
                          final date = sortedWeeks[value.toInt()].key;
                          return Text(
                            DateFormat('M/d').format(date),
                            style: AppTheme.bodySmall.copyWith(
                              color: AppTheme.softGray,
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                  leftTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: sortedWeeks.asMap().entries.map((entry) {
                      return FlSpot(
                        entry.key.toDouble(),
                        entry.value.value,
                      );
                    }).toList(),
                    isCurved: true,
                    gradient: LinearGradient(
                      colors: [
                        AppTheme.primaryBlue.withOpacity(0.7),
                        AppTheme.primaryBlue,
                      ],
                    ),
                    barWidth: 3,
                    dotData: FlDotData(
                      show: true,
                      getDotPainter: (spot, percent, barData, index) {
                        return FlDotCirclePainter(
                          radius: 4,
                          color: AppTheme.primaryBlue,
                          strokeColor: Colors.white,
                          strokeWidth: 2,
                        );
                      },
                    ),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          AppTheme.primaryBlue.withOpacity(0.2),
                          AppTheme.primaryBlue.withOpacity(0.05),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeeklyComparison() {
    final thisWeek = _getWeeklyExpense(0);
    final lastWeek = _getWeeklyExpense(1);
    final change =
        lastWeek > 0 ? ((thisWeek - lastWeek) / lastWeek) * 100 : 0.0;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppTheme.darkBlue.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Weekly Comparison',
            style: AppTheme.headingMedium.copyWith(
              color: AppTheme.darkBlue,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildComparisonItem(
                  'This Week',
                  '\$${NumberFormat('#,##0.00').format(thisWeek)}',
                  change,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildComparisonItem(
                  'Last Week',
                  '\$${NumberFormat('#,##0.00').format(lastWeek)}',
                  null,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildComparisonItem(String title, String amount, double? change) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTheme.bodySmall.copyWith(
            color: AppTheme.softGray,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          amount,
          style: AppTheme.headingSmall.copyWith(
            color: AppTheme.darkBlue,
            fontWeight: FontWeight.bold,
          ),
        ),
        if (change != null) ...[
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(
                change >= 0 ? Icons.trending_up : Icons.trending_down,
                size: 16,
                color: change >= 0 ? AppTheme.error : AppTheme.success,
              ),
              const SizedBox(width: 4),
              Text(
                '${change.abs().toStringAsFixed(1)}%',
                style: AppTheme.bodySmall.copyWith(
                  color: change >= 0 ? AppTheme.error : AppTheme.success,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  Widget _buildMonthlyInsights() {
    final monthlyAverage = _getMonthlyAverageExpense();
    final currentMonth = _getCurrentMonthExpense();
    final projectedMonthly = _getProjectedMonthlyExpense();

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppTheme.darkBlue.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Monthly Insights',
            style: AppTheme.headingMedium.copyWith(
              color: AppTheme.darkBlue,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildInsightItem(
            'Average Monthly Spending',
            '\$${NumberFormat('#,##0.00').format(monthlyAverage)}',
            Icons.timeline,
            AppTheme.primaryBlue,
          ),
          const SizedBox(height: 12),
          _buildInsightItem(
            'This Month So Far',
            '\$${NumberFormat('#,##0.00').format(currentMonth)}',
            Icons.calendar_today,
            AppTheme.success,
          ),
          const SizedBox(height: 12),
          _buildInsightItem(
            'Projected Monthly Total',
            '\$${NumberFormat('#,##0.00').format(projectedMonthly)}',
            Icons.trending_up,
            projectedMonthly > monthlyAverage
                ? AppTheme.error
                : AppTheme.success,
          ),
        ],
      ),
    );
  }

  Widget _buildInsightItem(
      String title, String value, IconData icon, Color color) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: color,
            size: 16,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: AppTheme.bodyMedium.copyWith(
              color: AppTheme.darkBlue,
            ),
          ),
        ),
        Text(
          value,
          style: AppTheme.bodyMedium.copyWith(
            color: AppTheme.darkBlue,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  double _getWeeklyExpense(int weeksAgo) {
    final now = DateTime.now();
    final weekStart =
        now.subtract(Duration(days: now.weekday - 1 + (weeksAgo * 7)));
    final weekEnd = weekStart.add(const Duration(days: 6));

    return state.transactions
        .where((t) =>
            t.type == TransactionType.expense &&
            t.date.isAfter(weekStart.subtract(const Duration(days: 1))) &&
            t.date.isBefore(weekEnd.add(const Duration(days: 1))))
        .fold(0.0, (sum, t) => sum + t.amount);
  }

  double _getMonthlyAverageExpense() {
    final monthlyExpenses = <int, double>{};

    for (final transaction in state.transactions) {
      if (transaction.type == TransactionType.expense) {
        final monthKey = transaction.date.year * 12 + transaction.date.month;
        monthlyExpenses[monthKey] =
            (monthlyExpenses[monthKey] ?? 0) + transaction.amount;
      }
    }

    if (monthlyExpenses.isEmpty) return 0;

    final total =
        monthlyExpenses.values.fold(0.0, (sum, amount) => sum + amount);
    return total / monthlyExpenses.length;
  }

  double _getCurrentMonthExpense() {
    final now = DateTime.now();
    final monthStart = DateTime(now.year, now.month, 1);

    return state.transactions
        .where((t) =>
            t.type == TransactionType.expense &&
            t.date.isAfter(monthStart.subtract(const Duration(days: 1))))
        .fold(0.0, (sum, t) => sum + t.amount);
  }

  double _getProjectedMonthlyExpense() {
    final now = DateTime.now();
    final currentMonth = _getCurrentMonthExpense();
    final daysInMonth = DateTime(now.year, now.month + 1, 0).day;
    final daysPassed = now.day;

    if (daysPassed == 0) return 0;

    return (currentMonth / daysPassed) * daysInMonth;
  }

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'food & dining':
        return const Color(0xFFFF6B6B);
      case 'shopping':
        return const Color(0xFF4ECDC4);
      case 'transportation':
        return const Color(0xFF45B7D1);
      case 'entertainment':
        return const Color(0xFF96CEB4);
      case 'bills & utilities':
        return const Color(0xFFFFA07A);
      case 'healthcare':
        return const Color(0xFFDDA0DD);
      case 'education':
        return const Color(0xFF98D8C8);
      case 'travel':
        return const Color(0xFFFDCB6E);
      case 'business':
        return const Color(0xFF6C5CE7);
      case 'investments':
        return const Color(0xFFA29BFE);
      default:
        return AppTheme.primaryBlue;
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'food & dining':
        return Icons.restaurant;
      case 'shopping':
        return Icons.shopping_bag;
      case 'transportation':
        return Icons.directions_car;
      case 'entertainment':
        return Icons.movie;
      case 'bills & utilities':
        return Icons.receipt;
      case 'healthcare':
        return Icons.local_hospital;
      case 'education':
        return Icons.school;
      case 'travel':
        return Icons.flight;
      case 'business':
        return Icons.business;
      case 'investments':
        return Icons.trending_up;
      default:
        return Icons.category;
    }
  }
}

class _LoadingWidget extends StatelessWidget {
  const _LoadingWidget();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppTheme.darkBlue.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primaryBlue),
            ),
            const SizedBox(height: 16),
            Text(
              'Loading analytics...',
              style: AppTheme.bodyMedium.copyWith(
                color: AppTheme.softGray,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ErrorWidget extends StatelessWidget {
  final String message;

  const _ErrorWidget({required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppTheme.darkBlue.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.error.withOpacity(0.1),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Icon(
                Icons.error_outline,
                color: AppTheme.error,
                size: 40,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Oops! Something went wrong',
              style: AppTheme.headingSmall.copyWith(
                color: AppTheme.darkBlue,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: AppTheme.bodyMedium.copyWith(
                color: AppTheme.softGray,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryBlue,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}
