import 'package:ecommerce/controller/cart_cubit/cart_cubit.dart';
import 'package:ecommerce/controller/home_cubit/home_cubit.dart';
import 'package:ecommerce/controller/payment_method_cubit/payment_method_cubit.dart';
import 'package:ecommerce/utility/app_router.dart';
import 'package:ecommerce/view/screen/custom_bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
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
            final cubit = HomeCubit();
            cubit.getHomeProduct();
            return cubit;
          },
        ),
        BlocProvider(create: (context) => CartCubit()),
        BlocProvider(create: (context) => PaymentMethodCubit()),
      ],
      child: MaterialApp(
        title: 'E-commerce App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Color(0xFF514EB5),
            surface: Colors.white,
          ),
        ),
        home: PopScope(canPop: false, child: CustomBottomNavbar()),
        onGenerateRoute: AppRouter.onGenerateRoute,
      ),
    );
  }
}
