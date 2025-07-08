import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_me/config/di/service_locator.dart';
import 'package:shop_me/config/routes/app_routes.dart';
import 'package:shop_me/data/repositories/category_repository.dart';
import 'package:shop_me/data/repositories/product_repository.dart';
import 'package:shop_me/presentation/view_models/category_view_model.dart';
import 'package:shop_me/presentation/view_models/product_view_model.dart';
import 'package:shop_me/presentation/views/dashboard_view.dart';

void main() {
  setUpDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProductViewModel(getIt<ProductRepository>()),
        ),

        ChangeNotifierProvider(
          create: (_) => CategoryViewModel(getIt<CategoryRepository>()),
        ),
      ],
      child: MaterialApp.router(
        title: 'Shop Me',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        routerConfig: AppRoutes.router,
      ),
    );
  }
}
