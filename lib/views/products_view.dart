import 'package:e_com_app/controllers/cart_controller/cart_bloc.dart';
import 'package:e_com_app/controllers/product_controller/product_bloc.dart';
import 'package:e_com_app/models/product_model.dart';
import 'package:e_com_app/views/cart_view.dart';
import 'package:e_com_app/widgets/custom_app_bar.dart';
import 'package:e_com_app/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:badges/badges.dart' as badges;

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final ScrollController _scrollController = ScrollController();
  


  @override
  void initState() {
    _tabController =
        TabController(length: 6, vsync: this); // 1 for All + 4 categories
    context.read<ProductBloc>().add(FetchInitDataEvent());
    _scrollController.addListener(_scrollListener); // Add listener to the scroll controller

    super.initState();
  }

    // Detect when the user has scrolled to the bottom
  void _scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      context.read<ProductBloc>().add(FetchMoreDataEvent());
    }
  }


  @override
  void dispose() {
    _scrollController.dispose(); // Dispose of the scroll controller
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
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
          return _loadingStateWidget();
        } else if (state is ProductLoadedState) {
          return _loadedStateWidget(state);
        } else if (state is ProductErrorState) {
          return _errorStateWidget(state);
        }
        return Container();
      },
    );
  }

  // Loading State Widget
  Widget _loadingStateWidget() {
    return Scaffold(
      appBar: _myAppBar(context),
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  // Error State Widget
  Widget _errorStateWidget(ProductErrorState state) {
    return Scaffold(
        appBar: _myAppBar(context),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(state.msg),
          ),
        ));
  }

  // Loaded State Widget
  Widget _loadedStateWidget(ProductLoadedState state) {
    return Scaffold(
      appBar: _myAppBar(context),
      body: TabBarView(
        controller: _tabController,
        children: [
          // "All" Tab for all products
          _buildProductGridView(state.products),
          // Category-specific views
          _buildProductGridView(state.products
              .where((product) => product.category == 'beauty')
              .toList()),
          _buildProductGridView(state.products
              .where((product) => product.category == 'fragrances')
              .toList()),
          _buildProductGridView(state.products
              .where((product) => product.category == 'furniture')
              .toList()),
          _buildProductGridView(state.products
              .where((product) => product.category == 'groceries')
              .toList()),
              _buildProductGridView(state.products
              .where((product) => product.category == 'laptops')
              .toList()),
        ],
      ),
    );
  }

  // Method to build the product grid view
  Widget _buildProductGridView(List<Product> products) {
    return products.isEmpty ? const Center(child: Text("No Data!!"),) :  Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        controller: _scrollController,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          childAspectRatio: 0.6,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final Product product = products[index];
          return ProductCardWidget(product: product);
        },
      ),
    );
  }

  // AppBar
PreferredSizeWidget _myAppBar(BuildContext context) {
  return CustomAppBar(
    title: const Text("Ecommerce Catalog App"),
    bottom: TabBar(
      tabAlignment: TabAlignment.start,
      isScrollable: true,
      controller: _tabController, // Link the TabController
      indicatorColor: Colors.white, // Color for the selected tab indicator
      indicatorWeight: 4.0, // Thicker indicator line
      labelColor: Colors.white, // Color of the selected tab label
      unselectedLabelColor: Colors.white70, // Color for unselected tab labels
      labelStyle: const TextStyle(
        fontWeight: FontWeight.bold, // Bold text for selected tab
        fontSize: 16,
      ),
      unselectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.normal, // Regular text for unselected tabs
        fontSize: 14,
      ),
      tabs: const [
        Tab(text: "All"),
        Tab(text: "Beauty"),
        Tab(text: "Fragrances"),
        Tab(text: "Furniture"),
        Tab(text: "Groceries"),
        Tab(text: "Laptops"),
      ],
    ),
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
              final cartCount =
                  state is CartLoadedState ? state.cartProducts.length : 0; // Access the cart product count from the state.
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
