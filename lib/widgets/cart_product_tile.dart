import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_com_app/controllers/cart_controller/cart_bloc.dart';
import 'package:e_com_app/models/cart_item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartProductTileWidget extends StatelessWidget {
  final CartItem cartItem;
  const CartProductTileWidget({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    final double discountedPrice = cartItem.product.price - (cartItem.product.price * (cartItem.product.discountPercentage / 100));
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
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(10)),
                child: CachedNetworkImage(
                  imageUrl: cartItem.product.thumbnail,
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
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      cartItem.product.title,
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
                          '\$${cartItem.product.price.toStringAsFixed(2)}',
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
                      '${cartItem.product.discountPercentage.toStringAsFixed(0)}% OFF',
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
                          onPressed: () {
                            context.read<CartBloc>().add(DecrementProductQty(productId: cartItem.product.id));
                          },
                          icon: const Icon(Icons.remove),
                        ),
                        Text(cartItem.quantity.toString()),
                        IconButton(
                          onPressed: () {
                            context.read<CartBloc>().add(IncrementProductQty(productId: cartItem.product.id));
                          },
                          icon: const Icon(Icons.add),
                        ),
                      ],
                    ),
                    InkWell(
                        onTap: () {
                          context.read<CartBloc>().add(RemoveProductFromCart(productId: cartItem.product.id));
                        },
                        child: const Text("Remove",
                            style: TextStyle(color: Colors.deepPurpleAccent))),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
