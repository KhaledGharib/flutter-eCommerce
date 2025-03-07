part of 'product_details_cubit.dart';

sealed class ProductDetailsState {}

final class ProductDetailsInitial extends ProductDetailsState {}

final class ProductDetailsLoading extends ProductDetailsState {}

final class ProductDetailsLoaded extends ProductDetailsState {
  final ProductItemModel productDetails;

  ProductDetailsLoaded({required this.productDetails});
}

final class ProductDetailsError extends ProductDetailsState {
  final String message;

  ProductDetailsError({required this.message});
}
