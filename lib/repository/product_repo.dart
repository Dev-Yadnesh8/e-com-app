import 'package:dio/dio.dart';
import 'package:e_com_app/models/product_model.dart';

class ProductRepo {
  final Dio _dio = Dio();
  static const _url = 'http://dummyjson.com/products';

  Future<List<Product>> fetchAllProductsWithPagingnation(
      int skip, int limit) async {
    try {
      final res = await _dio.get(_url, queryParameters: {
        'skip': skip,
        'limit': limit,
      });

      if (res.statusCode == 200) {
        // Safely checking if 'products' is null
        if (res.data['products'] != null) {
          final products = (res.data['products'] as List)
              .map((product) => Product.fromJson(product))
              .toList();
          return products;
        } else {
          throw Exception("No products found in the response");
        }

      } else {
        throw Exception("Failed to fetch products: ${res.statusCode}");
      }
    } catch (e) {
      throw Exception("Error fetching products: $e");
    }
  }
}
