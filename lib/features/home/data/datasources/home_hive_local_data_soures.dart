import 'package:expense_tracker/features/home/data/model/expense_model.dart';
import 'package:hive/hive.dart';

abstract class HomeHiveLocalDataSoures {
  Future<ExpenseModel?> addTransaction(
      {required String email,
      required String id,
      required String catogory,
      required String amount,
      required DateTime dateTime,
      required String discription});
  Future<List<ExpenseModel>?> getTransaction({required String email});
  Future<bool> deleteTransaction({required String id, required String email});
}

class HomeHiveLocalDataSouresImpl implements HomeHiveLocalDataSoures {
  @override
  Future<ExpenseModel?> addTransaction(
      {required String id,
      required String catogory,
      required String amount,
      required DateTime dateTime,
      required String discription,
      required String email}) async {
    try {
      final hive = await Hive.openBox<ExpenseModel>(email);

      hive.put(
          id,
          ExpenseModel(
              id: id,
              catogory: catogory,
              amount: amount,
              dateTime: dateTime,
              discription: discription));
      return ExpenseModel(
          id: id,
          catogory: catogory,
          amount: amount,
          dateTime: dateTime,
          discription: discription);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<ExpenseModel>?> getTransaction({required String email}) async {
    try {
      final hive = await Hive.openBox<ExpenseModel>(email);

      return hive.values.toList();
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool> deleteTransaction(
      {required String id, required String email}) async {
    try {
      final hive = await Hive.openBox<ExpenseModel>(email);
      await hive.delete(id);
      return true;
    } catch (e) {
      throw Exception();
    }
  }
}
