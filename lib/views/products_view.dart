import 'package:e_com_app/controllers/product_controller/product_bloc.dart';
import 'package:e_com_app/models/product_model.dart';
import 'package:e_com_app/views/cart_view.dart';
import 'package:e_com_app/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    _tabController =
        TabController(length: 5, vsync: this); // 1 for All + 4 categories
    context.read<ProductBloc>().add(FetchInitDataEvent());
    super.initState();
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
              .where((product) => product.category == Category.BEAUTY)
              .toList()),
          _buildProductGridView(state.products
              .where((product) => product.category == Category.FRAGRANCES)
              .toList()),
          _buildProductGridView(state.products
              .where((product) => product.category == Category.FURNITURE)
              .toList()),
          _buildProductGridView(state.products
              .where((product) => product.category == Category.GROCERIES)
              .toList()),
        ],
      ),
    );
  }

  // Method to build the product grid view
  Widget _buildProductGridView(List<Product> products) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          childAspectRatio: 0.7,
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
    return AppBar(
      title: const Text("Ecommerce Catalog App"),
      bottom: TabBar(
        tabAlignment: TabAlignment.start,
        isScrollable: true,
        controller: _tabController, // link the TabController
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
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {
            context.read<ProductBloc>().add(CartButtonClickEvent());
          },
          icon: const Icon(Icons.shopping_cart_outlined),
        )
      ],
    );
  }
}