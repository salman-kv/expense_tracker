import 'package:expense_tracker/core/common/shared_prefrences/shared_prefrence.dart';
import 'package:expense_tracker/features/home/domain/entities/expense.dart';
import 'package:expense_tracker/features/home/domain/usecase/add_transaction.dart';
import 'package:expense_tracker/features/home/domain/usecase/delete_transaction.dart';
import 'package:expense_tracker/features/home/domain/usecase/get_transaction.dart';
import 'package:expense_tracker/features/home/presentation/bloc/home_event.dart';
import 'package:expense_tracker/features/home/presentation/bloc/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  List<Expense> listOfExpence = [];
  int totalExpense = 0;
  List<Expense> filterListOfExpence = [];
  final AddTransaction _addTransaction;
  final GetTransaction _getTransaction;
  final DeleteTransaction _deleteTransaction;
  HomeBloc(
      {required GetTransaction getTransaction,
      required AddTransaction addTransaction,
      required DeleteTransaction deleteTransaction})
      : _addTransaction = addTransaction,
        _getTransaction = getTransaction,
        _deleteTransaction = deleteTransaction,
        super(HomeInitial()) {
    on<HomeAddTransactionEvent>((event, emit) async {
      String email = await SharedPreferencesClass.getUserEmail();
      final res = await _addTransaction(AddTransactionParam(
          email: email,
          id: event.id,
          catogory: event.catogory,
          amount: event.amount,
          dateTime: event.dateTime,
          discription: event.discription));
      res.fold((l) => emit(HomeAddTransactionFailureState()), (r) {
        emit(HomeAddTransactionSuccessState());
        add(HomeGetTransactionEvent());
      });
    });
    on<HomeGetTransactionEvent>((event, emit) async {
      String email = await SharedPreferencesClass.getUserEmail();
      final res = await _getTransaction(GetTransactionParams(email: email));

      res.fold((l) => emit(HomeAddTransactionFailureState()), (r) {
        if (listOfExpence.isNotEmpty) {
          listOfExpence.clear();
        }
        listOfExpence = [...r];
        filterListOfExpence = [...listOfExpence];
        totalExpense = 0;
        for (Expense i in listOfExpence) {
          totalExpense += int.parse(i.amount);
        }
        emit(HomeGetTransactionSuccessState());
      });
    });
    on<HomeDeleteTransactionEvent>((event, emit) async {
      String email = await SharedPreferencesClass.getUserEmail();
      final res = await _deleteTransaction(
          DeleteTransactionParams(id: event.id, email: email));
      res.fold((l) => emit(HomeDeleteTransactionFailureState()), (r) {
        totalExpense -= int.parse(event.amount);
        emit(HomeDeleteTransactionSuccessState());
        add(HomeGetTransactionEvent());
      });
    });
    on<HomeFilterEvent>((event, emit) {
      List<Expense> tempListExpense = [];
      for (Expense i in listOfExpence) {
        if ((event.startDate.compareTo(i.dateTime) < 0 ||
                event.startDate.compareTo(i.dateTime) == 0) &&
            (event.endDate.compareTo(i.dateTime) > 0 ||
                event.endDate.compareTo(i.dateTime) == 0)) {
          tempListExpense.add(i);
        }
      }
      filterListOfExpence = [...tempListExpense];
      emit(HomeFilterSuccessState());
    });

    on<HomeDateResetEvent>((event, emit) {
      filterListOfExpence = [...listOfExpence];
      emit(HomeFilterSuccessState());
    });
    on<HomeSortEvent>((event, emit) {
      List<Expense> temp = [...filterListOfExpence];
      if (event.ascenting) {
        temp.sort((a, b) => a.dateTime.compareTo(b.dateTime));
      } else {
        temp.sort((a, b) => b.dateTime.compareTo(a.dateTime));
      }
      filterListOfExpence = [...temp];
      emit(HomeFilterSuccessState());
    });
  }
}
