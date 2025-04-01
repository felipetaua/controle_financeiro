import 'package:expense_repository/expense_repository.dart';

abstract class ExpenseRepository {
  @override
  Future<void> createCategory(Category category);
}
