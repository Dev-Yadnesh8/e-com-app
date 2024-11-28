import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_com_app/controllers/cart_controller/cart_bloc.dart';
import 'package:e_com_app/models/product_model.dart';
import 'package:e_com_app/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            return ListView.builder(
              itemCount: state.cartProducts.length,
              itemBuilder: (context, index) {
                final Product product = state.cartProducts[index];
                final double discountedPrice = product.price -
                    (product.price * (product.discountPercentage / 100));
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 170,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          offset: const Offset(0, 4),
                          blurRadius: 8,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(10)),
                            child: CachedNetworkImage(
                              imageUrl: product.thumbnail,
                              height: 150,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error), // Handling error
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                          child: VerticalDivider(
                            thickness: 0.5,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  product.title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '\$${product.price.toStringAsFixed(2)}',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.grey,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      '\$${discountedPrice.toStringAsFixed(2)}',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  '${product.discountPercentage.toStringAsFixed(0)}% OFF',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                  ),
                                ),
                                Row(
                                  children: [
                                    const Text("Qty:"),
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(Icons.remove),
                                    ),
                                    Text("1"),
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(Icons.add),
                                    ),
                                  ],
                                ),
                                InkWell(
                                    onTap: () {},
                                    child: const Text("Remove",
                                        style: TextStyle(
                                            color: Colors.deepPurpleAccent))),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return Container();
        },
        listener: (context, state) {},
      ),
    );
  }
}
