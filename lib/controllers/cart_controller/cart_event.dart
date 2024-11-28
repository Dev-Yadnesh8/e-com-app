part of 'cart_bloc.dart';

@immutable
abstract class CartEvent {}

final class CartInitialEvent extends CartEvent {}

final class AddProductToCart extends CartEvent {
  final Product product;
  AddProductToCart({required this.product});
}

final class RemoveProductFromCart extends CartEvent {}

final class IncrementProductQty extends CartEvent {}

final class DecrementProductQty extends CartEvent {}
