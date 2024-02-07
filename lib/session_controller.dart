import 'package:firebase_auth/firebase_auth.dart';

class SessionController {
  static final SessionController _session = SessionController._internal();
  dynamic userId = ''; // Make it non-nullable


  void setUserId(dynamic id) {
    userId = id;

  }



  // Method to get user ID
  dynamic getUserId() {
    return userId;
  }

  factory SessionController() {
    return _session;
  }

  SessionController._internal();

// Method to set user ID


}
