import 'package:go_router/go_router.dart';
import 'package:shop_me/presentation/views/dashboard_view.dart';
import 'package:shop_me/presentation/views/home_view.dart';
import 'package:shop_me/presentation/views/product_details_view.dart';
import 'package:shop_me/presentation/views/products_view.dart';

class AppRoutes {
  static const String dashboard = "dashboard";
  static const String home = "home";
  static const String products = "products";
  static const String productDetails = "product-details";

  static const String _dashboard = '/';
  static const String _home = '/home';
  static const String _products = '/products/:category';
  static const String _productDetails = '/product-details/:productId';

  static final GoRouter router = GoRouter(
    initialLocation: _dashboard,
    routes: [
      GoRoute(
        name: dashboard,
        path: _dashboard,
        builder: (context, state) => const DashboardView(),
      ),

      GoRoute(path: _home, builder: (context, state) => const HomeView()),

      GoRoute(
        name: products,
        path: _products,
        builder: (context, state) =>
            ProductsView(category: state.pathParameters["category"]!),
      ),

      GoRoute(
        name: productDetails,
        path: _productDetails,
        builder: (context, state) => ProductDetailsView(
          productId: int.tryParse(state.pathParameters["productId"]!)!,
        ),
      ),
    ],
  );
}
