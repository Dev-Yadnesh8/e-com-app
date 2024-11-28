import 'dart:async';
import 'package:e_com_app/models/cart_item_model.dart';
import 'package:e_com_app/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final List<CartItem> _cartItems = [];
  List<CartItem> get cartItems => _cartItems;

  double _totalPrice = 0.0;
  double get totalPrice => _totalPrice;

  CartBloc() : super(CartInitialState()) {
    // Initialize state where we will show cart items
    on<CartInitialEvent>(cartInitialEvent);
    // Add product to cart
    on<AddProductToCart>(addProductToCart);
    // Remove product from cart
    on<RemoveProductFromCart>(removeProductFromCart);
    // Increment product quantity
    on<IncrementProductQty>(incrementProductQty);
    // Decrement product quantity
    on<DecrementProductQty>(decrementProductQty);
  }

  // Initial cart load event
  FutureOr<void> cartInitialEvent(
      CartInitialEvent event, Emitter<CartState> emit) {
    emit(CartLoadedState(cartProducts: _cartItems));
  }

  // Add product to cart
  FutureOr<void> addProductToCart(
      AddProductToCart event, Emitter<CartState> emit) {
    // Check if the product already exists in the cart
    final existingCartItem = _cartItems.firstWhere(
      (cartItem) => cartItem.product.id == event.product.id,
      orElse: () =>
          CartItem(product: event.product), // Create new CartItem if not found
    );

    if (_cartItems.contains(existingCartItem)) {
      // Increment quantity if the product is already in the cart
      existingCartItem.quantity += 1;
    } else {
      // Add new CartItem to the cart
      _cartItems.add(existingCartItem);
    }
    calculatePrice();

    emit(CartLoadedState(cartProducts: _cartItems));
  }

  // Remove product from cart
  FutureOr<void> removeProductFromCart(
      RemoveProductFromCart event, Emitter<CartState> emit) {
    // Remove the product from the cart by matching product id
    _cartItems
        .removeWhere((cartItem) => cartItem.product.id == event.productId);
    if (_cartItems.isEmpty) {
      _totalPrice = 0.0;
      emit(CartLoadedState(cartProducts: _cartItems));
    } else {
      calculatePrice();
      emit(CartLoadedState(cartProducts: _cartItems));
    }
  }

  // Increment product quantity
  FutureOr<void> incrementProductQty(
      IncrementProductQty event, Emitter<CartState> emit) {
    // Find the CartItem in the cart and increment the quantity
    final cartItem = _cartItems.firstWhere(
      (cartItem) => cartItem.product.id == event.productId,
    );

    cartItem.quantity += 1;
    calculatePrice();
    emit(CartLoadedState(cartProducts: _cartItems));
  }

  // Decrement product quantity
  FutureOr<void> decrementProductQty(
      DecrementProductQty event, Emitter<CartState> emit) {
    // Find the CartItem in the cart and decrement the quantity
    final cartItem = _cartItems.firstWhere(
      (cartItem) => cartItem.product.id == event.productId,
    );

    if (cartItem.quantity > 1) {
      cartItem.quantity -= 1;
      calculatePrice();
      emit(CartLoadedState(cartProducts: _cartItems));
    }
  }

  void calculatePrice() {
    _totalPrice = 0.0; // Reset total price before recalculating

    for (var item in _cartItems) {

      final double discountedPrice = item.product.price -
          (item.product.price * (item.product.discountPercentage / 100));
      final qty = item.quantity;
      _totalPrice += qty * discountedPrice;
    }
  }
}
