import 'package:apistorepackage/model/product/product_model.dart';
import 'package:atomicdesign/domain/model/pdp_ui_model.dart';
import 'package:atomicdesign/ui/page/loading_page.dart';
import 'package:atomicdesign/ui/page/pdp_page.dart';
import 'package:atomicdesign/ui/page/try_again_page.dart';
import 'package:atomicdesign/ui/template/app_wbar_template.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/viewmodel/home_session_viewmodel.dart';
import '../common/utils.dart';
import '../navigation/navigation.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool hasInit = false;

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments as int;

    return Consumer<HomeSessionViewModel>(
      builder: (context, viewModel, child) {
        if (!hasInit) {
          viewModel.getProductDetail(id);
          viewModel.getAllProducts();
          viewModel.getCart();
          hasInit = true;
        }
        return Consumer<HomeSessionViewModel>(builder: (context, sessionViewModel, child){
          return AppWbarTemplate(
          title: 'PDP',
          counter: sessionViewModel.totalCartItems.toString(),
          onCLickCounter:() => Navigator.pushNamed(context, Navigation.cartScreen),
          child: showDetail(
              viewModel.productDetail,
              viewModel.hasValidProductDetail && viewModel.hasValidProducts,
              viewModel.hasErrorProductDetail || viewModel.hasErrorProducts, () {
            viewModel.getProductDetail(id);
          },(id){
            sessionViewModel.addToCart(id);
          }),
        );
        },);
      },
    );
  }

  Widget showDetail(
    ProductModel? product,
    bool isValid,
    bool hasError,
    Function() onPressedRetry,
    Function (int id) addToCart
  ) {
    if (hasError) {
      return TryAgainPage(onPressed: onPressedRetry());
    } else if (isValid) {
      if (product == null) return TryAgainPage(onPressed: onPressedRetry());
      return PdpPage(
        detail: PdpUiModel(
          id: product.id,
          title: product.title,
          price: Utils.convCurrency(product.price),
          description: product.description,
          category: product.category,
          image: product.image,
        ),
        addToCart:(id) => addToCart(id),
      );
    } else {
      return const LoadingPage();
    }
  }
}
