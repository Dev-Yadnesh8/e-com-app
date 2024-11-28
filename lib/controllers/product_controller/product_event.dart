part of 'product_bloc.dart';

@immutable
abstract class ProductEvent {}

class FetchInitDataEvent extends ProductEvent {}
class FetchMoreDataEvent extends ProductEvent {}

class CartButtonClickEvent extends ProductEvent {}


