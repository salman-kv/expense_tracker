import 'package:expense_tracker/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:expense_tracker/features/auth/presentation/bloc/auth_bloc/auth_event.dart';
import 'package:expense_tracker/features/auth/presentation/bloc/auth_bloc/auth_state.dart';
import 'package:expense_tracker/features/auth/presentation/pages/login_page.dart';
import 'package:expense_tracker/features/home/presentation/bloc/home_bloc.dart';
import 'package:expense_tracker/features/home/presentation/bloc/home_event.dart';
import 'package:expense_tracker/features/home/presentation/bloc/home_state.dart';
import 'package:expense_tracker/features/home/presentation/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 3),
      () {
        context.read<AuthBloc>().add(AuthCurrentUserEvent());
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is HomeGetTransactionSuccessState) {
            Navigator.of(context)
                .pushAndRemoveUntil(MainPage.route(), (route) => false);
          }
        },
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccessState) {
              context.read<HomeBloc>().add(HomeGetTransactionEvent());
            } else if (state is AuthFailureState) {
              Navigator.of(context)
                  .pushAndRemoveUntil(LoginPage.route(), (route) => false);
            }
          },
          builder: (context, state) {
            return Center(
              child: Lottie.asset('assets/lottie/splash.json'),
            );
          },
        ),
      ),
    );
  }
}
