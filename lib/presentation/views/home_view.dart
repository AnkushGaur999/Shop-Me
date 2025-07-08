import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_me/core/utils/data_state.dart';
import 'package:shop_me/presentation/view_models/product_view_model.dart';
import 'package:shop_me/presentation/widgets/product/product_item.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue.shade900,
        centerTitle: true,
      ),
      body: Consumer<ProductViewModel>(
        builder: (context, ProductViewModel productViewModel, _) {
          if (productViewModel.productsState is LoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          if (productViewModel.productsState is ErrorState) {
            return Center(
              child: Text(
                (productViewModel.productsState as ErrorState).message,
              ),
            );
          }

          if (productViewModel.productsState is SuccessState) {
            return ListView.builder(
              itemCount:
                  (productViewModel.productsState as SuccessState).data.length,
              itemBuilder: (context, index) {
                final product = (productViewModel.productsState as SuccessState)
                    .data[index];
                return ProductItem(product: product);
              },
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}
