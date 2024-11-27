import 'package:dio/dio.dart';
import 'package:e_com_app/models/product_model.dart';

class ProductRepo {
  final Dio _dio = Dio();

  static const _url = 'https://dummyjson.com/products';

  Future<ProductModel> fetchAllProducts() async {
    try {
      final res = await _dio.get(_url);

      if (res.statusCode == 200) {
        return ProductModel.fromJson(res.data);
      } else {
        throw Exception("Failed to fetch products: ${res.statusCode}");
      }
    } catch (e) {
      // Re-throw the error for the calling code to handle
      throw Exception("Error fetching products: $e");
    }
  }
}
