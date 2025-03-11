import 'package:ecommerce/controller/payment_cubit/payment_cubit.dart';
import 'package:ecommerce/controller/product_details_cubit/product_details_cubit.dart';
import 'package:ecommerce/utility/app_routes.dart';
import 'package:ecommerce/view/screen/checkout_screen.dart';
import 'package:ecommerce/view/screen/custom_bottom_navbar.dart';
import 'package:ecommerce/view/screen/home_screen.dart';
import 'package:ecommerce/view/screen/login_screen.dart';
import 'package:ecommerce/view/screen/payment_method_screen.dart';
import 'package:ecommerce/view/screen/product_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case AppRoutes.homeRoute:
        return MaterialPageRoute(builder: (_) => const CustomBottomNavbar());
      case AppRoutes.productDetails:
        // final ProductItemModel product = settings.arguments as ProductItemModel;
        final int productId = settings.arguments as int;
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) {
                  final cubit = ProductDetailsCubit();
                  cubit.getProductDetails(productId);
                  return cubit;
                },
                child: ProductDetails(productId: productId),
              ),
          settings: settings,
        );
      case AppRoutes.checkout:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) {
                  final cubit = PaymentCubit();
                  cubit.getPaymentMethod();
                  return cubit;
                },
                child: const CheckoutScreen(),
              ),
        );
      case AppRoutes.paymentMethod:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) => PaymentCubit(),
                child: const PaymentMethodScreen(),
              ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const SafeArea(child: Center(child: Text("no data"))),
        );
    }
  }
}
