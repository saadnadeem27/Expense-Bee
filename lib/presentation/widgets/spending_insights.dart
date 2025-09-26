import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../core/theme/app_theme.dart';
import '../../domain/entities/transaction.dart';

class SpendingInsights extends StatelessWidget {
  final List<Transaction> transactions;

  const SpendingInsights({
    super.key,
    required this.transactions,
  });

  @override
  Widget build(BuildContext context) {
    final categoryData = _getCategoryData();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Spending Insights',
          style: AppTheme.headingMedium.copyWith(
            color: AppTheme.darkBlue,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Container(
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
          child: categoryData.isEmpty
              ? _buildEmptyState()
              : Column(
                  children: [
                    // Pie Chart
                    SizedBox(
                      height: 200,
                      child: PieChart(
                        PieChartData(
                          sections: _buildPieSections(categoryData),
                          centerSpaceRadius: 40,
                          sectionsSpace: 2,
                          startDegreeOffset: -90,
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // Legend
                    _buildLegend(categoryData),
                  ],
                ),
        ),
      ],
    );
  }

  Map<String, double> _getCategoryData() {
    final categoryTotals = <String, double>{};
    
    for (final transaction in transactions) {
      if (transaction.type == TransactionType.expense) {
        categoryTotals[transaction.category] =
            (categoryTotals[transaction.category] ?? 0) + transaction.amount;
      }
    }
    
    return categoryTotals;
  }

  List<PieChartSectionData> _buildPieSections(Map<String, double> categoryData) {
    final total = categoryData.values.fold(0.0, (sum, amount) => sum + amount);
    final colors = [
      AppTheme.primaryBlue,
      AppTheme.primaryGold,
      AppTheme.accentOrange,
      AppTheme.accentTeal,
      AppTheme.accentPink,
      AppTheme.primaryPurple,
      const Color(0xFF10B981),
      const Color(0xFF3B82F6),
      const Color(0xFFEF4444),
      const Color(0xFFF59E0B),
    ];
    
    int colorIndex = 0;
    return categoryData.entries.map((entry) {
      final percentage = (entry.value / total) * 100;
      final color = colors[colorIndex % colors.length];
      colorIndex++;
      
      return PieChartSectionData(
        color: color,
        value: entry.value,
        title: '${percentage.toStringAsFixed(1)}%',
        radius: 60,
        titleStyle: AppTheme.bodySmall.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      );
    }).toList();
  }

  Widget _buildLegend(Map<String, double> categoryData) {
    final total = categoryData.values.fold(0.0, (sum, amount) => sum + amount);
    final colors = [
      AppTheme.primaryBlue,
      AppTheme.primaryGold,
      AppTheme.accentOrange,
      AppTheme.accentTeal,
      AppTheme.accentPink,
      AppTheme.primaryPurple,
      const Color(0xFF10B981),
      const Color(0xFF3B82F6),
      const Color(0xFFEF4444),
      const Color(0xFFF59E0B),
    ];
    
    int colorIndex = 0;
    return Column(
      children: categoryData.entries.map((entry) {
        final percentage = (entry.value / total) * 100;
        final color = colors[colorIndex % colors.length];
        colorIndex++;
        
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  entry.key,
                  style: AppTheme.bodyMedium.copyWith(
                    color: AppTheme.darkBlue,
                  ),
                ),
              ),
              Text(
                '\$${entry.value.toStringAsFixed(2)}',
                style: AppTheme.bodyMedium.copyWith(
                  color: AppTheme.darkBlue,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AppTheme.lightGray.withOpacity(0.5),
              borderRadius: BorderRadius.circular(40),
            ),
            child: Icon(
              Icons.pie_chart_outlined,
              size: 40,
              color: AppTheme.softGray,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'No Spending Data',
            style: AppTheme.headingSmall.copyWith(
              color: AppTheme.darkBlue,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Add some expenses to see your spending insights',
            style: AppTheme.bodyMedium.copyWith(
              color: AppTheme.softGray,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}