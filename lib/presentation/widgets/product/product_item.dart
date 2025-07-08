import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_me/data/models/product_response.dart';
import 'package:shop_me/presentation/view_models/product_view_model.dart';
import 'package:shop_me/presentation/views/product_details_view.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Material(
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            // Navigate to ProductDetailsView
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    ProductDetailsView(productId: product.id!),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                // Product Image
                Hero(
                  tag: "product-image",
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      product.image ?? '',
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.image_not_supported, size: 100),
                    ),
                  ),
                ),

                const SizedBox(width: 16),

                // Product Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Text(
                        product.title ?? 'No Title',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                      ),

                      const SizedBox(height: 6),

                      // Brand & Model
                      Text(
                        '${product.brand ?? 'Brand'} - ${product.model ?? 'Model'}',
                        style: const TextStyle(color: Colors.grey),
                      ),

                      // Color
                      Text(
                        'Color: ${product.color ?? 'N/A'}',
                        style: const TextStyle(color: Colors.grey),
                      ),

                      const SizedBox(height: 6),

                      // Price and Discount
                      Row(
                        children: [
                          Text(
                            '₹${product.price?.toString() ?? '0'}',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.green,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 10),
                          if ((product.discount ?? 0) > 0)
                            Text(
                              '${product.discount}% OFF',
                              style: const TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
