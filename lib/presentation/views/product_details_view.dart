import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_me/core/utils/data_state.dart';
import 'package:shop_me/data/models/product_response.dart';
import 'package:shop_me/presentation/view_models/product_view_model.dart';

class ProductDetailsView extends StatefulWidget {
  final int productId;

  const ProductDetailsView({super.key, required this.productId});

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  bool _isDataFetched = false; // Flag to p

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isDataFetched) {
      // Ensure it's safe to use context.read here
      // If ProductViewModel is provided above this widget in the tree, this is fine.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<ProductViewModel>().getProductDetails(widget.productId);
        _isDataFetched = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ProductViewModel>(
        builder: (context, ProductViewModel productViewModel, child) {
          print(
            "Product Details View state: ${productViewModel.productDetailsState}",
          );

          if (productViewModel.productDetailsState is LoadingState) {
            return const Center(child: CircularProgressIndicator());
          }

          if (productViewModel.productDetailsState is ErrorState) {
            return Center(
              child: Text(
                (productViewModel.productDetailsState as ErrorState).message,
              ),
            );
          }

          if (productViewModel.productDetailsState is SuccessState) {
            final product =
                (productViewModel.productDetailsState as SuccessState).data
                    as Product;
            final price = product.price!;
            final discount = product.discount!;
            final discountedPrice = price - (price * discount / 100);

            return Scaffold(
              appBar: AppBar(title: Text(product.title!)),
              body: SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Image
                    Hero(
                      tag: "product-image",
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          product.image!,
                          height: 250,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: 16),

                    // Product Title
                    Text(
                      product.title!,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),

                    // Price & Discount
                    Row(
                      children: [
                        Text(
                          "\$${discountedPrice.toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 8),
                        if (discount > 0)
                          Text(
                            "\$${price.toStringAsFixed(2)}",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        SizedBox(width: 8),
                        if (discount > 0)
                          Text(
                            "-${discount.toInt()}%",
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: 16),

                    // Description
                    Text(
                      "Description",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      product.description!,
                      style: TextStyle(fontSize: 15, color: Colors.grey[800]),
                    ),
                    SizedBox(height: 20),

                    // Other Details
                    Text(
                      "Brand: ${product.brand!.toString().toUpperCase()}",
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      "Model: ${product.model!}",
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      "Color: ${product.color!}",
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      "Category: ${product.category!}",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            );
          }

          return SizedBox.shrink();
        },
      ),
    );
  }
}
