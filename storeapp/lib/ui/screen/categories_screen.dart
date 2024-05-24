import 'package:atomicdesign/domain/model/product_ui_model.dart';
import 'package:atomicdesign/ui/foundation/colors_foundation.dart';
import 'package:atomicdesign/ui/page/list_product_page.dart';
import 'package:atomicdesign/ui/page/loading_page.dart';
import 'package:atomicdesign/ui/page/try_again_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/viewmodel/home_session_viewmodel.dart';
import '../navigation/navigation.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  bool hasInit = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeSessionViewModel>(
      builder: (context, viewModel, child) {
        if (!hasInit) {
          viewModel.getAllDataForCategories();
          hasInit = true;
        }

        return Scaffold(
            appBar: AppBar(
              title: const Text("Categories"),
              backgroundColor: ColorsFoundation.basicAppbarBackgroundColor,
            ),
            body: showData(viewModel.productsUi, viewModel.hasValidProducts && viewModel.hasValidCategories,
                viewModel.hasErrorProducts || viewModel.hasErrorProducts, () => null, (id) {
                  print('--- id$id');
                  Navigator.pushNamed(context, Navigation.detailScreen,arguments: viewModel.products[id]);
                }, viewModel.categories,(id){
                  if(id == 0){
                    viewModel.getAllProducts();
                  }
                  else{
                    viewModel.getDataForCategory(viewModel.categories[id]);
                  }
                },));
      },
    );
  }

  Widget showData(
      List<ProductUiModel> products,
      bool hasValidData,
      bool hasError,
      Function() onPressedRetry,
      Function(int id) onPressedItem,
      List<String> categories,
      Function(int id) onClickCategories
      ) {
    print('hasError:$hasError hasValidData:$hasValidData');
    if (hasError) {
      return TryAgainPage(onPressed: onPressedRetry());
    } else if (hasValidData) {
      return ListProductPage(
            products: products,
            shrinkWrap: false,
            onClick: (id) => onPressedItem(id),
            categories: categories,
            onClickCategories: (int id) => onClickCategories(id),
          );
    } else {
      return const LoadingPage();
    }
  }
}
