import 'package:flutter/material.dart';

import '../screen/categories_screen.dart';
import '../screen/detail_screen.dart';
import '../screen/home_screen.dart';
import 'navigation.dart';

Map<String, Widget Function(BuildContext)> get appRoutes {
        return {
          Navigation.homeScreen :(context) => const HomeScreen(),
          Navigation.categoriesScreen :(context) => const CategoriesScreen(),
          Navigation.searchScreen :(context) => const HomeScreen(),
          Navigation.detailScreen :(context) => const DetailScreen(),
          Navigation.cartScreen :(context) => const HomeScreen(),
        };
      }