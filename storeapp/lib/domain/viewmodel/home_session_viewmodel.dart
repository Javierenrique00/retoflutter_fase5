import 'package:apistorepackage/infraestructure/api/public/store/interface/store_api_interface.dart';
import 'package:apistorepackage/model/product/product_model.dart';
import 'package:atomicdesign/domain/model/product_ui_model.dart';
import 'package:flutter/material.dart';

import '../../infraestructure/local/preferences_interface.dart';
import '../../ui/common/utils.dart';
import '../model/local_cart_model/local_cart_model.dart';
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

  var hasValidProductDetail = false;
  var hasErrorProductDetail = false;
  ProductModel? productDetail;

  var hasValidCategories = false;
  var hasErrorCategories = false;
  List<String> categories = [];

  var isRequestingCart = false;
  List<LocalCartModel> cart = [];
  int totalCartItems = 0;
  List<ProductUiModel> cartDetailsUi = [];
  double totalCartPrice = 0;
  List<int> cartQtys = [];


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
        calcCartDetails();
        final productsUiTemp =  products.map((e) => ProductUiModel(id: e.id, urlImage: e.image, name: e.title, price: Utils.convCurrency(e.price) )).toList();
        productsUi.addAll(productsUiTemp);
        hasErrorProducts = false;
        hasValidProducts = true;
        notifyListeners();
      },
    );
  }

  void addToCart(int id) async {
    isRequestingCart = true;
    final respCart =  await pref.getLocalCart();
    if(respCart!=null){
      final index = respCart.indexWhere((element) => element.id == id);
      if(index>=0){
        respCart[index] = LocalCartModel(id: id, qty: respCart[index].qty + 1);
      }else{
        respCart.add(LocalCartModel(id: id, qty: 1));
      }
      cart.clear();
      cart.addAll(respCart);
    }else{
      cart.clear();
      cart.add(LocalCartModel(id: id, qty: 1));
    }
    calcCartDetails();
    totalCartItems =  cart.fold(0, (previousValue, element) => previousValue + element.qty);
    isRequestingCart = false;
    pref.setLocalCart(cart);
    notifyListeners();
  }

  void restToCart(int id) async {
    isRequestingCart = true;
    final respCart =  await pref.getLocalCart();
    if(respCart!=null){
      final index = respCart.indexWhere((element) => element.id == id);
      if(index>=0){
        if(respCart[index].qty == 1){
          respCart.removeAt(index);
        }else{
          respCart[index] = LocalCartModel(id: id, qty: respCart[index].qty - 1);
        }
      }
      cart.clear();
      cart.addAll(respCart);
    }else{
      cart.clear();
      cart.add(LocalCartModel(id: id, qty: 1));
    }
    calcCartDetails();
    totalCartItems =  cart.fold(0, (previousValue, element) => previousValue + element.qty);
    isRequestingCart = false;
    pref.setLocalCart(cart);
    notifyListeners();
  }

  void getCart() async {
    isRequestingCart = true;
    final respCart =  await pref.getLocalCart();
    if(respCart!=null){
      cart.clear();
      cart.addAll(respCart);
    }
    totalCartItems =  cart.fold(0, (previousValue, element) => previousValue + element.qty);
    isRequestingCart = false;
    notifyListeners();

  }

  void calcCartDetails(){
    final productMap = cart.asMap().map((key, value) => MapEntry(value.id, products.firstWhere((element) => element.id == value.id)));
    final qtyMap = cart.asMap().map((key, value) => MapEntry(value.id, value.qty));
    final cartToAdd = cart.map((e) => ProductUiModel(id: e.id, urlImage: productMap[e.id]!.image, name: productMap[e.id]!.title, price: Utils.convCurrency(productMap[e.id]!.price))).toList();
    totalCartPrice = productMap.values.toList().fold(0.0, (previousValue, element) => previousValue + qtyMap[element.id]!*element.price);
    cartQtys = cart.map((e) => e.qty).toList();
    cartDetailsUi.clear();
    cartDetailsUi.addAll(cartToAdd);
  }

  void filterProducts(String searchItem ){
    if(searchItem.length>2){
      final search = searchItem.toLowerCase();
      final elements = products.where((element) => element.title.toLowerCase().contains(search) || element.description.toLowerCase().contains(search)).toList();
      final productsUiTemp =  elements.map((e) => ProductUiModel(id: e.id, urlImage: e.image, name: e.title, price: Utils.convCurrency(e.price) )).toList();
      productsUi.clear();
      productsUi.addAll(productsUiTemp);
    }else{
      productsUi.clear();
    }
    notifyListeners();

  }

}
