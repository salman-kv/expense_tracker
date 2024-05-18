import 'package:expense_tracker/core/theme/theme.dart';
import 'package:expense_tracker/features/auth/data/datasources/auth_firebase_data_source.dart';
import 'package:expense_tracker/features/auth/data/repository/auth_repository_impl.dart';
import 'package:expense_tracker/features/auth/domain/usecases/current_user.dart';
import 'package:expense_tracker/features/auth/domain/usecases/user_login.dart';
import 'package:expense_tracker/features/auth/domain/usecases/user_sign_up.dart';
import 'package:expense_tracker/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:expense_tracker/features/auth/presentation/pages/splash_screen.dart';
import 'package:expense_tracker/features/home/data/datasources/home_hive_local_data_soures.dart';
import 'package:expense_tracker/features/home/data/model/expense_model.dart';
import 'package:expense_tracker/features/home/data/repository/home_repository_impl.dart';
import 'package:expense_tracker/features/home/domain/usecase/add_transaction.dart';
import 'package:expense_tracker/features/home/domain/usecase/delete_transaction.dart';
import 'package:expense_tracker/features/home/domain/usecase/get_transaction.dart';
import 'package:expense_tracker/features/home/presentation/bloc/home_bloc.dart';
import 'package:expense_tracker/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(ExpenseModelAdapter().typeId)) {
    Hive.registerAdapter(ExpenseModelAdapter());
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeBloc(
              deleteTransaction: DeleteTransaction(
                  HomeRepositoryImpl(HomeHiveLocalDataSouresImpl())),
              getTransaction: GetTransaction(
                  HomeRepositoryImpl(HomeHiveLocalDataSouresImpl())),
              addTransaction: AddTransaction(
                  HomeRepositoryImpl(HomeHiveLocalDataSouresImpl()))),
        ),
        BlocProvider(
          create: (context) => AuthBloc(
              currentUser:
                  CurrentUser(AuthRepositoryImpl(AuthFirebaseDataSouresImpl())),
              userLogin:
                  UserLogin(AuthRepositoryImpl(AuthFirebaseDataSouresImpl())),
              userSignUp:
                  UserSignUp(AuthRepositoryImpl(AuthFirebaseDataSouresImpl()))),
        )
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Expense Tracker',
          theme: UserTheme().lightTheme,
          darkTheme: UserTheme().darkTheme,
          home: const SplashScreen()),
    );
  }
}
