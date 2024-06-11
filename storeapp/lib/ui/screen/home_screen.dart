import 'package:atomicdesign/ui/atom/clothes_svg_atom.dart';
import 'package:atomicdesign/ui/page/initial_page.dart';
import 'package:atomicdesign/ui/page/lobby_page.dart';
import 'package:atomicdesign/ui/page/register_page.dart';
import 'package:atomicdesign/ui/template/app_wbar_template.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/viewmodel/home_session_viewmodel.dart';
import '../navigation/navigation.dart';
import 'home_promotions/home_promotions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeSessionViewModel>(
      builder: (context, viewModel, child) {
        if (!viewModel.hasShownAppLogo) {
          viewModel.getCart();
          Future.delayed(const Duration(seconds: 2), () {
            viewModel.setHasShownApplogo();
          });
        }
        viewModel.requireSession();
        if (!viewModel.hasShownAppLogo) return const InitalPage();
        final greeting = viewModel.session?.firstName ?? "";
        final content = viewModel.session != null
            ? LobbyPage(
                categoriesNames: const ['Product Categories', 'Search','Help'],
                categoriesWidgets: const [ClothesSvgAtom(), Icon(Icons.search),Icon(Icons.help_outline_rounded)],
                onClickCategories: (id) {
                  switch (id) {
                    case 0:
                      Navigator.pushNamed(context, Navigation.categoriesScreen);
                    case 1:
                      Navigator.pushNamed(context, Navigation.searchScreen);
                    case 2:
                      Navigator.pushNamed(context, Navigation.helpScreen);
                  }
                },
                promotionItems: HomePromotions().promotionItems,
                onClickPromotion: (int index) {
                  Navigator.pushNamed(context, Navigation.detailScreen,
                      arguments: index + 1);
                },
                bigPromotionItems: HomePromotions().bigPromotionItems,
                onClickBigPromotion: (index) {
                  Navigator.pushNamed(context, Navigation.detailScreen,
                      arguments: index + 1);
                },
              )
            : Registerpage(
                register: ((firstName, lastName, email, pwd) {
                  viewModel.setSession(firstName, lastName, email, pwd);
                }),
              );

        return AppWbarTemplate(
            title: 'Welcome: $greeting',
            counter: viewModel.totalCartItems.toString(),
            onCLickCounter: () =>
                Navigator.pushNamed(context, Navigation.cartScreen),
            child: content);
      },
    );
  }
}
