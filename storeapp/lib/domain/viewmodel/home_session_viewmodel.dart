import 'package:apistorepackage/infraestructure/api/public/store/interface/store_api_interface.dart';
import 'package:apistorepackage/model/product/product_model.dart';
import 'package:atomicdesign/domain/model/product_ui_model.dart';
import 'package:flutter/material.dart';

import '../../infraestructure/local/preferences_interface.dart';
import '../../ui/common/utils.dart';
import '../model/local_session_model/local_session_model.dart';

class HomeSessionViewModel extends ChangeNotifier {
  HomeSessionViewModel({required this.pref, required this.storeApi});

  PreferencesInterface pref;
  StoreApiInterface storeApi;

  LocalSessionModel? session;
  bool hasCheckedSession = false;
  bool hasShownAppLogo = false;
  List<ProductModel> products = [];
  List<ProductUiModel> productsUi = [];
  var hasValidProducts = false;
  var hasErrorProducts = false;

  var hasValidCategories = false;
  var hasErrorCategories = false;
  List<String> categories = [];


  void requireSession() async {
    if (!hasCheckedSession) {
      hasCheckedSession = true;
      _getSession();
    }
  }

  void setHasShownApplogo() {
    hasShownAppLogo = true;
    notifyListeners();
  }

  void setSession(
      String firstName, String lastName, String email, String pwd) async {
    final sessionLocal = LocalSessionModel(
        email: email,
        firstName: firstName,
        lastName: lastName,
        isLoged: true,
        pwd: pwd);
    pref.setLocalSessionModel(sessionLocal);
    session = sessionLocal;
    notifyListeners();
  }

  void _getSession() async {
    session = await pref.getLocalSession();
    notifyListeners();
  }

  void _deleteSession() async {
    pref.deleteSessionModel();
  }

  void getDataForCategory(String category) async {
    hasErrorProducts = false;
    hasValidProducts = false;
    notifyListeners();
    final productsEither = await storeApi.getAllProductsFromCategory(category);
    productsEither.fold(
    (l){
      hasErrorProducts = true;
      hasValidProducts = false;
      notifyListeners();
    },
    (r){
      hasErrorProducts = false;
      hasValidProducts = true;
      products.clear();
      productsUi.clear();
      products.addAll(r);
      final productsUiTemp =  products.map((e) => ProductUiModel(id: e.id, urlImage: e.image, name: e.title, price: Utils.convCurrency(e.price) )).toList();
      productsUi.addAll(productsUiTemp);
      notifyListeners();
    });
  }


  void getAllDataForCategories() async {
    final allCategories = await storeApi.getAllCategories();
    allCategories.fold(
      (l){
          hasValidCategories = false;
          hasErrorCategories = true;
          notifyListeners();
    },
     (r){
      categories.clear();
      categories.add("All");
      categories.addAll(r);
      hasValidCategories = true;
      hasErrorCategories = false;
      notifyListeners();
    });
    getAllProducts();
  }

  void getAllProducts() async{
    hasErrorProducts = false;
    hasValidProducts = false;
    notifyListeners();
    final allProductsEither = await storeApi.getAllProducts();
    allProductsEither.fold(
      (l) {
        hasValidProducts = false;
        hasErrorProducts = true;
        notifyListeners();
      },
      (r) {
        products.clear();
        productsUi.clear();
        products.addAll(r);
        final productsUiTemp =  products.map((e) => ProductUiModel(id: e.id, urlImage: e.image, name: e.title, price: Utils.convCurrency(e.price) )).toList();
        productsUi.addAll(productsUiTemp);
        hasErrorProducts = false;
        hasValidProducts = true;
        notifyListeners();
      },
    );
  }


}
