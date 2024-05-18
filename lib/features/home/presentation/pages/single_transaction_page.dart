import 'package:expense_tracker/core/theme/const_color.dart';
import 'package:expense_tracker/features/home/domain/entities/expense.dart';
import 'package:expense_tracker/features/home/presentation/bloc/home_bloc.dart';
import 'package:expense_tracker/features/home/presentation/bloc/home_event.dart';
import 'package:expense_tracker/features/home/presentation/pages/edit_transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class SingleTransactionPage extends StatelessWidget {
  static route({required expense}) => MaterialPageRoute(
        builder: (context) {
          return SingleTransactionPage(expense: expense);
        },
      );
  final Expense expense;
  const SingleTransactionPage({super.key, required this.expense});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: ListView(
        children: [
          Text(
            textAlign: TextAlign.center,
            expense.catogory,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Container(
            margin: const EdgeInsets.all(20),
            constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height * 0.2),
            decoration: BoxDecoration(
              color: ConstColor.backgroundColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Amount        :  ₹${expense.amount}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    'Date                :  ${DateFormat('dd-MM-yyyy').format(expense.dateTime).toString()}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Row(
                    children: [
                      Text(
                        'Discription :  ',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Expanded(
                        child: Text(
                          expense.discription,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton.icon(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                        EditTransactionPage.route(expense: expense));
                  },
                  icon: const Icon(Icons.edit),
                  label: Text(
                    'Edit',
                    style: Theme.of(context).textTheme.titleMedium,
                  )),
              TextButton.icon(
                  onPressed: () {
                    context
                        .read<HomeBloc>()
                        .add(HomeDeleteTransactionEvent(id: expense.id,amount: expense.amount));
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.delete),
                  label: Text(
                    'Delete',
                    style: Theme.of(context).textTheme.titleMedium,
                  ))
            ],
          )
        ],
      ),
    ));
  }
}
