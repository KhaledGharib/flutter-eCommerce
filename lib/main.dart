import 'package:ecommerce/controller/auth_cubit/auth_cubit.dart';
import 'package:ecommerce/controller/cart_cubit/cart_cubit.dart';
import 'package:ecommerce/controller/home_cubit/home_cubit.dart';
import 'package:ecommerce/utility/app_router.dart';
import 'package:ecommerce/utility/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            final cubit = AuthCubit();
            cubit.checkAuth();
            return cubit;
          },
        ),
        BlocProvider(
          create: (context) {
            final cubit = HomeCubit();
            cubit.getHomeProduct();
            return cubit;
          },
        ),
        BlocProvider(create: (context) => CartCubit()),
        // BlocProvider(create: (context) => PaymentMethodCubit()),
      ],
      child: Builder(
        builder: (context) {
          final authCubit = BlocProvider.of<AuthCubit>(context);
          return BlocBuilder<AuthCubit, AuthState>(
            bloc: authCubit,
            buildWhen:
                (previous, current) =>
                    current is AuthAuthenticated || current is AuthInitial,
            builder: (context, state) {
              return MaterialApp(
                title: 'E-commerce App',
                theme: ThemeData(
                  colorScheme: ColorScheme.fromSeed(
                    seedColor: Color(0xFF514EB5),
                    surface: Colors.white,
                  ),
                ),
                initialRoute:
                    state is AuthAuthenticated
                        ? AppRoutes.homeRoute
                        : AppRoutes.login,
                onGenerateRoute: AppRouter.onGenerateRoute,
              );
            },
          );
        },
      ),
    );
  }
}
