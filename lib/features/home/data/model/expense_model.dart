import 'package:expense_tracker/features/home/domain/entities/expense.dart';
import 'package:hive/hive.dart';
part 'expense_model.g.dart';

@HiveType(typeId: 0)
class ExpenseModel extends Expense with HiveObjectMixin {
  @HiveField(0)
  @override
  final String id;

  @HiveField(1)
  @override
  final String catogory;

  @HiveField(2)
  @override
  final String amount;

  @HiveField(3)
  @override
  final DateTime dateTime;

  @HiveField(4)
  @override
  final String discription;

  ExpenseModel(
      {required this.id,
      required this.catogory,
      required this.amount,
      required this.dateTime,
      required this.discription})
      : super(
            amount: amount,
            catogory: catogory,
            dateTime: dateTime,
            discription: discription,
            id: id);

  ExpenseModel fromMap(Map<String, dynamic> map) {
    return ExpenseModel(
      id: map['id'],
      catogory: map['catogory'],
      amount: map['amount'],
      dateTime: map['dateTime'] as DateTime,
      discription: map['discription'],
    );
  }
}
