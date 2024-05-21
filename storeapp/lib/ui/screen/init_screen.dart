import 'package:atomicdesign/ui/foundation/colors_foundation.dart';
import 'package:atomicdesign/ui/organism/register_organism.dart';
import 'package:atomicdesign/ui/page/initial_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/viewmodel/init_session_viewmodel.dart';
import '../navigation/navigation.dart';

class InitScreen extends StatefulWidget {
  const InitScreen({super.key});

  @override
  State<InitScreen> createState() => _InitScreenState();
}

class _InitScreenState extends State<InitScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome to JR Fast Store"),
        backgroundColor: ColorsFoundation.basicAppbarBackgroundColor,
      ),
      body: Consumer<InitSessionViewModel>(
        builder: (context, viewModel, child) {
          viewModel.requireSession();

          Future.delayed(const Duration(seconds: 2), () {
            if(viewModel.session != null) {
              Navigator.pushNamed(context, Navigation.homeScreen);
            }
          });

          return viewModel.session != null ? const InitalPage() : RegisterOrganism(
        register: ((firstName, lastName, email, pwd) {
          viewModel.setSession(firstName, lastName, email, pwd);
          Navigator.pushNamed(context, Navigation.homeScreen);
        }),
      ) ;
        },
      ),
    );
  }


}
