import 'package:flutter/widgets.dart';
import 'package:shop_me/core/utils/data_state.dart';
import 'package:shop_me/data/models/category_response.dart';
import 'package:shop_me/data/repositories/category_repository.dart';
import 'package:shop_me/data/services/network/result_state.dart';

class CategoryViewModel extends ChangeNotifier {
  final CategoryRepository categoryRepository;

  CategoryViewModel(this.categoryRepository) {
    fetchCategories();
  }

  DataState<List<Category>> _categoryState = InitialState();

  DataState<List<Category>> get categoryState => _categoryState;

  Future<void> fetchCategories() async {
    _categoryState = LoadingState();
    notifyListeners();

    final response = await categoryRepository.fetchCategories();

    if (response is ResultSuccess) {
      _categoryState = SuccessState(response.data!);
    } else {
      _categoryState = ErrorState(response.exception!.message);
    }

    notifyListeners();
  }
}
