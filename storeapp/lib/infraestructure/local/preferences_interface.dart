

import '../../domain/model/local_session_model/local_session_model.dart';

abstract class PreferencesInterface {

  Future<LocalSessionModel?> getLocalSession();
  void setLocalSessionModel(LocalSessionModel session);
  void deleteSessionModel();

}