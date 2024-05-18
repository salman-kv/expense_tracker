import 'package:expense_tracker/core/error/failures.dart';
import 'package:expense_tracker/core/usecase/usecase.dart';
import 'package:expense_tracker/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
class CurrentUser implements UseCase<String,NoParams>{
  final AuthRepository authRepository; 
  const CurrentUser(this.authRepository);
  @override
  Future<Either<Failure, String>> call(NoParams params) async {
  try{
    return await authRepository.currentUser();
  }catch(e){
    return left(Failure(message: e.toString()));
  }
  }
}