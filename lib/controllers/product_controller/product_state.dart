part of 'product_bloc.dart';

@immutable
abstract class ProductState {}

abstract class ProductActionState extends ProductState {}

final class ProductInitialState extends ProductState {}

final class ProductLoadingState extends ProductState {}

final class ProductLoadedState extends ProductState {
  final List<Product> products;

  ProductLoadedState({required this.products});
}

final class ProductErrorState extends ProductState {
  final String msg;

  ProductErrorState({required this.msg});
}

final class NavigateToCartActionState extends ProductActionState {}
