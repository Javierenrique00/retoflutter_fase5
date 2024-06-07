import 'package:atomicdesign/domain/model/promotion_ui_model.dart';
import 'package:atomicdesign/ui/atom/clothes_svg_atom.dart';
import 'package:atomicdesign/ui/page/initial_page.dart';
import 'package:atomicdesign/ui/page/lobby_page.dart';
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
            ? LobbyPage(categoriesNames: const ['Product Categories','Search'], categoriesWidgets: const [ClothesSvgAtom(),Icon(Icons.search)], onClickCategories:(id) {
              switch (id){
                case 0: Navigator.pushNamed(context, Navigation.categoriesScreen);
                case 1: Navigator.pushNamed(context, Navigation.searchScreen);
              }
            }, promotionItems: [
              PromotionUiModel(flagStr: '10%', imgWidget: Image.network('https://picsum.photos/id/292/300/300')),
              PromotionUiModel(flagStr: '20%', imgWidget: Image.network('https://picsum.photos/id/293/300/300')),
              PromotionUiModel(flagStr: '30%', imgWidget: Image.network('https://picsum.photos/id/294/300/300')),
              PromotionUiModel(flagStr: '40%', imgWidget: Image.network('https://picsum.photos/id/295/300/300')),
              PromotionUiModel(flagStr: '50%', imgWidget: Image.network('https://picsum.photos/id/296/300/300')),
            ], onClickPromotion: (int index) {
              Navigator.pushNamed(context, Navigation.detailScreen,arguments: index + 1);
              },)
            : Registerpage(
                register: ((firstName, lastName, email, pwd) {
                  viewModel.setSession(firstName, lastName, email, pwd);
                }),
              );

        return AppWbarTemplate(title: 'Welcome: $greeting', counter: viewModel.totalCartItems.toString(), onCLickCounter: () => Navigator.pushNamed(context, Navigation.cartScreen), child: content);
      },
    );
  }
}