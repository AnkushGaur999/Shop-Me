import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shop_me/core/exceptions/app_exception.dart';
import 'package:shop_me/data/models/category_response.dart';
import 'package:shop_me/data/repositories/category_repository.dart';
import 'package:shop_me/data/services/network/result_state.dart';
import 'category_repository_test.mocks.dart';

@GenerateMocks([CategoryRepository])
void main() {
  late CategoryRepository repository;

  setUpAll(() {
    provideDummy<ResultState<List<Category>>>(ResultSuccess(data: []));
    repository = MockCategoryRepository();
  });

  group("This is test the category repository", () {
    test("This is use to fetch categories if success", () async {
      final List<Category> categories = [
        Category(
          name: "TV",
          url:
              "https://cdn.pixabay.com/photo/2015/02/07/20/58/tv-627876_1280.jpg",
        ),
        Category(
          name: "Laptop",
          url:
              "https://cdn.pixabay.com/photo/2020/10/21/18/07/laptop-5673901_1280.jpg",
        ),

        Category(
          name: "Audio",
          url:
              "https://cdn.pixabay.com/photo/2020/04/15/14/45/microphone-5046876_1280.jpg",
        ),
      ];

      when(
        repository.fetchCategories(),
      ).thenAnswer((_) async => ResultSuccess(data: categories));

      final result = await repository.fetchCategories();
      expect(result, isA<ResultState<List<Category>>>());
      expect(result.data, categories);

      verify(repository.fetchCategories()).called(1);
      verifyNoMoreInteractions(repository);
    });

    test("This is use to fetch categories if failure", () async {
      final exception = DioException(
        requestOptions: RequestOptions(path: "categories"),
        message: "Server Error",
      );

      when(repository.fetchCategories()).thenAnswer(
        (_) async =>
            ResultFailed(exception: AppException.fromException(exception)),
      );

      final result = await repository.fetchCategories();
      expect(result, isA<ResultFailed>());
      expect(result.exception, isA<AppException>());

      verify(repository.fetchCategories()).called(1);
      verifyNoMoreInteractions(repository);
    });
  });
}
