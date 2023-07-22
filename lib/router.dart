import 'package:backend_prac/feature/admin/screen/add_product_screen.dart';
import 'package:backend_prac/feature/auth/screens/auth_screen.dart';
import 'package:backend_prac/feature/product_details_screens/screens/product_details_screen.dart';
import 'package:backend_prac/feature/home/screens/category_deal_screen.dart';
import 'package:backend_prac/feature/home/screens/home_screen.dart';
import 'package:backend_prac/feature/search/screens/search_screen.dart';
import 'package:backend_prac/models/product.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRouteTry(RouteSettings routeSettingsTry) {
  switch (routeSettingsTry.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(builder: (_) => const AuthScreen());
    case HomeScreen.routeName:
      return MaterialPageRoute(builder: (_) => const HomeScreen());
    case AddProductScreen.routeName:
      return MaterialPageRoute(builder: (_) => const AddProductScreen());
    case CategoryDealScreen.routeName:
      var category = routeSettingsTry.arguments as String;
      return MaterialPageRoute(
        settings: routeSettingsTry,
        builder: (_) => CategoryDealScreen(
          category: category,
        ),
      );
    case SearchScreen.routeName:
      var searchQuery = routeSettingsTry.arguments as String;
      return MaterialPageRoute(
        settings: routeSettingsTry,
        builder: (_) => SearchScreen(
          searchQuery: searchQuery,
        ),
      );
    case ProductDetailScreen.routeName:
      var product = routeSettingsTry.arguments as Product;
      return MaterialPageRoute(
          builder: (_) => ProductDetailScreen(product: product));
    default:
      return MaterialPageRoute(
          builder: (_) => const Scaffold(
                body: Center(child: Text('ERROR!!')),
              ));
  }
}
