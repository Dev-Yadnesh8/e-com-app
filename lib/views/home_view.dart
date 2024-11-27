import 'package:e_com_app/controllers/product_controller/product_bloc.dart';
import 'package:e_com_app/models/product_model.dart';
import 'package:e_com_app/views/cart_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ProductBloc>().add(FetchInitDataEvent());
    
    return BlocConsumer<ProductBloc, ProductState>(
      listenWhen: (previous, current) => current is ProductActionState,
      buildWhen: (previous, current) => current is! ProductActionState,
      listener: (context, state) {
        if (state is NavigateToCartActionState) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CartView(),
              ));
        }
      },
      builder: (context, state) {
        if (state is ProductLoadingState) {
          return Scaffold(
              appBar: _myAppBar(context),
              body: const Center(
                child: CircularProgressIndicator(),
              ));
        } else if (state is ProductLoadedState) {
          return Scaffold(
  appBar: _myAppBar(context),
  body: Padding(
    padding: const EdgeInsets.all(8.0),
    child: GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Two items per row
        crossAxisSpacing: 8.0, // Space between columns
        mainAxisSpacing: 8.0, // Space between rows
        childAspectRatio: 0.7, // Aspect ratio for a card-like design
      ),
      itemCount: state.products.length,
      itemBuilder: (context, index) {
        final Product product = state.products[index];
        return Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Thumbnail Image
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                child: Image.network(
                  product.thumbnail,
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const Spacer(),
              // Product Title
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: Text(
                  product.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 2,
                ),
              ),
              // Product Category
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  product.category.toString().split('.').last.toUpperCase(),
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),
              ),
              // Price and Rating Row
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${product.price.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          size: 14,
                          color: Colors.orange,
                        ),
                        Text(
                          product.rating.toString(),
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Spacer(),
            ],
          ),
        );
      },
    ),
  ),
);

        } else if (state is ProductErrorState) {
          return Scaffold(
              appBar: _myAppBar(context),
              body: const Column(
                children: [],
              ));
        }
        return Container();
      },
    );
  }

  PreferredSizeWidget _myAppBar(BuildContext context) {
    return AppBar(
      title: const Text("Ecommerce Catalog App"),
      actions: [
        IconButton(
            onPressed: () {
              context.read<ProductBloc>().add(CartButtonClickEvent());
            },
            icon: const Icon(Icons.shopping_cart_outlined))
      ],
    );
  }
}
