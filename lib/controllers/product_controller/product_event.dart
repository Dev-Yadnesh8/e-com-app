part of 'product_bloc.dart';

@immutable
abstract class ProductEvent {}

class FetchInitDataEvent extends ProductEvent {}

class CartButtonClickEvent extends ProductEvent {}

class AddToCartEvent extends ProductEvent {
  final Product product;

  AddToCartEvent({required this.product});
}
