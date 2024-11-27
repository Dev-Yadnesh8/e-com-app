import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:e_com_app/models/product_model.dart';
import 'package:e_com_app/repository/product_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepo productRepo;
  ProductBloc(this.productRepo) : super(ProductInitialState()) {
    // fetching initial products
    on<FetchInitDataEvent>(fetchInitDataEvent);
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
      print(e);
      emit(ProductErrorState());
    }
  }

  FutureOr<void> cartButtonClickEvent(
      CartButtonClickEvent event, Emitter<ProductState> emit) {
    emit(NavigateToCartActionState());
  }
}
