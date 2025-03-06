part of 'home_cubit.dart';

sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeLoaded extends HomeState {
  final List<ProductItemModel> apiProduct;

  HomeLoaded({required this.apiProduct});
}

final class HomeError extends HomeState {
  final String message;

  HomeError({required this.message});
}
