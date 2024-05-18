
import 'package:expense_tracker/core/error/failures.dart';
import 'package:expense_tracker/core/usecase/usecase.dart';
import 'package:expense_tracker/features/home/domain/repository/home_repository.dart';
import 'package:fpdart/fpdart.dart';

class DeleteTransaction implements UseCase<bool, DeleteTransactionParams> {
  final HomeRepository homeRepository;
  const DeleteTransaction(this.homeRepository);

  @override
  Future<Either<Failure, bool>> call(DeleteTransactionParams params) async {
   
    final res = await homeRepository.deleteTransaction(
        email: params.email, id: params.id);
    if (res) {
      return right(res);
    } else {
      return left(Failure(message: 'transaction not deleted'));
    }
  }
}

class DeleteTransactionParams {
  final String id;
  final String email;

  DeleteTransactionParams({required this.id, required this.email});
}
