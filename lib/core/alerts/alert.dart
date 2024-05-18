import 'package:expense_tracker/core/alerts/snack_bars.dart';
import 'package:expense_tracker/core/theme/const_color.dart';
import 'package:flutter/material.dart';

class Alerts {
  editOrDelete(
      {required BuildContext context,
      required String text,
      required VoidCallback edit,
      required VoidCallback delete}) async {
    await showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            backgroundColor: const Color.fromARGB(255, 238, 237, 235),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            title: Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                Text(
                  text,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    edit();
                  },
                  child: Text(
                    'Edit',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: ConstColor.gradient1),
                  )),
              TextButton(
                  onPressed: () async {
                    Navigator.of(context).pop();
                    delete();
                  },
                  child: Text(
                    'Delete',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: ConstColor.gradient1),
                  )),
            ],
          );
        });
  }

  logOut(
      {required BuildContext context,
      required String text,
      required VoidCallback logOut}) async {
    await showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            backgroundColor: const Color.fromARGB(255, 238, 237, 235),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            title: Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                Text(
                  text,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'No',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: Colors.red),
                  )),
              TextButton(
                  onPressed: () async {
                    Navigator.of(context).pop();
                    logOut();
                    SnackBars().successSnackBar('LogOut Successfully', context);
                  },
                  child: Text(
                    'LogOut',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: ConstColor.gradient1),
                  )),
            ],
          );
        });
  }
}
