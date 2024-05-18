abstract class HomeState {}

final class HomeInitial extends HomeState {}

class HomeAddTransactionSuccessState extends HomeState {}

class HomeAddTransactionFailureState extends HomeState {}

class HomeGetTransactionSuccessState extends HomeState {}

class HomeDeleteTransactionSuccessState extends HomeState {}

class HomeDeleteTransactionFailureState extends HomeState {}

class HomeFilterSuccessState extends HomeState {}

class HomeSortSuccessState extends HomeState {}
