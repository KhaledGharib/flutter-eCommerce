part of 'cart_cubit.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<CartItem> items;
  final double totalAmount;

  CartLoaded({
    required this.items,
    required this.totalAmount,
  });
}

class CartError extends CartState {
  final String message;

  CartError({required this.message});
}