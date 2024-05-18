import 'package:expense_tracker/core/alerts/snack_bars.dart';
import 'package:expense_tracker/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:expense_tracker/features/auth/presentation/bloc/auth_bloc/auth_state.dart';
import 'package:expense_tracker/features/auth/presentation/pages/sign_up_page.dart';
import 'package:expense_tracker/features/auth/presentation/widgets/auth_widget.dart';
import 'package:expense_tracker/features/home/presentation/bloc/home_bloc.dart';
import 'package:expense_tracker/features/home/presentation/bloc/home_event.dart';
import 'package:expense_tracker/features/home/presentation/bloc/home_state.dart';
import 'package:expense_tracker/features/home/presentation/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  static route() => MaterialPageRoute(
        builder: (context) {
          return const LoginPage();
        },
      );

  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 239, 239, 239),
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
                SnackBars().successSnackBar(state.user, context);
              } else if (state is AuthFailureState) {
                SnackBars().errorSnackBar(state.message, context);
              }
            },
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LoginContainer(),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, SignUpPage.route());
                    },
                    child: RichText(
                        text: const TextSpan(
                            text: "You don't have accouny? ",
                            style: TextStyle(color: Colors.black),
                            children: [
                          TextSpan(
                              text: 'Sign Up',
                              style: TextStyle(color: Colors.purple))
                        ])),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
