import 'package:expense_tracker/features/home/presentation/bloc/home_bloc.dart';
import 'package:expense_tracker/features/home/presentation/bloc/home_state.dart';
import 'package:expense_tracker/features/home/presentation/widgets/total_expense.dart';
import 'package:expense_tracker/features/home/presentation/widgets/transaction_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView(children: [
          const TotalExpenceContainer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text('Resend Transaction',
                style: Theme.of(context).textTheme.titleLarge),
          ),
          context.watch<HomeBloc>().listOfExpence.isNotEmpty
              ? Column(
                  children: List.generate(
                      context.read<HomeBloc>().listOfExpence.length > 10
                          ? 10
                          : context.read<HomeBloc>().listOfExpence.length,
                      (index) {
                    return TransactionContainer(
                      expense: context
                          .read<HomeBloc>()
                          .listOfExpence
                          .reversed
                          .toList()[index],
                    );
                  }),
                )
              : Lottie.asset('assets/lottie/no data.json')
        ]);
      },
    );
  }
}
