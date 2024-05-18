import 'package:expense_tracker/core/alerts/snack_bars.dart';
import 'package:expense_tracker/core/common/widget/common_widget.dart';
import 'package:expense_tracker/core/common/widget/gradient_button.dart';
import 'package:expense_tracker/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:expense_tracker/features/auth/presentation/bloc/auth_bloc/auth_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthWidget {
  signUpContainer({required BuildContext context}) {
    final signUpFormKey = GlobalKey<FormState>();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return Form(
      key: signUpFormKey,
      child: Container(
        margin: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            roundImage(context: context, image: 'assets/images/login.jpg'),
            const Text('Sign Up',
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
            CommonWidget().textFormFieldWidget(
                context: context,
                controller: emailController,
                secure: false,
                labelText: 'Email'),
            CommonWidget().textFormFieldWidget(
                context: context,
                controller: passwordController,
                secure: false,
                labelText: 'Password'),
            const SizedBox(
              height: 10,
            ),
            AuthGradientButton(
                buttonText: 'Sign Up',
                onPressed: () {
                  if (signUpFormKey.currentState!.validate()) {
                    context.read<AuthBloc>().add(AuthUserSignUpEvent(
                        email: emailController.text.trim(),
                        password: passwordController.text.trim()));
                  } else {
                    SnackBars().errorSnackBar(
                        'Please enter valid email and password', context);
                  }
                }),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }

  roundImage({required BuildContext context, required String image}) {
    return Container(
      margin: const EdgeInsets.all(25),
      height: MediaQuery.of(context).size.width * 0.28,
      width: MediaQuery.of(context).size.width * 0.28,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(1000),
        border: Border.all(
          color: const Color.fromARGB(255, 244, 244, 244),
          width: 2,
        ),
        color: const Color.fromARGB(255, 238, 238, 238),
        image: DecorationImage(
          image: AssetImage(image),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class LoginContainer extends StatelessWidget {
  LoginContainer({super.key});
  final loginFormKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: loginFormKey,
      child: Container(
        margin: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AuthWidget().roundImage(
                context: context, image: 'assets/images/profile image.jpg'),
            const Text('Login',
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
            CommonWidget().textFormFieldWidget(
                context: context,
                controller: emailController,
                secure: false,
                labelText: 'Email'),
            CommonWidget().textFormFieldWidget(
                context: context,
                controller: passwordController,
                secure: false,
                labelText: 'Password'),
            const SizedBox(
              height: 10,
            ),
            AuthGradientButton(
                buttonText: 'Login',
                onPressed: () {
                  if (loginFormKey.currentState!.validate()) {
                    context.read<AuthBloc>().add(AuthUserLoginEvent(
                        email: emailController.text.trim(),
                        password: passwordController.text.trim()));
                  } else {
                    SnackBars().errorSnackBar(
                        'Please enter valid email and password', context);
                  }
                }),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}
