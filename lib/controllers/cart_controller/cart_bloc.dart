import 'dart:async';
import 'package:e_com_app/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final List<Product> _cartProducts = [];
   List<Product> get cartProducts => _cartProducts;
  CartBloc() : super(CartInitialState()) {
    // init state where we will show cart items
    on<CartInitialEvent>(cartInitialEvent);
    // add product to cart
    on<AddProductToCart>(addProductToCart);
    // remove product from cart
    on<RemoveProductFromCart>(removeProductFromCart);
    // increment product qty
    on<IncrementProductQty>(incrementProductQty);
    // decrement product qty
    on<DecrementProductQty>(decrementProductQty);
  }

  FutureOr<void> cartInitialEvent(CartInitialEvent event, Emitter<CartState> emit) {
    emit(CartLoadedState(cartProducts: _cartProducts));
  }

  FutureOr<void> addProductToCart(AddProductToCart event, Emitter<CartState> emit) {
    print("Product Added");
    _cartProducts.add(event.product);
    emit(CartLoadedState(cartProducts: _cartProducts));
  }

  FutureOr<void> removeProductFromCart(
      RemoveProductFromCart event, Emitter<CartState> emit) {}

  FutureOr<void> incrementProductQty(
      IncrementProductQty event, Emitter<CartState> emit) {}

  FutureOr<void> decrementProductQty(
      DecrementProductQty event, Emitter<CartState> emit) {}
}
