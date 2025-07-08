import 'package:get_it/get_it.dart';
import 'package:shop_me/data/repositories/category_repository.dart';
import 'package:shop_me/data/repositories/product_repository.dart';
import 'package:shop_me/data/services/network/remote/dio_client.dart';

final GetIt getIt = GetIt.instance;

Future<void> setUpDependencies() async {
  getIt.registerLazySingleton(() => DioClient());
  getIt.registerFactory<ProductRepository>(
    () => ProductRepositoryImpl(getIt<DioClient>()),
  );

  getIt.registerFactory<CategoryRepository>(
    () => CategoryRepositoryImpl(getIt<DioClient>()),
  );
}
