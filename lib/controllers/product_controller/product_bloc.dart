import 'dart:async';

import 'package:e_com_app/models/product_model.dart';
import 'package:e_com_app/repository/product_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepo productRepo;

  final List<Product> _products = [];
  List<Product> get products => _products;

  final int _limit = 20;
  int _skip = 0;

  ProductBloc(this.productRepo) : super(ProductInitialState()) {
    // fetching initial products
    on<FetchInitDataEvent>(fetchInitDataEvent);
    // fetching more products on scrolling
    on<FetchMoreDataEvent>(fetchMoreDataEvent);

    // clicking cart button on appbar for navigation to cart page
    on<CartButtonClickEvent>(cartButtonClickEvent);
  }

  // method for fetching initial data event
  FutureOr<void> fetchInitDataEvent(
      FetchInitDataEvent event, Emitter<ProductState> emit) async {
    emit(ProductLoadingState());
    try {
      final newProducts =
          await productRepo.fetchAllProductsWithPagingnation(_skip, _limit);
      // Add new products to the existing list
      _products.addAll(newProducts);
      _skip += _limit; // Update skip value for next request
      emit(ProductLoadedState(products: _products));
    } catch (e) {
      print(e);
      emit(ProductErrorState(msg: e.toString()));
    }
  }

// method for cart button on appbar for navigation to cart page
  FutureOr<void> cartButtonClickEvent(
      CartButtonClickEvent event, Emitter<ProductState> emit) {
    emit(NavigateToCartActionState());
  }

  FutureOr<void> fetchMoreDataEvent(
      FetchMoreDataEvent event, Emitter<ProductState> emit) async {
    try {
      final products =
          await productRepo.fetchAllProductsWithPagingnation(_skip, _limit);
      if (products.isNotEmpty) {
        _products.addAll(products);
        _skip += _limit;
        emit(ProductLoadedState(products: _products));
      }
    } catch (e) {
      
      emit(ProductErrorState(msg: e.toString()));
    }
  }
}
