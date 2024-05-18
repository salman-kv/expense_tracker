class Expense {
  final String id;
  final String catogory;
  final String amount;
  final DateTime dateTime;
  final String discription;

  Expense(
      {required this.id,
      required this.catogory,
      required this.amount,
      required this.dateTime,
      required this.discription});
}
