import 'package:flutter/foundation.dart';
import 'package:galeri_teknologi_bersama/data/local/bio.sqlite.dart';
import 'package:galeri_teknologi_bersama/data/model/bio.dart';
import 'package:galeri_teknologi_bersama/utils/result_state.dart';

class DatabaseProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  DatabaseProvider({this.databaseHelper}) {
    _getBookmarks();
  }

  ResultState _state;
  ResultState get state => _state;

  String _message = '';
  String get message => _message;

  List<Bio> _bookmarks = [];
  List<Bio> get bookmarks => _bookmarks;

  void _getBookmarks() async {
    _bookmarks = await databaseHelper.getData();
    if (_bookmarks.length > 0) {
      _state = ResultState.HasData;
    } else {
      _state = ResultState.NoData;
      _message = 'Empty Data';
    }
    notifyListeners();
  }

  void addBookmark(Bio bio) async {
    try {
      await databaseHelper.insertData(bio);
      _getBookmarks();
    } catch (e) {
      _state = ResultState.Error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }

  Future<bool> isBookmarked(String url) async {
    final bookmared = await databaseHelper.getDataByUnique(url);
    return bookmared.isNotEmpty;
  }

  void removeBookmark(String url) async {
    try {
      await databaseHelper.removeData(url);
      _getBookmarks();
    } catch (e) {
      _state = ResultState.Error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }
}
