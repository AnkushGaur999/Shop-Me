import 'package:flutter/widgets.dart';
import 'package:shop_me/core/utils/data_state.dart';
import 'package:shop_me/data/models/product_response.dart';
import 'package:shop_me/data/repositories/product_repository.dart';
import 'package:shop_me/data/services/network/result_state.dart';

class ProductViewModel extends ChangeNotifier {
  final ProductRepository _productRepository;

  ProductViewModel(this._productRepository) {
    fetchProducts();
  }

  int page = 1;
  DataState<List<Product>> productsState = InitialState();

  DataState<Product> productDetailsState = InitialState();

  DataState<List<Product>> getProductsByCategoryState = InitialState();

  Future<void> fetchProducts() async {
    productsState = LoadingState();
    notifyListeners();

    final result = await _productRepository.fetchProducts();
    if (result is ResultSuccess) {
      productsState = SuccessState(result.data!);
    } else {
      productsState = ErrorState(result.exception!.message);
    }
    notifyListeners();
  }

  Future<void> getProductsByCategory(String category) async {
    getProductsByCategoryState = LoadingState();
    notifyListeners();

    final result = await _productRepository.getProductsByCategory(category);
    if (result is ResultSuccess) {
      getProductsByCategoryState = SuccessState(result.data!);
    } else {
      getProductsByCategoryState = ErrorState(result.exception!.message);
    }
    notifyListeners();
  }

  Future<void> getProductDetails(int productId) async {
    productDetailsState = LoadingState();
    notifyListeners();

    final result = await _productRepository.getProductDetails(productId);
    if (result is ResultSuccess) {
      productDetailsState = SuccessState(result.data!);
    } else {
      productDetailsState = ErrorState(result.exception!.message);
    }
    notifyListeners();
  }
}
