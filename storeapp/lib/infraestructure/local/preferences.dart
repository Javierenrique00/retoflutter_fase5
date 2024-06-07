import 'dart:convert' as convert;

import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/model/local_cart_model/local_cart_model.dart';
import '../../domain/model/local_cart_model/mapper/local_cart_model_mapper.dart';
import '../../domain/model/local_session_model/local_session_model.dart';
import '../../domain/model/local_session_model/mapper/local_session_model_mapper.dart';
import 'preferences_interface.dart';

class Preferences implements PreferencesInterface {
  Preferences();

  SharedPreferences? prefs;

  @override
  Future<LocalSessionModel?> getLocalSession() async {
      try {
        prefs ??= await SharedPreferences.getInstance();
        final str = prefs?.getString('local_session');
        if(str == null) return null;
        final sessionConv = convert.jsonDecode(str) as Map<String, dynamic>;
        final localSession = localSessionModelFromJsonMapper(sessionConv);
        return localSession;
      }catch(error){
        return null;
      }
    }

  @override
  void setLocalSessionModel(LocalSessionModel session) async {
    final strMap = localSessionModelToJsonMapper(session);
    final jsonStr = convert.jsonEncode(strMap);
    prefs ??= await SharedPreferences.getInstance();
    prefs?.setString('local_session', jsonStr);
  }

  @override
  void deleteSessionModel() async {
    prefs ??= await SharedPreferences.getInstance();
    prefs?.remove('local_session');
  }

  @override
  Future<List<LocalCartModel>?> getLocalCart() async {
      try {
        prefs ??= await SharedPreferences.getInstance();
        var str = prefs?.getString('local_cart');
        if(str == null) return null;
        final cartListConv = convert.jsonDecode(str); //as List<dynamic>;
        final List<LocalCartModel> resultList = [];
        for(final element in cartListConv){
            final conv = localCartModelFromJsonMapper(element);
            resultList.add(conv);
        }
        return resultList;
      }catch(error){
        return null;
      }
  }

  @override
  void setLocalCart(List<LocalCartModel> cart) async {
    final strMap = cart.map((e) => convert.jsonEncode(localCartModelToJsonMapper(e))).toList().toString();
    //final jsonStr = convert.jsonEncode(strMap);
    prefs ??= await SharedPreferences.getInstance();
    prefs?.setString('local_cart', strMap);
  }

  @override
  void deleteLocalCart() async {
    prefs ??= await SharedPreferences.getInstance();
    prefs?.remove('local_cart');
  }


  
}