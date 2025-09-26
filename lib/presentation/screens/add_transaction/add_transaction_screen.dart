import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/constants/app_constants.dart';
import '../../../domain/entities/transaction.dart';
import '../../bloc/transaction/transaction_bloc_simple.dart';
import '../../widgets/category_selector.dart';

class AddTransactionScreen extends StatefulWidget {
  final Transaction? transaction; // For editing existing transaction

  const AddTransactionScreen({
    super.key,
    this.transaction,
  });

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _amountController = TextEditingController();

  TransactionType _transactionType = TransactionType.expense;
  String? _selectedCategory;
  DateTime _selectedDate = DateTime.now();
  bool _isRecurring = false;
  RecurringPeriod _recurringPeriod = RecurringPeriod.monthly;
  DateTime? _recurringEndDate;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_onTabChanged);
    
    // Initialize with existing transaction data if editing
    if (widget.transaction != null) {
      _initializeWithExistingTransaction();
    } else {
      // Set default category based on transaction type
      _setDefaultCategory();
    }
  }

  void _initializeWithExistingTransaction() {
    final transaction = widget.transaction!;
    _titleController.text = transaction.title;
    _descriptionController.text = transaction.description;
    _amountController.text = transaction.amount.toString();
    _transactionType = transaction.type;
    _selectedCategory = transaction.category;
    _selectedDate = transaction.date;
    _isRecurring = transaction.isRecurring;
    _recurringPeriod = transaction.recurringPeriod ?? RecurringPeriod.monthly;
    _recurringEndDate = transaction.recurringEndDate;
    
    // Set tab based on transaction type
    _tabController.index = _transactionType == TransactionType.income ? 1 : 0;
  }

  void _onTabChanged() {
    setState(() {
      _transactionType = _tabController.index == 0
          ? TransactionType.expense
          : TransactionType.income;
      _setDefaultCategory();
    });
  }

  void _setDefaultCategory() {
    final categories = _transactionType == TransactionType.income
        ? AppConstants.incomeCategories
        : AppConstants.expenseCategories;
    
    if (_selectedCategory == null || 
        !categories.contains(_selectedCategory)) {
      _selectedCategory = categories.first;
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightGray,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF8FAFC),
              Color(0xFFFFFFFF),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildAppBar(),
              _buildTabBar(),
              Expanded(
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        _buildAmountField(),
                        const SizedBox(height: 24),
                        _buildTitleField(),
                        const SizedBox(height: 16),
                        _buildDescriptionField(),
                        const SizedBox(height: 24),
                        _buildCategorySelector(),
                        const SizedBox(height: 24),
                        _buildDateSelector(),
                        const SizedBox(height: 24),
                        _buildRecurringOptions(),
                        const SizedBox(height: 32),
                        _buildSaveButton(),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.darkBlue.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(
                Icons.arrow_back,
                color: AppTheme.darkBlue,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              widget.transaction != null ? 'Edit Transaction' : 'Add Transaction',
              style: AppTheme.headingLarge.copyWith(
                color: AppTheme.darkBlue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          if (widget.transaction != null)
            GestureDetector(
              onTap: _deleteTransaction,
              child: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppTheme.error.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.delete_outline,
                  color: AppTheme.error,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppTheme.darkBlue.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: _transactionType == TransactionType.expense
              ? AppTheme.pinkGradient
              : AppTheme.tealGradient,
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorPadding: const EdgeInsets.all(4),
        labelColor: Colors.white,
        unselectedLabelColor: AppTheme.softGray,
        labelStyle: AppTheme.bodyMedium.copyWith(
          fontWeight: FontWeight.w600,
        ),
        tabs: const [
          Tab(text: 'Expense'),
          Tab(text: 'Income'),
        ],
      ),
    );
  }

  Widget _buildAmountField() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: _transactionType == TransactionType.expense
            ? AppTheme.pinkGradient
            : AppTheme.tealGradient,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: (_transactionType == TransactionType.expense
                    ? AppTheme.accentPink
                    : AppTheme.accentTeal)
                .withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            _transactionType == TransactionType.expense
                ? 'How much did you spend?'
                : 'How much did you earn?',
            style: AppTheme.bodyLarge.copyWith(
              color: Colors.white.withOpacity(0.8),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '\$',
                style: AppTheme.headingLarge.copyWith(
                  color: Colors.white,
                  fontSize: 32,
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: TextFormField(
                  controller: _amountController,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r'^\d+\.?\d{0,2}'),
                    ),
                  ],
                  style: AppTheme.headingLarge.copyWith(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: InputDecoration(
                    hintText: '0.00',
                    hintStyle: AppTheme.headingLarge.copyWith(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 32,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ),
                  textAlign: TextAlign.center,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an amount';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter a valid amount';
                    }
                    if (double.parse(value) <= 0) {
                      return 'Amount must be greater than 0';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTitleField() {
    return TextFormField(
      controller: _titleController,
      decoration: InputDecoration(
        labelText: 'Title',
        hintText: 'Enter transaction title',
        prefixIcon: const Icon(Icons.title),
        filled: true,
        fillColor: Colors.white,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a title';
        }
        return null;
      },
    );
  }

  Widget _buildDescriptionField() {
    return TextFormField(
      controller: _descriptionController,
      decoration: const InputDecoration(
        labelText: 'Description (Optional)',
        hintText: 'Add a note about this transaction',
        prefixIcon: Icon(Icons.note),
        filled: true,
        fillColor: Colors.white,
      ),
      maxLines: 3,
    );
  }

  Widget _buildCategorySelector() {
    return CategorySelector(
      transactionType: _transactionType,
      selectedCategory: _selectedCategory,
      onCategorySelected: (category) {
        setState(() {
          _selectedCategory = category;
        });
      },
    );
  }

  Widget _buildDateSelector() {
    return GestureDetector(
      onTap: _selectDate,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppTheme.lightGray),
        ),
        child: Row(
          children: [
            const Icon(Icons.calendar_today, color: AppTheme.softGray),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Date',
                    style: AppTheme.bodySmall.copyWith(
                      color: AppTheme.softGray,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    DateFormat('EEEE, MMMM dd, yyyy').format(_selectedDate),
                    style: AppTheme.bodyLarge.copyWith(
                      color: AppTheme.darkBlue,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, 
                       color: AppTheme.softGray, size: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildRecurringOptions() {
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
              const Icon(Icons.repeat, color: AppTheme.softGray),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  'Recurring Transaction',
                  style: AppTheme.bodyLarge.copyWith(
                    color: AppTheme.darkBlue,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Switch(
                value: _isRecurring,
                onChanged: (value) {
                  setState(() {
                    _isRecurring = value;
                  });
                },
                activeColor: AppTheme.primaryBlue,
              ),
            ],
          ),
          if (_isRecurring) ...[
            const SizedBox(height: 16),
            _buildRecurringPeriodSelector(),
            const SizedBox(height: 16),
            _buildRecurringEndDateSelector(),
          ],
        ],
      ),
    );
  }

  Widget _buildRecurringPeriodSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Repeat every',
          style: AppTheme.bodyMedium.copyWith(
            color: AppTheme.softGray,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: RecurringPeriod.values.map((period) {
            final isSelected = _recurringPeriod == period;
            return GestureDetector(
              onTap: () => setState(() => _recurringPeriod = period),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? AppTheme.primaryBlue : Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected ? AppTheme.primaryBlue : AppTheme.lightGray,
                  ),
                ),
                child: Text(
                  period.name.toUpperCase(),
                  style: AppTheme.bodySmall.copyWith(
                    color: isSelected ? Colors.white : AppTheme.softGray,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildRecurringEndDateSelector() {
    return GestureDetector(
      onTap: _selectRecurringEndDate,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppTheme.lightGray.withOpacity(0.3),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppTheme.lightGray),
        ),
        child: Row(
          children: [
            const Icon(Icons.event, color: AppTheme.softGray, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                _recurringEndDate != null
                    ? 'End: ${DateFormat('MMM dd, yyyy').format(_recurringEndDate!)}'
                    : 'Select end date (optional)',
                style: AppTheme.bodyMedium.copyWith(
                  color: _recurringEndDate != null
                      ? AppTheme.darkBlue
                      : AppTheme.softGray,
                ),
              ),
            ),
            if (_recurringEndDate != null)
              GestureDetector(
                onTap: () => setState(() => _recurringEndDate = null),
                child: const Icon(
                  Icons.clear,
                  color: AppTheme.softGray,
                  size: 16,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _saveTransaction,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.primaryBlue,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: _isLoading
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  strokeWidth: 2,
                ),
              )
            : Text(
                widget.transaction != null ? 'Update Transaction' : 'Save Transaction',
                style: AppTheme.bodyLarge.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }

  void _selectDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
                  primary: AppTheme.primaryBlue,
                ),
          ),
          child: child!,
        );
      },
    );

    if (date != null) {
      setState(() {
        _selectedDate = date;
      });
    }
  }

  void _selectRecurringEndDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _recurringEndDate ?? DateTime.now().add(const Duration(days: 30)),
      firstDate: _selectedDate.add(const Duration(days: 1)),
      lastDate: DateTime.now().add(const Duration(days: 3650)), // 10 years
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
                  primary: AppTheme.primaryBlue,
                ),
          ),
          child: child!,
        );
      },
    );

    if (date != null) {
      setState(() {
        _recurringEndDate = date;
      });
    }
  }

  void _saveTransaction() async {
    if (!_formKey.currentState!.validate() || _selectedCategory == null) {
      if (_selectedCategory == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select a category'),
            backgroundColor: AppTheme.error,
          ),
        );
      }
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final transaction = Transaction(
        id: widget.transaction?.id ?? const Uuid().v4(),
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim(),
        amount: double.parse(_amountController.text),
        category: _selectedCategory!,
        type: _transactionType,
        date: _selectedDate,
        accountId: 'default', // TODO: Add account selection
        isRecurring: _isRecurring,
        recurringPeriod: _isRecurring ? _recurringPeriod : null,
        recurringEndDate: _isRecurring ? _recurringEndDate : null,
      );

      if (widget.transaction != null) {
        context.read<TransactionBloc>().add(UpdateTransaction(transaction: transaction));
      } else {
        context.read<TransactionBloc>().add(AddTransaction(transaction: transaction));
      }

      Navigator.pop(context);
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            widget.transaction != null
                ? 'Transaction updated successfully!'
                : 'Transaction added successfully!',
          ),
          backgroundColor: AppTheme.success,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString()}'),
          backgroundColor: AppTheme.error,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _deleteTransaction() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Transaction'),
        content: const Text('Are you sure you want to delete this transaction? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<TransactionBloc>().add(
                    DeleteTransaction(transactionId: widget.transaction!.id),
                  );
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Close screen
              
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Transaction deleted successfully!'),
                  backgroundColor: AppTheme.success,
                ),
              );
            },
            style: TextButton.styleFrom(
              foregroundColor: AppTheme.error,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}