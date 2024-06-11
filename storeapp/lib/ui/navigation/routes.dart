import 'package:flutter/material.dart';

import '../screen/cart_screen.dart';
import '../screen/categories_screen.dart';
import '../screen/detail_screen.dart';
import '../screen/help_screen.dart';
import '../screen/home_screen.dart';
import '../screen/search_screen.dart';
import 'navigation.dart';

Map<String, Widget Function(BuildContext)> get appRoutes {
        return {
          Navigation.homeScreen :(context) => const HomeScreen(),
          Navigation.categoriesScreen :(context) => const CategoriesScreen(),
          Navigation.searchScreen :(context) => const SearchScreen(),
          Navigation.detailScreen :(context) => const DetailScreen(),
          Navigation.cartScreen :(context) => const CartScreen(),
          Navigation.helpScreen :(context) => const HelpScreen(),
        };
      }