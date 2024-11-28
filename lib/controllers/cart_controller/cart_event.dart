part of 'cart_bloc.dart';

@immutable
abstract class CartEvent {}

final class CartInitialEvent extends CartEvent {}

final class AddProductToCart extends CartEvent {
  final Product product;
  AddProductToCart({required this.product});
}

final class RemoveProductFromCart extends CartEvent {
  final int productId;

  RemoveProductFromCart({required this.productId});
}

final class IncrementProductQty extends CartEvent {
  final int productId;

  IncrementProductQty({required this.productId});
}

final class DecrementProductQty extends CartEvent {
  final int productId;

  DecrementProductQty({required this.productId});
}
