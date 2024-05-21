import 'package:flutter/material.dart';

import '../screen/home_screen.dart';
import '../screen/init_screen.dart';
import 'navigation.dart';

Map<String, Widget Function(BuildContext)> get appRoutes {
        return {
          Navigation.initScreen : (context) => const InitScreen(),
          Navigation.homeScreen :(context) => const HomeScreen(), 
        };
      }