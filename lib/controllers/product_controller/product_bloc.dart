import 'dart:async';


import 'package:e_com_app/models/product_model.dart';
import 'package:e_com_app/repository/product_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepo productRepo;
  ProductBloc(this.productRepo) : super(ProductInitialState()) {
    // fetching initial products
    on<FetchInitDataEvent>(fetchInitDataEvent);

    // clicking cart button on appbar for navigation to cart page
    on<CartButtonClickEvent>(cartButtonClickEvent);
  }

  // method for fetching initial data event
  FutureOr<void> fetchInitDataEvent(
      FetchInitDataEvent event, Emitter<ProductState> emit) async {
    emit(ProductLoadingState());
    try {
      final products = await productRepo.fetchAllProducts();
      emit(ProductLoadedState(products: products.products.toList()));
    } catch (e) {
      emit(ProductErrorState(msg: e.toString()));
    }
  }
// method for cart button on appbar for navigation to cart page
  FutureOr<void> cartButtonClickEvent(
      CartButtonClickEvent event, Emitter<ProductState> emit) {
    emit(NavigateToCartActionState());
  }
}
