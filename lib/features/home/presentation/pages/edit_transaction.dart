import 'package:expense_tracker/core/alerts/snack_bars.dart';
import 'package:expense_tracker/core/common/widget/common_widget.dart';
import 'package:expense_tracker/core/common/widget/gradient_button.dart';
import 'package:expense_tracker/features/home/domain/entities/expense.dart';
import 'package:expense_tracker/features/home/presentation/bloc/home_bloc.dart';
import 'package:expense_tracker/features/home/presentation/bloc/home_event.dart';
import 'package:expense_tracker/features/home/presentation/bloc/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';

class EditTransactionPage extends StatefulWidget {
  static route({required Expense expense}) => MaterialPageRoute(
        builder: (context) {
          return EditTransactionPage(expense: expense);
        },
      );
  final Expense expense;
  const EditTransactionPage({super.key, required this.expense});

  @override
  State<EditTransactionPage> createState() => _TransactionAddingPageState();
}

class _TransactionAddingPageState extends State<EditTransactionPage> {
  TextEditingController catogoryController = TextEditingController();

  TextEditingController amountController = TextEditingController();

  TextEditingController discriptionController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  DateTime? dateTime;
  @override
  void initState() {
    catogoryController.text = widget.expense.catogory;
    amountController.text = widget.expense.amount;
    discriptionController.text = widget.expense.discription;
    dateTime = widget.expense.dateTime;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios_new)),
        ),
        body: BlocConsumer<HomeBloc, HomeState>(
          listener: (context, state) {
            if (state is HomeAddTransactionSuccessState) {
              SnackBars().successSnackBar('transaction added', context);
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            return Form(
              key: formKey,
              child: ListView(
                children: [
                  Text(
                    textAlign: TextAlign.center,
                    'Edit Your Expence',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  CommonWidget().textFormFieldWidget(
                      context: context,
                      labelText: 'Catogory',
                      controller: catogoryController,
                      secure: false),
                  CommonWidget().textFormFieldWidget(
                      textInputType: TextInputType.phone,
                      context: context,
                      labelText: 'Amount',
                      controller: amountController,
                      secure: false),
                  Container(
                    height: 60,
                    margin: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 242, 242, 242),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              dateTime !=
                                      null
                                  ? dateTime.toString()
                                  : 'Select date',
                              style:
                                  Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                          color: const Color.fromARGB(
                                              255, 111, 111, 111),
                                          fontSize: 16)),
                          IconButton(
                              onPressed: () async {
                                DateTime? tempDate =
                                    await pickDate(context: context);
                                if (tempDate != null) {
                                  dateTime = tempDate;
                                  setState(() {});
                                }
                              },
                              icon: const Icon(
                                Icons.arrow_drop_down_circle,
                                size: 30,
                              ))
                        ],
                      ),
                    ),
                  ),
                  CommonWidget().textFormFieldWidget(
                      maxlines: 100,
                      minLines: 5,
                      context: context,
                      labelText: 'Discription',
                      controller: discriptionController,
                      secure: false),
                  Padding(
                    padding: const EdgeInsets.all(25),
                    child: AuthGradientButton(
                        buttonText: 'Submit',
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            if (dateTime != null) {
                              context
                                  .read<HomeBloc>()
                                  .add(HomeAddTransactionEvent(
                                    id: widget.expense.id,
                                    catogory: catogoryController.text.trim(),
                                    amount: amountController.text.trim(),
                                    dateTime: dateTime!,
                                    discription:
                                        discriptionController.text.trim(),
                                  ));
                            } else {
                              SnackBars().errorSnackBar(
                                  'Please select a date', context);
                            }
                          } else {
                            SnackBars().errorSnackBar(
                                'Please fill all fields properly', context);
                          }
                        }),
                  )
                ],
              ),
            );
          },
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
