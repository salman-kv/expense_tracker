import 'package:expense_tracker/core/alerts/alert.dart';
import 'package:expense_tracker/core/theme/const_color.dart';
import 'package:expense_tracker/features/auth/presentation/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CustomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                height: 60,
                width: 60,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/profile image.jpg')),
                    color: ConstColor.gradient1,
                    borderRadius: BorderRadius.all(Radius.circular(100))),
              ),
              const SizedBox(
                width: 8,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Welcome',
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall!
                        .copyWith(fontSize: 12),
                  ),
                  Text(
                    'Salman',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontSize: 20),
                  ),
                ],
              ),
            ],
          ),
          IconButton(
              onPressed: () {
                Alerts().logOut(
                    context: context,
                    text: 'Do You want to Logout',
                    logOut: () {
                      FirebaseAuth.instance.signOut();
                      Navigator.pushAndRemoveUntil(
                          context, LoginPage.route(), (route) => false);
                    });
              },
              icon: const Icon(
                Icons.logout_outlined,
                size: 30,
              ))
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 80);
}
