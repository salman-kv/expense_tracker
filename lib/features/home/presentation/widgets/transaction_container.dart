
import 'package:expense_tracker/core/alerts/alert.dart';
import 'package:expense_tracker/core/theme/const_color.dart';
import 'package:expense_tracker/features/home/domain/entities/expense.dart';
import 'package:expense_tracker/features/home/presentation/bloc/home_bloc.dart';
import 'package:expense_tracker/features/home/presentation/bloc/home_event.dart';
import 'package:expense_tracker/features/home/presentation/pages/edit_transaction.dart';
import 'package:expense_tracker/features/home/presentation/pages/single_transaction_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class TransactionContainer extends StatelessWidget {
  final Expense expense;
  const TransactionContainer({super.key, required this.expense});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(SingleTransactionPage.route(expense: expense));
      },
      onLongPress: () {
        Alerts().editOrDelete(
            context: context,
            text: 'You want To delete or edit Transaction',
            edit: () {
              Navigator.push(
                  context, EditTransactionPage.route(expense: expense));
            },
            delete: () {
              context.read<HomeBloc>().add(HomeDeleteTransactionEvent(
                  id: expense.id, amount: expense.amount));
            });
      },
      child: Container(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height * 0.08,
        ),
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        decoration: BoxDecoration(
          color: ConstColor.backgroundColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const SizedBox(
                    width: 5,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        expense.catogory,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                        DateFormat('dd-MM-yyyy')
                            .format(expense.dateTime)
                            .toString(),
                        style: Theme.of(context).textTheme.titleSmall!,
                      )
                    ],
                  ),
                ],
              ),
              Text(
                '₹${expense.amount}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
