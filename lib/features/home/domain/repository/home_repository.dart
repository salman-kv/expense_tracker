import 'package:expense_tracker/features/home/domain/entities/expense.dart';

abstract class HomeRepository {
  Future<Expense?> addTransaction(
      {required String email,
      required String id,
      required String catogory,
      required String amount,
      required DateTime dateTime,
      required String discription});
  Future<List<Expense>?> getTransaction({
    required String email,
  });
  Future<bool> deleteTransaction({
    required String email,
    required String id,
  });
}
