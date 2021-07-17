import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:galeri_teknologi_bersama/data/api/firebase/firebase.service.dart';
import 'package:galeri_teknologi_bersama/data/model/userdata.dart';
import 'package:galeri_teknologi_bersama/utils/result_state.dart';

class FirebaseProvider extends ChangeNotifier {
  final FirebaseService firebaseService;

  FirebaseProvider({
    this.firebaseService,
  }) {
    //_fetchListOfRestaurant();
  }

  bool _isLogin = false;
  bool get isLogin => _isLogin;

  UserData _userData;
  UserData get userData => _userData;

  ResultState _state;
  ResultState get state => _state;

  Future<dynamic> get fetchisLogin => _fetchisLogin();
  Future<dynamic> get fetchdataUser => _fetchdataUser();

  Future<dynamic> _fetchisLogin() async {
    try {
      final result = await firebaseService.isLogin();

      if (result == null) {
        notifyListeners();
      } else {
        notifyListeners();
        _isLogin = result;
      }
    } catch (e) {
      // notifyListeners();
      //print('something wrong..');
    }
  }

  Future<UserData> _fetchdataUser() async {
    try {
      final result = await firebaseService.dataUser();

      if (result == null) {
        _state = ResultState.NoData;

        notifyListeners();
      } else {
        _state = ResultState.HasData;

        notifyListeners();
        _userData = result;
      }
    } catch (e) {
      _state = ResultState.Error;
      //  notifyListeners();
      //  print('something wrong..');
    }
  }
}
