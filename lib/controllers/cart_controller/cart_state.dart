part of 'cart_bloc.dart';

@immutable
abstract class CartState {}

final class CartInitialState extends CartState {}

final class CartLoadedState extends CartState {
  final List<Product> cartProducts;

  CartLoadedState({required this.cartProducts});
}

final class CartErrorState extends CartState {}
