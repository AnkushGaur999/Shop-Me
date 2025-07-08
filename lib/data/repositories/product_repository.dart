import 'package:shop_me/core/constants/app_apis.dart';
import 'package:shop_me/data/services/network/result_state.dart';
import '../../core/exceptions/app_exception.dart';
import '../models/product_response.dart';
import '../services/network/remote/dio_client.dart';

abstract class ProductRepository {
  /// Fetch products from the API
  Future<ResultState<List<Product>>> fetchProducts();

  Future<ResultState<List<Product>>> getProductsByCategory(String category);

  /// Fetch product details from the API
  Future<ResultState<Product>> getProductDetails(int productId);
}

class ProductRepositoryImpl implements ProductRepository {
  final DioClient _dioClient;

  ProductRepositoryImpl(this._dioClient);

  @override
  Future<ResultState<List<Product>>> fetchProducts() async {
    try {
      final response = await _dioClient.get(url: AppApis.products);
      final List<Product> products = (response.data["products"] as List)
          .map((e) => Product.fromJson(e))
          .toList();
      return ResultSuccess(data: products);
    } catch (e) {
      return ResultFailed(exception: AppException.fromException(e));
    }
  }

  @override
  Future<ResultState<List<Product>>> getProductsByCategory(
    String category,
  ) async {
    try {
      final queryParameters = {"type": category.toLowerCase()};

      final response = await _dioClient.get(
        url: "${AppApis.products}/category",
        queryParameters: queryParameters,
      );

      final List<Product> products = (response.data["products"] as List)
          .map((e) => Product.fromJson(e))
          .toList();

      return ResultSuccess(data: products);
    } catch (e) {
      return ResultFailed(exception: AppException.fromException(e));
    }
  }

  @override
  Future<ResultState<Product>> getProductDetails(int productId) async {
    try {
      final response = await _dioClient.get(
        url: "${AppApis.products}/$productId",
      );
      final Product product = Product.fromJson(response.data["product"]);
      return ResultSuccess(data: product);
    } catch (e) {
      return ResultFailed(exception: AppException.fromException(e));
    }
  }
}
