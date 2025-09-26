import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../core/theme/app_theme.dart';
import '../../domain/entities/transaction.dart';

class RecentTransactions extends StatelessWidget {
  final List<Transaction> transactions;

  const RecentTransactions({
    super.key,
    required this.transactions,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recent Transactions',
              style: AppTheme.headingMedium.copyWith(
                color: AppTheme.darkBlue,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {
                // TODO: Navigate to all transactions
              },
              child: Text(
                'View All',
                style: AppTheme.bodyMedium.copyWith(
                  color: AppTheme.primaryBlue,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
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
          child: transactions.isEmpty
              ? _buildEmptyState()
              : ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: transactions.length,
                  separatorBuilder: (context, index) => Divider(
                    color: AppTheme.lightGray.withOpacity(0.5),
                    height: 1,
                    indent: 16,
                    endIndent: 16,
                  ),
                  itemBuilder: (context, index) {
                    final transaction = transactions[index];
                    return _buildTransactionItem(transaction);
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildTransactionItem(Transaction transaction) {
    final currencyFormat = NumberFormat.currency(symbol: '\$');
    final isExpense = transaction.type == TransactionType.expense;
    final iconData = _getCategoryIcon(transaction.category);
    final categoryColor = _getCategoryColor(transaction.category);

    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          // Category Icon
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: categoryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              iconData,
              color: categoryColor,
              size: 24,
            ),
          ),
          
          const SizedBox(width: 12),
          
          // Transaction Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.title,
                  style: AppTheme.bodyLarge.copyWith(
                    color: AppTheme.darkBlue,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  transaction.category,
                  style: AppTheme.bodySmall.copyWith(
                    color: AppTheme.softGray,
                  ),
                ),
              ],
            ),
          ),
          
          // Amount and Date
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${isExpense ? '-' : '+'}${currencyFormat.format(transaction.amount)}',
                style: AppTheme.bodyLarge.copyWith(
                  color: isExpense ? AppTheme.error : AppTheme.success,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                DateFormat('MMM dd').format(transaction.date),
                style: AppTheme.bodySmall.copyWith(
                  color: AppTheme.softGray,
                ),
              ),
            ],
          ),
        ],
      ),
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
              Icons.receipt_long_outlined,
              size: 40,
              color: AppTheme.softGray,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'No Transactions Yet',
            style: AppTheme.headingSmall.copyWith(
              color: AppTheme.darkBlue,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Start tracking your expenses and income',
            style: AppTheme.bodyMedium.copyWith(
              color: AppTheme.softGray,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
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
      case 'personal care':
        return Icons.spa;
      case 'gifts & donations':
        return Icons.card_giftcard;
      case 'business':
        return Icons.business;
      case 'salary':
        return Icons.work;
      case 'freelance':
        return Icons.computer;
      case 'investment':
        return Icons.trending_up;
      case 'bonus':
        return Icons.star;
      default:
        return Icons.category;
    }
  }

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'food & dining':
        return const Color(0xFFFF6B35);
      case 'shopping':
        return const Color(0xFFEC4899);
      case 'transportation':
        return const Color(0xFF3B82F6);
      case 'entertainment':
        return const Color(0xFF7C3AED);
      case 'bills & utilities':
        return const Color(0xFFEF4444);
      case 'healthcare':
        return const Color(0xFF10B981);
      case 'education':
        return const Color(0xFF14B8A6);
      case 'travel':
        return const Color(0xFF06B6D4);
      case 'personal care':
        return const Color(0xFFBE185D);
      case 'gifts & donations':
        return const Color(0xFFFFD700);
      case 'business':
        return const Color(0xFF667eea);
      case 'salary':
        return const Color(0xFF10B981);
      case 'freelance':
        return const Color(0xFF14B8A6);
      case 'investment':
        return const Color(0xFF7C3AED);
      case 'bonus':
        return const Color(0xFFFFD700);
      default:
        return AppTheme.softGray;
    }
  }
}