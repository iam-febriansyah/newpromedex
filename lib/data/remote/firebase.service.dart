import 'package:firebase_auth/firebase_auth.dart';
import 'package:galeri_teknologi_bersama/data/model/userdata.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> isLogin() async {
    final response = _auth.currentUser;
    if (response != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<UserData> dataUser() async {
    final response = _auth.currentUser;

    if (response != null) {
      final UserData userData = new UserData();

      userData.displayName = _auth.currentUser.displayName != null
          ? _auth.currentUser.displayName
          : "";
      userData.email =
          _auth.currentUser.email != null ? _auth.currentUser.email : "";
      userData.uid = _auth.currentUser.uid;
      userData.phoneNumber = _auth.currentUser.phoneNumber != null
          ? _auth.currentUser.phoneNumber
          : "";
      userData.photoUrl = _auth.currentUser.photoURL;
      userData.providerId = "";

      return userData;
    } else {
      throw Exception('Failed to load');
    }
  }
}
