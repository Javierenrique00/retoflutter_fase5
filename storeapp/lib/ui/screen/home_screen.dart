import 'package:atomicdesign/ui/page/initial_page.dart';
import 'package:atomicdesign/ui/page/register_page.dart';
import 'package:atomicdesign/ui/template/app_wbar_template.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/viewmodel/home_session_viewmodel.dart';
import '../navigation/navigation.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeSessionViewModel>(
      builder: (context, viewModel, child) {

        if(!viewModel.hasShownAppLogo) {
          Future.delayed(const Duration(seconds: 2), () {
          viewModel.setHasShownApplogo();  
          });
        }
        viewModel.requireSession();
        if(!viewModel.hasShownAppLogo) return const InitalPage();
        final greeting = viewModel.session?.firstName ?? "";
        final content = viewModel.session != null
            ? TextButton(onPressed: ()=> Navigator.pushNamed(context, Navigation.categoriesScreen), child: const Text('Goto categories'),)
            : Registerpage(
                register: ((firstName, lastName, email, pwd) {
                  viewModel.setSession(firstName, lastName, email, pwd);
                }),
              );

        return AppWbarTemplate(title: 'Welcome: $greeting', counter: '3', onCLickCounter: (){}, child: content);
      },
    );
  }
}
