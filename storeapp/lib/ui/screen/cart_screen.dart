import 'package:atomicdesign/domain/model/product_ui_model.dart';
import 'package:atomicdesign/ui/page/cart_page.dart';
import 'package:atomicdesign/ui/page/loading_page.dart';
import 'package:atomicdesign/ui/page/try_again_page.dart';
import 'package:atomicdesign/ui/template/app_wbar_template.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/viewmodel/home_session_viewmodel.dart';
import '../common/utils.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool hasInit = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeSessionViewModel>(
      builder: (context, viewModel, child) {

      if(!hasInit){
        viewModel.getAllProducts();
        hasInit = true;
      }

      return AppWbarTemplate(
        title: 'Cart',
         counter: viewModel.totalCartItems.toString(),
        onCLickCounter: (){},
        child: showData(
          viewModel.cartDetailsUi,
          viewModel.cartQtys,
          viewModel.hasValidProducts,
          viewModel.hasErrorProducts,
          () => null,
          (index) =>viewModel.restToCart(viewModel.cart[index].id),
          (index) => viewModel.addToCart(viewModel.cart[index].id),
          Utils.convCurrency(viewModel.totalCartPrice)));
      },);
  }

  Widget showData(
      List<ProductUiModel> products,
      List<int> qtys,
      bool hasValidData,
      bool hasError,
      Function() onPressedRetry,
      Function (int index) onClickMinus,
      Function (int index) onClickPlus,
      String totalPrice
  ){
    if(hasError){
      return TryAgainPage(onPressed: onPressedRetry());
    } else if (hasValidData) {
      return CartPage(products: products, qtys: qtys, clickOnMinus:(index) => onClickMinus(index), clickOnPlus:(index) => onClickPlus(index), totalPrice: totalPrice,);
    } else {
      return const LoadingPage();
    }


  }


}