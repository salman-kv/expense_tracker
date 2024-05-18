import 'package:expense_tracker/core/alerts/snack_bars.dart';
import 'package:expense_tracker/core/common/widget/gradient_button.dart';
import 'package:expense_tracker/core/theme/const_color.dart';
import 'package:expense_tracker/features/home/presentation/bloc/home_bloc.dart';
import 'package:expense_tracker/features/home/presentation/bloc/home_event.dart';
import 'package:expense_tracker/features/home/presentation/bloc/home_state.dart';
import 'package:expense_tracker/features/home/presentation/widgets/transaction_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class TransactionaPage extends StatefulWidget {
  const TransactionaPage({super.key});

  @override
  State<TransactionaPage> createState() => _TransactionaPageState();
}

class _TransactionaPageState extends State<TransactionaPage> {
  @override
  void initState() {
    context.read<HomeBloc>().filterListOfExpence = [
      ...context.read<HomeBloc>().listOfExpence
    ];
    super.initState();
  }

  bool filter = false;
  bool sort = false;
  DateTime? startDate;
  DateTime? endDate;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Column(
          children: [
            Text(
              textAlign: TextAlign.center,
              'All Transaction',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Expanded(
                child: context.watch<HomeBloc>().filterListOfExpence.isNotEmpty
                    ? ListView(
                        children: List.generate(
                            context.read<HomeBloc>().filterListOfExpence.length,
                            (index) => TransactionContainer(
                                expense: context
                                    .read<HomeBloc>()
                                    .filterListOfExpence[index])),
                      )
                    : Lottie.asset('assets/lottie/no data.json')),
            sort
                ? Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.1,
                    margin: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      color: ConstColor.backgroundColor,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                            onPressed: () {
                              SnackBars().successSnackBar(
                                  'Sort assenting successflutty', context);
                              context
                                  .read<HomeBloc>()
                                  .add(HomeSortEvent(ascenting: true));
                              setState(() {
                                sort = !sort;
                              });
                            },
                            child: const Text('Date (ascenting)')),
                        TextButton(
                            onPressed: () {
                              SnackBars().successSnackBar(
                                  'Sort decenting successflutty', context);
                              context
                                  .read<HomeBloc>()
                                  .add(HomeSortEvent(ascenting: false));
                              setState(() {
                                sort = !sort;
                              });
                            },
                            child: const Text('Date (decenting)')),
                      ],
                    ),
                  )
                : const SizedBox(),
            filter
                ? Container(
                    height: MediaQuery.of(context).size.height * 0.2,
                    margin: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      color: ConstColor.backgroundColor,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            dateContainer(start: true),
                            dateContainer(start: false),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AuthGradientButton(
                                buttonText: ('Submit'),
                                onPressed: () {
                                  if ((startDate != null && endDate != null)) {
                                    if (startDate!.compareTo(endDate!) > 0) {
                                      SnackBars().errorSnackBar(
                                          'Staring date is after end date, select proper date',
                                          context);
                                    } else {
                                      filter = false;
                                      context.read<HomeBloc>().add(
                                          HomeFilterEvent(
                                              startDate: startDate!,
                                              endDate: endDate!));
                                    }
                                  } else {
                                    SnackBars().errorSnackBar(
                                        'Please select start and end date',
                                        context);
                                  }
                                })
                          ],
                        ),
                        TextButton.icon(
                            onPressed: () {
                              setState(() {
                                SnackBars().successSnackBar(
                                    'Filter reset successfully', context);
                                filter = false;
                                startDate = null;
                                endDate = null;
                                context
                                    .read<HomeBloc>()
                                    .add(HomeDateResetEvent());
                              });
                            },
                            icon: const Icon(Icons.restart_alt_rounded),
                            label: const Text('reset'))
                      ],
                    ),
                  )
                : const SizedBox(),
            Container(
              height: MediaQuery.of(context).size.height * 0.06,
              margin: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                  color: ConstColor.backgroundColor,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton.icon(
                    onPressed: () {
                      setState(() {
                        sort = !sort;
                      });
                    },
                    icon: const Icon(Icons.sort),
                    label: Text(
                      'Sort',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      setState(() {
                        filter = !filter;
                      });
                    },
                    icon: const Icon(Icons.filter_alt),
                    label: Text(
                      'Filter',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }

  dateContainer({required bool start}) {
    return GestureDetector(
      onTap: () async {
        DateTime? tempDateTime = await pickDate(context: context);
        if (tempDateTime != null) {
          setState(() {
            start ? startDate = tempDateTime : endDate = tempDateTime;
          });
        }
      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.05,
        width: MediaQuery.of(context).size.width * 0.3,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    start
                        ? startDate != null
                            ? DateFormat('dd-MM-yyyy')
                                .format(startDate!)
                                .toString()
                            : 'start Date'
                        : endDate != null
                            ? DateFormat('dd-MM-yyyy')
                                .format(endDate!)
                                .toString()
                            : 'end Date',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: const Color.fromARGB(255, 111, 111, 111),
                        fontSize: 16)),
              ),
            ),
            const Icon(Icons.arrow_drop_down)
          ],
        ),
      ),
    );
  }

  pickDate({required BuildContext context}) async {
    DateTime? newDateTime = await showRoundedDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 1),
      lastDate: DateTime.now(),
      borderRadius: 16,
    );
    if (newDateTime != null) {
      newDateTime = newDateTime.copyWith(
        minute: 0,
        hour: 0,
        millisecond: 0,
        microsecond: 0,
        second: 0,
      );
    }
    return newDateTime;
  }
}
