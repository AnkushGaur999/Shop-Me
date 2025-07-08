import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_me/core/utils/data_state.dart';
import 'package:shop_me/data/models/category_response.dart';
import 'package:shop_me/presentation/view_models/category_view_model.dart';
import 'package:shop_me/presentation/views/products_view.dart';

class CategoryView extends StatefulWidget {
  const CategoryView({super.key});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Categories"), centerTitle: true),

      body: Consumer(
        builder: (context, CategoryViewModel categoryViewModel, child) {
          if (categoryViewModel.categoryState is LoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (categoryViewModel.categoryState is ErrorState) {
            return Center(
              child: Text(
                (categoryViewModel.categoryState as ErrorState).message,
              ),
            );
          } else if (categoryViewModel.categoryState is SuccessState) {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              padding: const EdgeInsets.all(16),
              itemCount:
                  (categoryViewModel.categoryState as SuccessState).data.length,
              itemBuilder: (context, index) {
                final category =
                    (categoryViewModel.categoryState as SuccessState)
                            .data[index]
                        as Category;
                return Card(
                  elevation: 4,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ProductsView(category: category.name!),
                        ),
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network(
                          category.url!,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(height: 10),
                        Text(category.name!),
                      ],
                    ),
                  ),
                );
              },
            );
          }

          return SizedBox();
        },
      ),
    );
  }
}
