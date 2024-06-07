import 'package:atomicdesign/domain/model/product_ui_model.dart';
import 'package:atomicdesign/ui/page/loading_page.dart';
import 'package:atomicdesign/ui/page/search_page.dart';
import 'package:atomicdesign/ui/page/try_again_page.dart';
import 'package:atomicdesign/ui/template/app_wbar_template.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/viewmodel/home_session_viewmodel.dart';
import '../navigation/navigation.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool hasInit = false;
  String searchStr = '';

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeSessionViewModel>(
      builder: (context, viewModel, child) {
        if (!hasInit) {
          viewModel.getAllProducts();
          hasInit = true;
        }
        return AppWbarTemplate(
          title: 'Search',
          counter: viewModel.totalCartItems.toString(),
          onCLickCounter: () =>
              Navigator.pushNamed(context, Navigation.cartScreen),
          child: showDetail(
              viewModel.productsUi,
              viewModel.hasValidProducts,
              viewModel.hasErrorProducts,
              () => null,
              (id) =>Navigator.pushNamed(context, Navigation.detailScreen, arguments:viewModel.productsUi[id].id),
              searchStr,
              (textInput){
                searchStr = textInput;
                viewModel.filterProducts(textInput);
              }),
        );
      },
    );
  }

  Widget showDetail(
    List<ProductUiModel> products,
    bool hasValidData,
    bool hasError,
    Function() onPressedRetry,
    Function(int id) onPressedItem,
    String searchStr,
    Function(String textInput) onTextChanged,
  ) {
    if (hasError) {
      return TryAgainPage(onPressed: onPressedRetry());
    } else if (hasValidData) {
      final filteredProducts = searchStr.isEmpty? <ProductUiModel>[]:products;
      return SearchPage(
        products: filteredProducts,
        onItemClick: (id) => onPressedItem(id),
        onTextChanged: (textChanged) => onTextChanged(textChanged),
      );
    } else {
      return const LoadingPage();
    }
  }
}
