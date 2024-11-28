import 'package:e_com_app/controllers/cart_controller/cart_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderTotalWidget extends StatelessWidget {
  const OrderTotalWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
          padding: const EdgeInsets.all(
              16.0), // Add padding around the footer content
          child: Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 10.0), // Padding for content inside the container
            decoration: BoxDecoration(
              color: Colors.white, // White background for the container
              borderRadius: BorderRadius.circular(15), // Rounded corners
              boxShadow: [
                BoxShadow(
                  color:
                      Colors.black.withOpacity(0.1), // Light shadow for depth
                  offset: const Offset(0, 4), // Shadow offset
                  blurRadius: 10, // Blur radius for smooth shadow effect
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment
                  .spaceBetween, // Spread items across the width
              children: [
                const Text(
                  "Order Total:",
                  style: TextStyle(
                    fontSize: 18, // Larger font size for better readability
                    fontWeight: FontWeight.bold, // Bold text
                  ),
                ),
                Text(
                  '\$${context.watch<CartBloc>().totalPrice.toStringAsFixed(2)}', // Price formatted to two decimal places
                  style: const TextStyle(
                    fontSize: 20, // Larger font size for the price
                    fontWeight: FontWeight.bold, // Bold for emphasis
                    color: Colors.green, // Color to make it look like a total
                  ),
                ),
              ],
            ),
          ),
        );
  }
}