import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shop_me/core/exceptions/app_exception.dart';
import 'package:shop_me/data/models/product_response.dart';
import 'package:shop_me/data/repositories/product_repository.dart';
import 'package:shop_me/data/services/network/result_state.dart';

import 'product_repository_test.mocks.dart';

@GenerateMocks([ProductRepository])
void main() {
  late ProductRepository productRepository;

  setUpAll(() {
    productRepository = MockProductRepository();

    provideDummy<ResultState<List<Product>>>(ResultSuccess(data: []));
  });

  group("This is product repository unit test", () {
    test("This is test for fetchProducts if success", () async {
      final List<Product> products = [
        Product(
          id: 1,
          title: "Product 1",
          price: 10,
          description: "Description 1",
          category: "Category 1",
          image: "Image 1",
        ),

        Product(
          id: 2,
          title: "Product 2",
          price: 12,
          description: "Description 1",
          category: "Category 2",
          image: "Image 2",
        ),
      ];

      when(
        productRepository.fetchProducts(),
      ).thenAnswer((_) async => ResultSuccess(data: products));

      final result = await productRepository.fetchProducts();

      expect(result, isA<ResultState<List<Product>>>());
      expect(result.data, products);

      verify(productRepository.fetchProducts()).called(1);
      verifyNoMoreInteractions(productRepository);
    });

    test("This is test for fetchProducts if failure", () async {
      final exception = DioException(
        requestOptions: RequestOptions(path: "products"),
        error: "Server Error! Please after some time",
      );

      when(productRepository.fetchProducts()).thenAnswer(
        (_) async =>
            ResultFailed(exception: AppException.fromException(exception)),
      );

      final result = await productRepository.fetchProducts();

      expect(result, isA<ResultFailed>());
      expect(result.exception, isA<AppException>());

      verify(productRepository.fetchProducts()).called(1);
    });
  });
}
