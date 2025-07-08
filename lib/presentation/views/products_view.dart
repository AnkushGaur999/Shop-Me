import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_me/core/utils/data_state.dart';
import 'package:shop_me/presentation/view_models/product_view_model.dart';
import 'package:shop_me/presentation/widgets/product/product_item.dart';

class ProductsView extends StatefulWidget {
  final String category;

  const ProductsView({super.key, required this.category});

  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
  bool _isDataFetched = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_isDataFetched) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Provider.of<ProductViewModel>(
          context,
          listen: false,
        ).getProductsByCategory(widget.category);
        _isDataFetched = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ProductViewModel>(
        builder: (context, productViewModel, child) {
          if (productViewModel.getProductsByCategoryState is LoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          if (productViewModel.getProductsByCategoryState is ErrorState) {
            return Center(
              child: Text(
                (productViewModel.getProductsByCategoryState as ErrorState)
                    .message,
              ),
            );
          }

          if (productViewModel.getProductsByCategoryState is SuccessState) {
            return Column(
              children: [
                AppBar(
                  title: Text(
                    widget.category.toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  backgroundColor: Colors.blue.shade900,
                ),

                Flexible(
                  child: ListView.builder(
                    itemCount: (productViewModel.productsState as SuccessState)
                        .data
                        .length,
                    itemBuilder: (context, index) {
                      final product =
                          (productViewModel.productsState as SuccessState)
                              .data[index];
                      return ProductItem(product: product);
                    },
                  ),
                ),
              ],
            );
          }

          return SizedBox.shrink();
        },
      ),
    );
  }
}
