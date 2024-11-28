import 'package:e_com_app/controllers/cart_controller/cart_bloc.dart';
import 'package:e_com_app/models/cart_item_model.dart';
import 'package:e_com_app/widgets/cart_product_tile.dart';
import 'package:e_com_app/widgets/custom_app_bar.dart';
import 'package:e_com_app/widgets/order_total_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterAlignment: AlignmentDirectional.topCenter,
     floatingActionButton: const OrderTotalWidget(),
     floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: CustomAppBar(
        title: const Text("Cart"),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.adaptive.arrow_back)),
      ),
      body: BlocConsumer<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoadedState) {
            return state.cartProducts.isEmpty
                ? const Center(
                    child: Text("No Products Added Yet!!"),
                  )
                : ListView.builder(
                    itemCount: state.cartProducts.length,
                    itemBuilder: (context, index) {
                      final CartItem product = state.cartProducts[index];
                      return CartProductTileWidget(cartItem: product);
                    },
                  );
          } else if (state is CartInitialState) {
            return const Center(
              child: Text("No Products Added Yet!!"),
            );
          }
          return Container();
        },
        listener: (context, state) {},
      ),
    );
  }
}
