

import 'package:flutter/material.dart';

import '../../infraestructure/local/preferences_interface.dart';
import '../model/local_session_model/local_session_model.dart';

class InitSessionViewModel extends ChangeNotifier {
  InitSessionViewModel({required this.pref});

  PreferencesInterface pref;
  LocalSessionModel? session;
  bool hasCheckedSession = false;




  void requireSession() async {
    if(!hasCheckedSession){
      hasCheckedSession = true;
      _getSession();
    }
  }


  void navigateToHome(){
    
  }

  void setSession(String firstName,String lastName,String email,String pwd) async {
    final sessionLocal = LocalSessionModel(email: email, firstName: firstName, lastName: lastName, isLoged: true, pwd: pwd);
    pref.setLocalSessionModel(sessionLocal);
    notifyListeners();
  }

  void _getSession() async {
    session = await pref.getLocalSession();
    notifyListeners();
  }

  void _deleteSession() async {
    pref.deleteSessionModel();
  }

}