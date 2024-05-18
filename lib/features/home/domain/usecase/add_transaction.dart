import 'package:expense_tracker/core/error/failures.dart';
import 'package:expense_tracker/core/usecase/usecase.dart';
import 'package:expense_tracker/features/home/domain/entities/expense.dart';
import 'package:expense_tracker/features/home/domain/repository/home_repository.dart';
import 'package:fpdart/fpdart.dart';

class AddTransaction implements UseCase<Expense, AddTransactionParam> {
  final HomeRepository homeRepository;
  const AddTransaction(this.homeRepository);
  @override
  Future<Either<Failure, Expense>> call(AddTransactionParam params) async {
    final res = await homeRepository.addTransaction(
      email: params.email,
      id: params.id,
      catogory: params.catogory,
      amount: params.amount,
      dateTime: params.dateTime,
      discription: params.discription,
    );
    if (res != null) {
      return right(res);
    } else {
      return left(Failure(message: 'data adding error'));
    }
  }
}

class AddTransactionParam {
  final String email;
  final String id;
  final String catogory;
  final String amount;
  final DateTime dateTime;
  final String discription;

  AddTransactionParam(
      {required this.email,
      required this.id,
      required this.catogory,
      required this.amount,
      required this.dateTime,
      required this.discription});
}
