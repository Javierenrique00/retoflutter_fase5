

import 'package:apistorepackage/infraestructure/api/public/store/interface/store_api_interface.dart';
import 'package:apistorepackage/model/product/product_model.dart';
import 'package:flutter/material.dart';

class PdpViewModel extends ChangeNotifier {
  PdpViewModel({ required this.storeApi});
  StoreApiInterface storeApi;

  var hasValidProductDetail = false;
  var hasErrorProductDetail = false;
  ProductModel? productDetail;

  void getProductDetail(int id) async {
    hasValidProductDetail = false;
    hasErrorProductDetail = false;
    notifyListeners();
    final productEither = await storeApi.getSingleProduct(id);
    productEither.fold(
    (l){
      hasValidProductDetail = false;
      hasErrorProductDetail = true;
      notifyListeners();
    },
    (r){
      hasValidProductDetail = true;
      hasErrorProductDetail = false;
      productDetail = r;
      notifyListeners();
    });
  }

}