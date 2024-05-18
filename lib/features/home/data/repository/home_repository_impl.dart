import 'package:expense_tracker/features/home/data/datasources/home_hive_local_data_soures.dart';
import 'package:expense_tracker/features/home/domain/entities/expense.dart';
import 'package:expense_tracker/features/home/domain/repository/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeHiveLocalDataSoures homeHiveLocalDataSoures;
  const HomeRepositoryImpl(this.homeHiveLocalDataSoures);
  @override
  Future<Expense?> addTransaction(
      {required String id,
      required String catogory,
      required String amount,
      required DateTime dateTime,
      required String discription,
      required String email}) async {
    try {
      final res = await homeHiveLocalDataSoures.addTransaction(
          email: email,
          id: id,
          catogory: catogory,
          amount: amount,
          dateTime: dateTime,
          discription: discription);
      if (res != null) {
        return res;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<Expense>?> getTransaction({required String email}) async {
    try {
      final res = await homeHiveLocalDataSoures.getTransaction(email: email);
      if (res != null) {
        return res;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool> deleteTransaction(
      {required String email, required String id}) async {
    try {
      final res =
          await homeHiveLocalDataSoures.deleteTransaction(id: id, email: email);
      return res;
    } catch (e) {
      throw Exception();
    }
  }
}
