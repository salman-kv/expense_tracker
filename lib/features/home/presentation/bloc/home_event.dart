abstract class HomeEvent {}

class HomeAddTransactionEvent extends HomeEvent {
  final String id;
  final String catogory;
  final String amount;
  final DateTime dateTime;
  final String discription;

  HomeAddTransactionEvent(
      {required this.id,
      required this.catogory,
      required this.amount,
      required this.dateTime,
      required this.discription});
}

class HomeGetTransactionEvent extends HomeEvent {}

class HomeDeleteTransactionEvent extends HomeEvent {
  final String id;
  final String amount;


  HomeDeleteTransactionEvent({required this.id, required this.amount});}

class HomeFilterEvent extends HomeEvent {
  final DateTime startDate;
  final DateTime endDate;

  HomeFilterEvent({required this.startDate, required this.endDate});
}
class HomeDateResetEvent extends HomeEvent{}

class HomeSortEvent extends HomeEvent{
  final bool ascenting;

  HomeSortEvent({required this.ascenting});
}