import 'package:atomicdesign/ui/foundation/colors_foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/viewmodel/init_session_viewmodel.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<InitSessionViewModel>(
      builder: (context, viewModel, child) {

        viewModel.requireSession();
        final greeting = viewModel.session?.firstName?? "";

        return Scaffold(
          appBar: AppBar(
            title: Text("Welcome: $greeting"),
            backgroundColor: ColorsFoundation.basicAppbarBackgroundColor,
          ),
          body: const Text('Home'),
        );
      },
    );
  }
}
