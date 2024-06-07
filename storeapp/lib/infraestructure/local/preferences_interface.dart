

import '../../domain/model/local_cart_model/local_cart_model.dart';
import '../../domain/model/local_session_model/local_session_model.dart';

abstract class PreferencesInterface {

  Future<LocalSessionModel?> getLocalSession();
  void setLocalSessionModel(LocalSessionModel session);
  void deleteSessionModel();

  Future<List<LocalCartModel>?> getLocalCart();
  void setLocalCart(List<LocalCartModel> cart);
  void deleteLocalCart();

}