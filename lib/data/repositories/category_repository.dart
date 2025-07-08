import 'package:shop_me/core/constants/app_apis.dart';
import 'package:shop_me/core/exceptions/app_exception.dart';
import 'package:shop_me/data/models/category_response.dart';
import 'package:shop_me/data/services/network/remote/dio_client.dart';
import 'package:shop_me/data/services/network/result_state.dart';

abstract class CategoryRepository {
  Future<ResultState<List<Category>>> fetchCategories();
}

class CategoryRepositoryImpl implements CategoryRepository {
  final DioClient dioClient;

  CategoryRepositoryImpl(this.dioClient);

  @override
  Future<ResultState<List<Category>>> fetchCategories() async {
    try {
      await dioClient.get(url: AppApis.categories);

      // final List<Category> categories = response.data['categories']
      //     .map<Category>((category) => Category.fromJson(category))
      //     .toList();

      final categoryResponse = CategoryResponse.fromJson(_categoryData);

      return ResultSuccess(data: categoryResponse.categories!);
    } catch (e) {
      return ResultFailed(exception: AppException.fromException(e));
    }
  }

  final Map<String, dynamic> _categoryData = {
    "status": "SUCCESS",
    "message": "We have 6 categories to choose from.",
    "categories": [
      {
        "name": "TV",
        "url":
            "https://cdn.pixabay.com/photo/2015/02/07/20/58/tv-627876_1280.jpg",
      },
      {
        "name": "Laptop",
        "url":
            "https://cdn.pixabay.com/photo/2020/10/21/18/07/laptop-5673901_1280.jpg",
      },
      {
        "name": "Audio",
        "url":
            "https://cdn.pixabay.com/photo/2020/04/15/14/45/microphone-5046876_1280.jpg",
      },
      {
        "name": "Mobile",
        "url":
            "https://cdn.pixabay.com/photo/2016/11/29/12/30/phone-1869510_1280.jpg",
      },
      {
        "name": "Gaming",
        "url":
            "https://cdn.pixabay.com/photo/2020/10/01/16/53/game-controller-5619105_1280.jpg",
      },
      {
        "name": "Appliances",
        "url":
            "https://cdn.pixabay.com/photo/2014/12/14/16/05/laundry-saloon-567951_1280.jpg",
      },
    ],
  };
}
