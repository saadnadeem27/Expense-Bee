import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../core/constants/app_constants.dart';
import '../../domain/entities/transaction.dart';

class CategorySelector extends StatelessWidget {
  final TransactionType transactionType;
  final String? selectedCategory;
  final Function(String) onCategorySelected;

  const CategorySelector({
    super.key,
    required this.transactionType,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    final categories = transactionType == TransactionType.income
        ? AppConstants.incomeCategories
        : AppConstants.expenseCategories;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.lightGray),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.category, color: AppTheme.softGray),
              const SizedBox(width: 16),
              Text(
                'Category',
                style: AppTheme.bodyLarge.copyWith(
                  color: AppTheme.darkBlue,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3.5,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              final isSelected = selectedCategory == category;
              final iconData = _getCategoryIcon(category);
              final color = _getCategoryColor(category);

              return GestureDetector(
                onTap: () => onCategorySelected(category),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isSelected ? color.withOpacity(0.1) : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected ? color : AppTheme.lightGray,
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          iconData,
                          color: color,
                          size: 18,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          category,
                          style: AppTheme.bodySmall.copyWith(
                            color: isSelected ? color : AppTheme.darkBlue,
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
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
      case 'rental':
        return Icons.home;
      case 'gift':
        return Icons.redeem;
      case 'others':
      case 'other':
        return Icons.more_horiz;
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
      case 'rental':
        return const Color(0xFF06B6D4);
      case 'gift':
        return const Color(0xFFEC4899);
      case 'others':
      case 'other':
        return AppTheme.softGray;
      default:
        return AppTheme.softGray;
    }
  }
}