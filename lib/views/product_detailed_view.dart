import 'package:e_com_app/controllers/cart_controller/cart_bloc.dart';
import 'package:e_com_app/controllers/product_controller/product_bloc.dart';
import 'package:e_com_app/models/product_model.dart';
import 'package:e_com_app/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:badges/badges.dart' as badges;

class ProductDetailedView extends StatelessWidget {
  final Product product;

  const ProductDetailedView({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final double discountedPrice =
        product.price - (product.price * (product.discountPercentage / 100));

    return Scaffold(
      appBar: _myAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image (with rounded corners)
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: CachedNetworkImage(
                  imageUrl: product.thumbnail,
                  height: 350,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              const SizedBox(height: 16),

              // Product Title (more modern style with max lines)
              Text(
                product.title,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.2,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),

              // Product Category (modern font weight and spacing)
              Text(
                'Category: ${product.category.toString().split('.').last}',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 8),

              // Product Description (with proper margin)
              Text(
                product.description,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 16),

              // Price and Discount Information (aligned with icons and more spacing)
              Row(
                children: [
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '\$${discountedPrice.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Discount Percentage (highlighted in red)
              Text(
                '${product.discountPercentage.toStringAsFixed(0)}% OFF',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              const SizedBox(height: 16),

              // Rating and Review Information (modern icon design)
              Row(
                children: [
                  const Icon(
                    Icons.star_rate_rounded,
                    size: 22,
                    color: Colors.orange,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    product.rating.toStringAsFixed(1),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '(${product.reviews.length} reviews)',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Specifications Section with better formatting
              const Divider(),
              const SizedBox(height: 8),
              const Text(
                "Product Specifications",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              _buildSpecificationRow("Brand", product.brand.toString()),
              _buildSpecificationRow("Weight", product.weight.toString()),
              _buildSpecificationRow("Dimensions",
                  "H:${product.dimensions.height}, W:${product.dimensions.width}"),
                  const SizedBox(height: 10,),
              // stock of product
              Text(
                product.stock > 10 ? "In Stock" : "Hurry up, only a few left",
                style: TextStyle(
                  fontSize: 18, // Adjust font size
                  fontWeight: FontWeight.bold,
                  color: product.stock > 10
                      ? Colors.green
                      : Colors.red, // Green if in stock, red otherwise
                ),
              ),


              const SizedBox(height: 16),

              // Add to Cart Button (more modern color and rounded edges)
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    context
                        .read<CartBloc>()
                        .add(AddProductToCart(product: product));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurpleAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(30), // Rounded corners
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    "Add to Cart",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Reviews Section
              const Divider(),
              const Text(
                "Customer Reviews",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              ..._buildReviewsSection(),
            ],
          ),
        ),
      ),
    );
  }

  // Build Specification Row with modern font styling
  Widget _buildSpecificationRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(
            "$title: ",
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Build the reviews section
  List<Widget> _buildReviewsSection() {
    return product.reviews.map((review) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15), // Rounded corners
          ),
          elevation: 4,
          shadowColor: Colors.grey.withOpacity(0.3), // Light shadow
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      review.reviewerName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.star_rate_rounded,
                      color: Colors.orange,
                      size: 20,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      review.rating.toString(),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  review.comment,
                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                ),
                const SizedBox(height: 8),
                Text(
                  "${review.date.toLocal()}".split(' ')[0],
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      );
    }).toList();
  }

  // app bar
  PreferredSizeWidget _myAppBar(BuildContext context) {
    return CustomAppBar(
      title: const Text("Product Details"),
       leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.adaptive.arrow_back)),
      actions: [
        InkWell(
          borderRadius: BorderRadius.circular(50),
          onTap: () {
            context.read<ProductBloc>().add(CartButtonClickEvent());
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: BlocBuilder<CartBloc, CartState>(
              builder: (context, state) {
                final cartCount = state is CartLoadedState
                    ? state.cartProducts.length
                    : 0; // Access the cart product count from the state.
                return badges.Badge(
                  badgeContent: Text(
                    cartCount.toString(),
                    style: const TextStyle(color: Colors.white),
                  ),
                  child: const Icon(Icons.shopping_cart_outlined),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
