
import 'package:expense_tracker/core/error/failures.dart';
import 'package:expense_tracker/core/usecase/usecase.dart';
import 'package:expense_tracker/features/home/domain/entities/expense.dart';
import 'package:expense_tracker/features/home/domain/repository/home_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetTransaction implements UseCase<List<Expense>, GetTransactionParams> {
  final HomeRepository homeRepository;
  const GetTransaction(this.homeRepository);
  @override
  Future<Either<Failure, List<Expense>>> call(
      GetTransactionParams params) async {
    final res = await homeRepository.getTransaction(email: params.email);
    if (res != null) {
      return right(res);
    } else {
      return left(
        Failure(message: 'No data found while getting data from hive'),
      );
    }
  }
}

class GetTransactionParams {
  final String email;

  GetTransactionParams({required this.email});
}
