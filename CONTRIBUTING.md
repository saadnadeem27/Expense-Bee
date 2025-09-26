# Contributing to ExpenseBee 🐝

Thank you for your interest in contributing to ExpenseBee! We welcome contributions from developers of all skill levels. This document provides guidelines for contributing to make the process smooth and effective for everyone.

## 📋 Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [Development Setup](#development-setup)
- [How to Contribute](#how-to-contribute)
- [Pull Request Process](#pull-request-process)
- [Coding Standards](#coding-standards)
- [Testing Guidelines](#testing-guidelines)
- [Documentation](#documentation)
- [Issue Reporting](#issue-reporting)

## 🤝 Code of Conduct

This project and everyone participating in it is governed by our Code of Conduct. By participating, you are expected to uphold this code.

### Our Standards

- **Be respectful** and inclusive in your interactions
- **Be collaborative** and constructive in discussions
- **Be patient** with newcomers and those asking questions
- **Focus on what's best** for the community and the project

## 🚀 Getting Started

### Prerequisites

Before you begin, ensure you have:

- **Flutter SDK** (3.0 or higher)
- **Dart SDK** (3.0 or higher)
- **Git** for version control
- **VS Code** or **Android Studio** as IDE
- **Firebase** account for backend services

### Development Setup

1. **Fork the repository**
   ```bash
   # Fork the repo on GitHub, then clone your fork
   git clone https://github.com/YOUR_USERNAME/expense-bee.git
   cd expense-bee
   ```

2. **Set up the development environment**
   ```bash
   # Install dependencies
   flutter pub get
   
   # Run code generation
   flutter packages pub run build_runner build
   
   # Verify installation
   flutter doctor
   ```

3. **Create a new branch**
   ```bash
   git checkout -b feature/your-feature-name
   # or
   git checkout -b fix/your-bug-fix
   ```

## 🛠️ How to Contribute

### Types of Contributions

We welcome several types of contributions:

#### 🐛 **Bug Fixes**
- Fix existing bugs or issues
- Improve error handling
- Performance optimizations

#### ✨ **New Features**
- Add new functionality
- Enhance existing features
- UI/UX improvements

#### 📚 **Documentation**
- Improve existing documentation
- Add code comments
- Create tutorials or guides

#### 🧪 **Testing**
- Add unit tests
- Add widget tests
- Add integration tests
- Improve test coverage

#### 🎨 **Design & UI**
- Design improvements
- Accessibility enhancements
- Theme and styling updates

### Contribution Workflow

1. **Check existing issues** - Look for existing issues or create a new one
2. **Discuss your idea** - Comment on the issue to discuss your approach
3. **Fork and branch** - Create your feature branch
4. **Develop** - Make your changes following our coding standards
5. **Test** - Ensure all tests pass and add new tests if needed
6. **Document** - Update documentation if necessary
7. **Submit PR** - Create a pull request with a clear description

## 📥 Pull Request Process

### Before Submitting

- [ ] Ensure your code follows our [coding standards](#coding-standards)
- [ ] All tests pass (`flutter test`)
- [ ] No linting errors (`flutter analyze`)
- [ ] Add/update tests for new functionality
- [ ] Update documentation if needed
- [ ] Your branch is up to date with main

### Pull Request Template

```markdown
## Description
Brief description of changes made

## Type of Change
- [ ] Bug fix (non-breaking change that fixes an issue)
- [ ] New feature (non-breaking change that adds functionality)
- [ ] Breaking change (fix or feature that causes existing functionality to not work as expected)
- [ ] Documentation update

## Testing
- [ ] Unit tests added/updated
- [ ] Widget tests added/updated
- [ ] Integration tests added/updated
- [ ] Manual testing completed

## Screenshots (if applicable)
Add screenshots for UI changes

## Checklist
- [ ] Code follows project coding standards
- [ ] Self-review completed
- [ ] Tests added and passing
- [ ] Documentation updated
```

### Review Process

1. **Automated checks** - CI/CD pipeline runs tests and analysis
2. **Peer review** - At least one maintainer reviews the code
3. **Feedback incorporation** - Address any requested changes
4. **Final approval** - Maintainer approves and merges

## 📝 Coding Standards

### Dart/Flutter Guidelines

Follow [Effective Dart](https://dart.dev/guides/language/effective-dart) guidelines:

```dart
// ✅ Good - Clear naming and structure
class TransactionService {
  Future<List<Transaction>> getTransactionsByCategory(String category) async {
    // Implementation
  }
}

// ❌ Bad - Unclear naming
class TS {
  Future<List<Transaction>> get(String c) async {
    // Implementation
  }
}
```

### File Organization

```
lib/
├── core/
│   ├── config/          # Configuration files
│   ├── constants/       # App constants
│   ├── services/        # External services
│   ├── theme/          # Theming
│   └── utils/          # Utility functions
├── data/
│   ├── datasources/    # Data sources (local/remote)
│   ├── models/         # Data models
│   └── repositories/   # Repository implementations
├── domain/
│   ├── entities/       # Business entities
│   ├── repositories/   # Repository abstractions
│   └── usecases/       # Business logic
└── presentation/
    ├── bloc/           # State management
    ├── screens/        # UI screens
    └── widgets/        # Reusable widgets
```

### Code Style

- **Use meaningful names** for variables, functions, and classes
- **Keep functions small** - ideally under 20 lines
- **Add comments** for complex business logic
- **Use const constructors** where possible
- **Follow BLoC pattern** for state management
- **Implement proper error handling**

### Example Code Structure

```dart
// ✅ Good example following our standards
class BudgetBloc extends Bloc<BudgetEvent, BudgetState> {
  final BudgetRepository _budgetRepository;
  final AnalyticsService _analyticsService;

  BudgetBloc({
    required BudgetRepository budgetRepository,
    required AnalyticsService analyticsService,
  })  : _budgetRepository = budgetRepository,
        _analyticsService = analyticsService,
        super(const BudgetInitial()) {
    on<LoadBudgets>(_onLoadBudgets);
    on<CreateBudget>(_onCreateBudget);
  }

  Future<void> _onLoadBudgets(
    LoadBudgets event,
    Emitter<BudgetState> emit,
  ) async {
    try {
      emit(const BudgetLoading());
      
      final budgets = await _budgetRepository.getBudgets(event.userId);
      
      emit(BudgetLoaded(budgets: budgets));
      
      await _analyticsService.logEvent('budgets_loaded', {
        'count': budgets.length,
      });
    } catch (error) {
      emit(BudgetError(message: error.toString()));
    }
  }
}
```

## 🧪 Testing Guidelines

### Testing Requirements

- **Unit Tests** - Test business logic and utilities
- **Widget Tests** - Test UI components
- **Integration Tests** - Test complete user flows
- **Minimum 80% code coverage**

### Writing Tests

```dart
// Unit test example
group('BudgetCalculator', () {
  test('should calculate remaining budget correctly', () {
    // Arrange
    const budget = 1000.0;
    const spent = 300.0;
    
    // Act
    final remaining = BudgetCalculator.calculateRemaining(budget, spent);
    
    // Assert
    expect(remaining, equals(700.0));
  });
});

// Widget test example
testWidgets('TransactionCard displays transaction information', (tester) async {
  // Arrange
  const transaction = Transaction(
    id: '1',
    title: 'Coffee',
    amount: 5.99,
    category: 'Food',
    date: DateTime(2023, 1, 1),
  );

  // Act
  await tester.pumpWidget(
    MaterialApp(
      home: TransactionCard(transaction: transaction),
    ),
  );

  // Assert
  expect(find.text('Coffee'), findsOneWidget);
  expect(find.text('\$5.99'), findsOneWidget);
  expect(find.text('Food'), findsOneWidget);
});
```

### Running Tests

```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage

# Run specific test file
flutter test test/unit/budget_calculator_test.dart

# Run widget tests
flutter test test/widget/

# Run integration tests
flutter test integration_test/
```

## 📚 Documentation

### Code Documentation

```dart
/// Service for managing user authentication and session state.
/// 
/// This service provides methods for user login, logout, registration,
/// and session management. It integrates with Firebase Authentication
/// and maintains local user state.
class AuthService {
  /// Signs in a user with email and password.
  /// 
  /// Returns [AuthResult] with user information on success,
  /// or error details on failure.
  /// 
  /// Throws [AuthException] if the credentials are invalid.
  Future<AuthResult> signInWithEmailPassword(
    String email,
    String password,
  ) async {
    // Implementation
  }
}
```

### README Updates

When adding new features, update the README with:
- Feature description
- Usage instructions
- Configuration requirements
- Screenshots (if UI changes)

## 🐛 Issue Reporting

### Bug Reports

When reporting bugs, include:

```markdown
## Bug Description
Clear description of the bug

## Steps to Reproduce
1. Go to...
2. Click on...
3. See error

## Expected Behavior
What should have happened

## Actual Behavior
What actually happened

## Environment
- Flutter version: 
- Dart version:
- Platform: (iOS/Android/Web)
- Device: 
- OS version:

## Screenshots
If applicable, add screenshots

## Additional Context
Any other relevant information
```

### Feature Requests

```markdown
## Feature Description
Clear description of the proposed feature

## Problem Statement
What problem does this solve?

## Proposed Solution
How should this feature work?

## Alternatives Considered
Other solutions you've considered

## Additional Context
Mockups, examples, or other relevant information
```

## 🏷️ Commit Message Guidelines

Use conventional commits format:

```
type(scope): subject

body

footer
```

### Types
- **feat**: New feature
- **fix**: Bug fix
- **docs**: Documentation changes
- **style**: Code style changes (formatting, etc.)
- **refactor**: Code refactoring
- **test**: Adding or updating tests
- **chore**: Maintenance tasks

### Examples

```bash
feat(auth): add biometric authentication

Add fingerprint and face ID authentication support for
enhanced security. Users can now enable biometric auth
in settings.

Closes #123

fix(budget): resolve budget calculation overflow

Fixed integer overflow when calculating large budget amounts.
Now using double precision for all budget calculations.

Fixes #456

docs(readme): update installation instructions

Added Firebase setup steps and environment configuration
examples for new contributors.
```

## 📞 Getting Help

If you need help or have questions:

1. **Check existing documentation** - README, wiki, code comments
2. **Search existing issues** - Someone might have had the same question
3. **Join our community** - Discord server for real-time discussions
4. **Create an issue** - For bugs, feature requests, or questions
5. **Contact maintainers** - For sensitive issues or direct communication

## 🎉 Recognition

Contributors are recognized in:
- **CONTRIBUTORS.md** file
- **Release notes** for significant contributions  
- **GitHub contributors** section
- **Community highlights** in our Discord

## 📄 License

By contributing to ExpenseBee, you agree that your contributions will be licensed under the same [MIT License](LICENSE) that covers the project.

---

Thank you for contributing to ExpenseBee! Your efforts help make personal finance management better for everyone. 🎉