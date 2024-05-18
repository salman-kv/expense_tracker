import 'package:expense_tracker/core/alerts/snack_bars.dart';
import 'package:expense_tracker/core/theme/const_color.dart';
import 'package:expense_tracker/features/home/presentation/bloc/home_bloc.dart';
import 'package:expense_tracker/features/home/presentation/bloc/home_state.dart';
import 'package:expense_tracker/features/home/presentation/pages/custome_appbar.dart';
import 'package:expense_tracker/features/home/presentation/pages/home_page.dart';
import 'package:expense_tracker/features/home/presentation/pages/transaction_adding_page.dart';
import 'package:expense_tracker/features/home/presentation/pages/transaction_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motion_tab_bar_v2/motion-tab-bar.dart';

class MainPage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const MainPage(),
      );
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int page = 0;
  List<Widget> pages = [
    const HomePage(),
    const TransactionAddingPage(),
    const TransactionaPage()
  ];

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is HomeDeleteTransactionSuccessState) {
          SnackBars().errorSnackBar('Delete transaction successfully', context);
        }
      },
      child: SafeArea(
        child: Scaffold(
          appBar: const CustomeAppBar(),
          body: pages[page],
          bottomNavigationBar: MotionTabBar(
            onTabItemSelected: (value) {
              page = value;
              setState(() {});
            },
            initialSelectedTab: 'Home',
            labels: const ['Home', 'Add', 'Transaction'],
            icons: const [Icons.home, Icons.add, Icons.track_changes],
            tabBarColor: const Color.fromARGB(255, 255, 255, 255),
            tabIconColor: ConstColor.gradient1,
            tabIconSize: 30,
            textStyle: Theme.of(context).textTheme.titleSmall,
            tabSelectedColor: ConstColor.gradient1,
          ),
        ),
      ),
    );
  }
}
